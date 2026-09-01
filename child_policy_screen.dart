import 'package:flutter/material.dart';
import '../../theme/typography.dart';
import 'legal_components.dart';

class ChildPolicyScreen extends StatelessWidget {
  const ChildPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalScaffold(
      title: 'CHILD PRIVACY POLICY',
      subtitle: 'Last Updated: September 1, 2026',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LegalNoticeBadge(dateText: 'Last Updated: September 1, 2026'),
          SizedBox(height: 16),

          // 1. Commitment to Family Safety
          LegalSectionHeader(title: '1. OUR COMMITMENT TO FAMILY & CHILD SAFETY'),
          LegalCard(
            children: [
              Text(
                'Rush Box is designed to provide family-friendly, wholesome, and accessible casual arcade games for players of all ages. We take child privacy and online safety very seriously and comply with the Children\'s Online Privacy Protection Act (COPPA), GDPR-K (General Data Protection Regulation for Children), and Google Play Families Policies.',
                style: RushBoxTypography.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: 16),

          // 2. Guest Play & No Data Collection for Young Players
          LegalSectionHeader(title: '2. ZERO PERSONAL DATA COLLECTED FROM CHILDREN'),
          LegalCard(
            children: [
              Text(
                'Children can play all core games freely without ever providing personal identification:',
                style: RushBoxTypography.bodyMedium,
              ),
              SizedBox(height: 8),
              LegalBulletPoint(
                title: '❌ No Account Required',
                desc: 'Young players can jump straight into gameplay in Guest mode with zero registration or email verification required.',
              ),
              LegalBulletPoint(
                title: '❌ No Personal Contact Information',
                desc: 'We never solicit or collect real names, home addresses, phone numbers, school details, or photos from children.',
              ),
              LegalBulletPoint(
                title: '❌ No Device Sensor Access',
                desc: 'No microphone, camera, contacts, or personal media files are ever accessed or requested.',
              ),
              LegalBulletPoint(
                title: '❌ No Social Chat Rooms',
                desc: 'There are no open public chat rooms, direct messaging channels, or unmoderated player-to-player interactions.',
              ),
            ],
          ),
          SizedBox(height: 16),

          // 3. Child-Appropriate Advertising
          LegalSectionHeader(title: '3. CHILD-SAFE ADVERTISING STANDARDS'),
          LegalCard(
            children: [
              Text(
                'Where advertisements are shown, we adhere strictly to child-safe advertising requirements:\n\n'
                '• No behavioral or interest-based ad tracking is performed on children.\n'
                '• Ad content is filtered to ensure strictly family-appropriate material.\n'
                '• Rewarded video ads are strictly optional and clearly distinguished from gameplay.',
                style: RushBoxTypography.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: 16),

          // 4. Parental Controls & Inquiries
          LegalSectionHeader(title: '4. PARENTAL RIGHTS & DATA REMOVAL'),
          LegalCard(
            children: [
              Text(
                'Parents or legal guardians have complete authority over their family\'s devices and gameplay data:\n\n'
                '• You can reset all locally saved scores and unlocks at any time via Settings -> "Reset All Game Progress" or by clearing application cache.\n'
                '• If you believe personal information of a child has been inadvertently collected, please contact us immediately at contact@rushbox.in or contact@connectpi.in, and we will promptly delete it within 48 hours.',
                style: RushBoxTypography.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: 20),

          LegalContactBanner(),
        ],
      ),
    );
  }
}
