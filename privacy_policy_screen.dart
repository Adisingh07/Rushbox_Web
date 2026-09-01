import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import '../../../core/services/ads_service.dart';
import '../../../core/services/haptics_service.dart';
import 'legal_components.dart';

class PrivacyPolicyScreen extends ConsumerWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LegalScaffold(
      title: 'PRIVACY POLICY',
      subtitle: 'Last Updated: September 1, 2026',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LegalNoticeBadge(dateText: 'Last Updated: September 1, 2026'),
          const SizedBox(height: 16),

          // 1. Overview & Commitment
          const LegalSectionHeader(title: '1. OVERVIEW & COMMITMENT'),
          const LegalCard(
            children: [
              Text(
                'Rush Box ("we", "our", or "us") is dedicated to providing fun, engaging casual games while respecting your privacy and safeguarding your personal data.\n\n'
                'You can enjoy all core arcade and casual games as a Guest without registering an account. If you choose to register an account, we use industry-standard security and minimal data collection solely to enable cloud game synchronization, gamer level progression, and virtual economy features.',
                style: RushBoxTypography.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 2. Information We Collect & Process
          const LegalSectionHeader(title: '2. INFORMATION WE COLLECT & PROCESS'),
          const LegalCard(
            children: [
              LegalBulletPoint(
                title: '👤 Account & Authentication Data (Optional)',
                desc: 'When you create an account, we collect your email address, unique username, display name, and avatar preference. Passwords are encrypted using irreversible salted cryptographic hashing (bcrypt) and are never stored in plain text. If you sign in via Pi Network, we associate your verified Pi UID and username.',
              ),
              LegalBulletPoint(
                title: '☁️ Cloud Game Progress & Scores',
                desc: 'For authenticated accounts, we synchronize your unlocked levels, completion stars, personal high scores, best completion times, and game attempts to Google Cloud Firestore so you can seamlessly resume progress across devices.',
              ),
              LegalBulletPoint(
                title: '⭐ Global Gamer Level & XP Progression',
                desc: 'We track active in-game playtime minutes to calculate your global Gamer Level (Levels 1–100) and cumulative XP points.',
              ),
              LegalBulletPoint(
                title: '🪙 Virtual RB Points & Economy Ledger',
                desc: 'We maintain an immutable transactional activity ledger recording RB Points earned (daily check-ins, achievements) and exchanged for in-game coins.',
              ),
              LegalBulletPoint(
                title: '💾 Local Device Storage',
                desc: 'Audio preferences (SFX/music volume), haptic feedback settings, and local cached saves are stored directly on your device via SharedPreferences.',
              ),
              LegalBulletPoint(
                title: '📊 Diagnostic & Performance Analytics',
                desc: 'Anonymous app diagnostics, performance metrics, and crash reports may be processed to optimize game framerate and stability.',
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 3. Advertising & Monetization
          const LegalSectionHeader(title: '3. ADVERTISING & MONETIZATION'),
          const LegalCard(
            children: [
              Text(
                'On our mobile Android application, we deliver non-intrusive advertisements to keep Rush Box free for all players:',
                style: RushBoxTypography.bodyMedium,
              ),
              SizedBox(height: 8),
              LegalBulletPoint(
                title: '🎬 Rewarded Video Ads',
                desc: 'Voluntary ads that you choose to watch in exchange for in-game rewards (such as Daily +10 RB Points).',
              ),
              LegalBulletPoint(
                title: '📱 Interstitial & Banner Ads',
                desc: 'Displayed between game sessions with strict frequency capping to prevent gameplay disruption.',
              ),
              LegalBulletPoint(
                title: '🛡️ Consent & Privacy Frameworks',
                desc: 'We strictly comply with the Google User Messaging Platform (UMP) and IAB Europe Transparency and Consent Framework (TCF v2.2) for players in the European Economic Area (EEA) and UK.',
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 4. Third-Party Service Providers
          const LegalSectionHeader(title: '4. THIRD-PARTY INFRASTRUCTURE & PARTNERS'),
          const LegalCard(
            children: [
              Text(
                'We integrate trusted third-party SDKs that operate under strict data protection agreements:',
                style: RushBoxTypography.bodyMedium,
              ),
              SizedBox(height: 8),
              LegalBulletPoint(
                title: 'Google Firebase (Google LLC)',
                desc: 'Provides secure Cloud Firestore databases, security rules, and performance infrastructure.',
              ),
              LegalBulletPoint(
                title: 'Google Mobile Ads / AdMob (Google LLC)',
                desc: 'Provides privacy-compliant advertising services and UMP consent management.',
              ),
              LegalBulletPoint(
                title: 'Meta Audience Network (Meta Platforms, Inc.)',
                desc: 'Integrated via Google AdMob mediation for ad fulfillment.',
              ),
              LegalBulletPoint(
                title: 'Pi Network (SocialChain Inc.)',
                desc: 'Provides optional decentralized user authentication for Pi community members.',
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 5. Data Security & Retention
          const LegalSectionHeader(title: '5. DATA SECURITY & ENCRYPTION'),
          const LegalCard(
            children: [
              Text(
                'We employ robust technical and organizational security safeguards:\n\n'
                '• Transport Layer Security (TLS 1.3 / SSL) encrypts all data in transit between your device and our servers.\n'
                '• Granular Firebase Security Rules strictly restrict database reads and writes to authorized account sessions.\n'
                '• Passwords are mathematically hashed with unique salt rounds.\n'
                '• We do not sell, rent, or trade your personal data to any third-party brokers.',
                style: RushBoxTypography.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 6. User Rights & Data Deletion
          const LegalSectionHeader(title: '6. YOUR RIGHTS & DATA DELETION'),
          const LegalCard(
            children: [
              Text(
                'You have complete control over your data:\n\n'
                '• Local Data: Reset all local scores and game progress at any time via Settings -> "Reset All Game Progress".\n'
                '• Account & Cloud Deletion: You can request the permanent deletion of your account, cloud game saves, and RB points records by emailing us at contact@rushbox.in or contact@connectpi.in with your registered username. Requests are processed within 30 days.',
                style: RushBoxTypography.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 7. Children\'s Privacy Protection
          const LegalSectionHeader(title: '7. CHILDREN\'S PRIVACY (COPPA & GDPR-K)'),
          const LegalCard(
            children: [
              Text(
                'Rush Box games are casual family-friendly experiences. We do not knowingly collect personal data from children under the age of 13 (or 16 in certain European jurisdictions). If we discover that personal information has been collected from a child without verifiable parental consent, we will promptly delete it.',
                style: RushBoxTypography.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 8. Ad Privacy Choices & Consent Revocation (Android / EEA GDPR Compliance)
          const LegalSectionHeader(title: '8. AD PRIVACY CHOICES & CONSENT REVOCATION'),
          LegalCard(
            children: [
              const Text(
                'Players in the European Economic Area (EEA) and UK can review, modify, or revoke their advertising consent choices at any time using Google\'s User Messaging Platform (UMP):',
                style: RushBoxTypography.bodyMedium,
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RushBoxColors.accentBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: RushBoxDimensions.space16,
                      vertical: RushBoxDimensions.space12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: RushBoxDimensions.borderRadiusMedium,
                    ),
                  ),
                  icon: const Icon(Icons.security_update_good_rounded, size: 18),
                  label: const Text(
                    'MANAGE / REVOKE AD CONSENT',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
                  ),
                  onPressed: () async {
                    ref.read(hapticsServiceProvider).lightImpact();
                    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ad consent settings are active on the mobile Android app.'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      return;
                    }

                    // Show Google UMP Privacy Options Form on Android
                    await ref.read(adsServiceProvider).showPrivacyOptionsForm();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          const LegalContactBanner(),
        ],
      ),
    );
  }
}
