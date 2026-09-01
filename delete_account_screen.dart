import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/typography.dart';
import '../../../core/auth/models/deletion_request.dart';
import '../../../core/auth/providers/auth_provider.dart';
import '../../../core/services/audio_service.dart';
import '../../../core/services/haptics_service.dart';

class DeleteAccountScreen extends ConsumerStatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  ConsumerState<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends ConsumerState<DeleteAccountScreen> {
  bool _isLoading = true;
  bool _isSubmitting = false;
  bool _isCancelling = false;
  DeletionRequest? _currentRequest;

  // Form State
  String? _selectedReason;
  final _feedbackController = TextEditingController();
  bool _confirmedCheckbox = false;

  final List<String> _reasons = [
    '🎮 Taking a break from gaming',
    '🔒 Privacy & data concerns',
    '🔄 Want to start fresh',
    '🐞 App issues / Bugs',
    '✨ Other reason',
  ];

  @override
  void initState() {
    super.initState();
    _fetchStatus();
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _fetchStatus() async {
    setState(() => _isLoading = true);
    final authService = ref.read(authServiceProvider);
    final res = await authService.fetchDeletionStatus();
    if (mounted) {
      setState(() {
        _isLoading = false;
        _currentRequest = res.hasPendingRequest ? res.request : null;
      });
    }
  }

  Future<void> _handleSubmitRequest() async {
    if (_selectedReason == null || !_confirmedCheckbox) return;

    ref.read(audioServiceProvider).playSfx('assets/common/audio/tap.wav');
    ref.read(hapticsServiceProvider).mediumImpact();

    // Confirmation dialog before submitting
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: RushBoxColors.surfaceCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.warning_amber_rounded, color: RushBoxColors.error, size: 24),
            SizedBox(width: 8),
            Text(
              'Confirm Deletion',
              style: TextStyle(fontWeight: FontWeight.w900, color: RushBoxColors.textPrimary, fontSize: 18),
            ),
          ],
        ),
        content: const Text(
          'Your account will enter a 10-day grace period. After 10 days, all game progress, RB points, coins, and levels will be permanently wiped.\n\nAre you sure you want to proceed?',
          style: RushBoxTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('GO BACK', style: TextStyle(fontWeight: FontWeight.w700, color: RushBoxColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: RushBoxColors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('SUBMIT REQUEST', style: TextStyle(fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isSubmitting = true);
    final authService = ref.read(authServiceProvider);
    final res = await authService.submitDeletionRequest(
      reason: _selectedReason!,
      feedback: _feedbackController.text.trim().isNotEmpty ? _feedbackController.text.trim() : null,
    );

    if (mounted) {
      setState(() => _isSubmitting = false);
      if (res.success && res.request != null) {
        setState(() {
          _currentRequest = res.request;
          _selectedReason = null;
          _feedbackController.clear();
          _confirmedCheckbox = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account deletion scheduled. You have 10 days to cancel.'),
            backgroundColor: RushBoxColors.accentWarmDark,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res.error ?? 'Failed to submit request'),
            backgroundColor: RushBoxColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _handleCancelRequest() async {
    ref.read(audioServiceProvider).playSfx('assets/common/audio/tap.wav');
    ref.read(hapticsServiceProvider).mediumImpact();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: RushBoxColors.surfaceCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.check_circle_outline_rounded, color: RushBoxColors.success, size: 24),
            SizedBox(width: 8),
            Text(
              'Cancel Deletion?',
              style: TextStyle(fontWeight: FontWeight.w900, color: RushBoxColors.textPrimary, fontSize: 18),
            ),
          ],
        ),
        content: const Text(
          'Do you want to cancel your account deletion request? Your account, cloud saves, and points will remain completely safe.',
          style: RushBoxTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('NO, KEEP PENDING', style: TextStyle(fontWeight: FontWeight.w700, color: RushBoxColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: RushBoxColors.success,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('YES, KEEP MY ACCOUNT', style: TextStyle(fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isCancelling = true);
    final authService = ref.read(authServiceProvider);
    final res = await authService.cancelDeletionRequest();

    if (mounted) {
      setState(() => _isCancelling = false);
      if (res.success) {
        setState(() => _currentRequest = null);
        ref.read(audioServiceProvider).playSfx('assets/common/audio/complete.wav');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account deletion cancelled! Your progress and points are safe. 🎉'),
            backgroundColor: RushBoxColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res.error ?? 'Failed to cancel deletion'),
            backgroundColor: RushBoxColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RushBoxColors.bgPrimary,
      body: Container(
        decoration: const BoxDecoration(gradient: RushBoxColors.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: RushBoxDimensions.space16,
                  vertical: RushBoxDimensions.space12,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: RushBoxColors.surfaceCard,
                          shape: BoxShape.circle,
                          boxShadow: RushBoxColors.neumorphicRaised(distance: 4, blur: 8),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: RushBoxColors.textPrimary,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: RushBoxDimensions.space16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DELETE ACCOUNT & DATA',
                            style: RushBoxTypography.titleMedium.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.8,
                              color: RushBoxColors.textPrimary,
                            ),
                          ),
                          Text(
                            'Data Erasure Management',
                            style: RushBoxTypography.labelSmall.copyWith(
                              color: RushBoxColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Content View
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator(color: RushBoxColors.accentBlue))
                    : Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: RushBoxDimensions.maxContentWidth),
                          child: ListView(
                            padding: const EdgeInsets.symmetric(horizontal: RushBoxDimensions.space20, vertical: 12),
                            children: [
                              if (_currentRequest != null && _currentRequest!.isPending)
                                _buildPendingStatusView(_currentRequest!)
                              else
                                _buildRequestFormView(),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// View when a 10-day deletion request is active
  Widget _buildPendingStatusView(DeletionRequest req) {
    final purgeFormatted =
        '${req.scheduledPurgeAt.day}/${req.scheduledPurgeAt.month}/${req.scheduledPurgeAt.year}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status Card
        Container(
          decoration: BoxDecoration(
            color: RushBoxColors.surfaceCard,
            borderRadius: RushBoxDimensions.borderRadiusLarge,
            border: Border.all(color: RushBoxColors.error.withValues(alpha: 0.4), width: 1.5),
            boxShadow: RushBoxColors.neumorphicRaised(distance: 6, blur: 14),
          ),
          padding: const EdgeInsets.all(RushBoxDimensions.space20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: RushBoxColors.error.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.timer_rounded, color: RushBoxColors.error, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'DELETION IN PROGRESS',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                        color: RushBoxColors.error,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: RushBoxDimensions.space16),

              Text(
                '${req.daysRemaining} DAYS REMAINING',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: RushBoxColors.error,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Scheduled permanent purge: $purgeFormatted',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: RushBoxColors.textSecondary,
                ),
              ),

              const SizedBox(height: RushBoxDimensions.space16),
              const Divider(color: RushBoxColors.bgSecondary),
              const SizedBox(height: RushBoxDimensions.space12),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline_rounded, color: RushBoxColors.accentBlue, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Your account and cloud saves are currently in a 10-day grace period. You can cancel this request at any time before the deadline to keep all your game levels, RB points, and coins.',
                      style: RushBoxTypography.bodySmall.copyWith(
                        color: RushBoxColors.textPrimary,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),

              if (req.reason.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: RushBoxColors.bgSecondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Reason selected:',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: RushBoxColors.textMuted),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        req.reason,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: RushBoxColors.textPrimary),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: RushBoxDimensions.space24),

        // Cancel Button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton.icon(
            onPressed: _isCancelling ? null : _handleCancelRequest,
            style: ElevatedButton.styleFrom(
              backgroundColor: RushBoxColors.success,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            icon: _isCancelling
                ? const SizedBox.shrink()
                : const Icon(Icons.undo_rounded, size: 20),
            label: _isCancelling
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                : const Text(
                    'CANCEL DELETION REQUEST',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 0.8),
                  ),
          ),
        ),
      ],
    );
  }

  /// View to fill out and submit a new deletion request
  Widget _buildRequestFormView() {
    final canSubmit = _selectedReason != null && _confirmedCheckbox && !_isSubmitting;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Warning Card
        Container(
          decoration: BoxDecoration(
            color: RushBoxColors.surfaceCard,
            borderRadius: RushBoxDimensions.borderRadiusLarge,
            border: Border.all(color: RushBoxColors.error.withValues(alpha: 0.3), width: 1.2),
            boxShadow: RushBoxColors.neumorphicRaised(distance: 5, blur: 10),
          ),
          padding: const EdgeInsets.all(RushBoxDimensions.space16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.delete_forever_rounded, color: RushBoxColors.error, size: 22),
                  SizedBox(width: 10),
                  Text(
                    '10-Day Account Deletion Notice',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: RushBoxColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Submitting this request will schedule your database account for permanent erasure. You will have a 10-day grace period during which you can cancel at any time.',
                style: RushBoxTypography.bodyMedium.copyWith(color: RushBoxColors.textSecondary),
              ),
              const SizedBox(height: 14),
              const Text(
                'What will be permanently erased after 10 days:',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: RushBoxColors.textPrimary),
              ),
              const SizedBox(height: 8),
              _buildWipeItem('All game level progress, high scores & 3-star ratings'),
              _buildWipeItem('All global RB Points balance & activity ledger records'),
              _buildWipeItem('All in-game coins, power-ups, and unlocked cosmetic themes'),
              _buildWipeItem('Global Gamer Level, XP, and profile credentials'),
            ],
          ),
        ),

        const SizedBox(height: RushBoxDimensions.space24),

        // Reason Selector
        const Text(
          'WHY ARE YOU DELETING YOUR ACCOUNT?',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
            color: RushBoxColors.textSecondary,
          ),
        ),
        const SizedBox(height: 10),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _reasons.map((reason) {
            final isSelected = _selectedReason == reason;
            return ChoiceChip(
              label: Text(
                reason,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                  color: isSelected ? Colors.white : RushBoxColors.textPrimary,
                ),
              ),
              selected: isSelected,
              selectedColor: RushBoxColors.accentBlue,
              backgroundColor: RushBoxColors.surfaceCard,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              onSelected: (selected) {
                ref.read(audioServiceProvider).playSfx('assets/common/audio/tap.wav');
                ref.read(hapticsServiceProvider).lightImpact();
                setState(() {
                  _selectedReason = selected ? reason : null;
                });
              },
            );
          }).toList(),
        ),

        const SizedBox(height: RushBoxDimensions.space20),

        // Optional Feedback
        const Text(
          'ADDITIONAL FEEDBACK (OPTIONAL)',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
            color: RushBoxColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: RushBoxColors.surfaceCard,
            borderRadius: RushBoxDimensions.borderRadiusMedium,
            boxShadow: RushBoxColors.neumorphicSubtle(),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: TextField(
            controller: _feedbackController,
            maxLines: 3,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Help us improve Rush Box...',
              hintStyle: TextStyle(fontSize: 13, color: RushBoxColors.textMuted),
            ),
          ),
        ),

        const SizedBox(height: RushBoxDimensions.space20),

        // Confirmation Checkbox
        Container(
          decoration: BoxDecoration(
            color: RushBoxColors.surfaceCard,
            borderRadius: BorderRadius.circular(16),
            boxShadow: RushBoxColors.neumorphicSubtle(),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: CheckboxListTile(
            value: _confirmedCheckbox,
            activeColor: RushBoxColors.error,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: EdgeInsets.zero,
            title: Text(
              'I understand that after 10 days, all my game progress, RB points, coins, and achievements will be permanently erased.',
              style: RushBoxTypography.bodySmall.copyWith(
                fontWeight: FontWeight.w700,
                color: RushBoxColors.textPrimary,
              ),
            ),
            onChanged: (val) {
              ref.read(audioServiceProvider).playSfx('assets/common/audio/tap.wav');
              setState(() => _confirmedCheckbox = val == true);
            },
          ),
        ),

        const SizedBox(height: RushBoxDimensions.space24),

        // Submit Button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton.icon(
            onPressed: canSubmit ? _handleSubmitRequest : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: RushBoxColors.error,
              foregroundColor: Colors.white,
              disabledBackgroundColor: RushBoxColors.bgSecondary,
              disabledForegroundColor: RushBoxColors.textMuted,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            icon: _isSubmitting
                ? const SizedBox.shrink()
                : const Icon(Icons.delete_forever_rounded, size: 20),
            label: _isSubmitting
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                : const Text(
                    'REQUEST ACCOUNT DELETION (10-DAY GRACE)',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 0.6),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildWipeItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: RushBoxColors.error, fontWeight: FontWeight.w900)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: RushBoxColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
