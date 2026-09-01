import 'package:flutter/material.dart';
import '../../theme/typography.dart';
import 'legal_components.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalScaffold(
      title: 'TERMS OF SERVICE',
      subtitle: 'Last Updated: September 1, 2026',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LegalNoticeBadge(dateText: 'Last Updated: September 1, 2026'),
          SizedBox(height: 16),

          // 1. Acceptance of Terms
          LegalSectionHeader(title: '1. ACCEPTANCE OF TERMS'),
          LegalCard(
            children: [
              Text(
                'By downloading, accessing, or playing Rush Box on mobile applications or via our web portal (https://rushbox.in), you agree to be bound by these Terms of Service. If you do not agree to these terms, please discontinue using Rush Box.',
                style: RushBoxTypography.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: 16),

          // 2. User Accounts & Fair Play
          LegalSectionHeader(title: '2. USER ACCOUNTS & FAIR PLAY'),
          LegalCard(
            children: [
              LegalBulletPoint(
                title: '🎮 Guest & Registered Modes',
                desc: 'You can play as a Guest or create an optional authenticated account (Email/Password or Pi Network Auth) to save progress and access meta-economy features across devices.',
              ),
              LegalBulletPoint(
                title: '🔒 Account Security',
                desc: 'You are responsible for maintaining the confidentiality of your login credentials. Notify us immediately of any unauthorized access.',
              ),
              LegalBulletPoint(
                title: '🛡️ Anti-Cheat & Fair Play',
                desc: 'Exploiting software vulnerabilities, reverse engineering binaries, using automated bots/scripts, or injecting unauthorized progress payloads into cloud sync is strictly prohibited and will result in account suspension.',
              ),
            ],
          ),
          SizedBox(height: 16),

          // 3. Virtual Items, RB Points & Economy
          LegalSectionHeader(title: '3. VIRTUAL ITEMS & RB POINTS ECONOMY'),
          LegalCard(
            children: [
              LegalBulletPoint(
                title: '🪙 Virtual Currency & Licenses',
                desc: 'Global RB Points, in-game coins, power-ups, themes, blade effects, and cosmetic items are limited, revocable digital licenses solely for personal entertainment. They have zero real-world monetary value and cannot be redeemed for fiat currency.',
              ),
              LegalBulletPoint(
                title: '🔄 Final Conversions',
                desc: 'Exchanges of RB Points for in-game coins (e.g. 1 RB = 10 Game Coins) or digital cosmetics are final and non-refundable.',
              ),
              LegalBulletPoint(
                title: '🎁 Daily Rewards & Advertisements',
                desc: 'Bonus RB Points earned via daily check-ins or rewarded video ads are subject to provider availability and anti-fraud verification.',
              ),
            ],
          ),
          SizedBox(height: 16),

          // 4. Intellectual Property & License
          LegalSectionHeader(title: '4. INTELLECTUAL PROPERTY'),
          LegalCard(
            children: [
              Text(
                'All games, software, audio effects, graphic art, character designs, logos, and code within Rush Box are the exclusive intellectual property of the developer. You are granted a limited, personal, non-exclusive, non-transferable license to play the games for personal, non-commercial entertainment.',
                style: RushBoxTypography.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: 16),

          // 5. Disclaimer & Limitation of Liability
          LegalSectionHeader(title: '5. DISCLAIMER & LIMITATION OF LIABILITY'),
          LegalCard(
            children: [
              Text(
                'Rush Box is provided on an "AS IS" and "AS AVAILABLE" basis without warranties of any kind. We strive for 100% uptime and seamless gameplay but do not guarantee uninterrupted or error-free operation.\n\nIn no event shall the developer be liable for any indirect, incidental, special, or consequential damages arising from your use of the application.',
                style: RushBoxTypography.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: 16),

          // 6. Termination & Modifications
          LegalSectionHeader(title: '6. TERMINATION & UPDATES'),
          LegalCard(
            children: [
              Text(
                'We reserve the right to modify, balance, or update game rules, level designs, virtual currencies, and these Terms at any time. Continued use of Rush Box after updates constitutes acceptance of the modified Terms.',
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
