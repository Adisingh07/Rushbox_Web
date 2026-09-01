import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import 'legal_components.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LegalScaffold(
      title: 'ABOUT RUSH BOX',
      subtitle: 'Arcade & Casual Gaming Hub',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Overview
          const LegalHeroCard(
            emoji: '🎮',
            title: 'Rush Box',
            tagline: 'Small games. Smooth moments. One box full of fun.',
            desc: 'Rush Box brings the best of casual and arcade gaming together into a single ultra-responsive, privacy-centric gaming hub — featuring rich physics, smooth animations, global level progression, and seamless cross-platform cloud sync.',
          ),
          const SizedBox(height: RushBoxDimensions.space20),

          // About the Platform
          const LegalSectionHeader(title: 'ABOUT THE PLATFORM'),
          const LegalCard(
            children: [
              Text(
                'Rush Box was forged with one driving vision: to make casual gaming truly fast, delightful, and respectful of player privacy.\n\n'
                'Instead of bloating each game with heavy downloads, Rush Box bundles carefully crafted arcade experiences into a lightweight, unified hub. Every game features bespoke audio, tactile haptic feedback, 60+ FPS native rendering, and complete offline capability.',
                style: RushBoxTypography.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: RushBoxDimensions.space20),

          // Game Catalog
          const LegalSectionHeader(title: 'OUR GAME CATALOG'),
          LegalCard(
            children: [
              _buildGameFeature(
                emoji: '🍉',
                title: 'Fruit Slice',
                desc: 'Master the Katana Runes level trail! Slice flying fruits, trigger devastating combo chains, dodge explosives, and test your speed in Timed & Timeless Rush modes.',
              ),
              const Divider(color: RushBoxColors.bgSecondary, height: 24),
              _buildGameFeature(
                emoji: '➡️',
                title: 'Arrow Tap Out',
                desc: 'A spatial 3D puzzle challenge. Tap arrows to untangle intricate multi-directional boards across themed chapters with special tiles and power-ups.',
              ),
              const Divider(color: RushBoxColors.bgSecondary, height: 24),
              _buildGameFeature(
                emoji: '⭕',
                title: 'Tic Tac Toe',
                desc: 'Classic 3x3 and tactical 4x4 boards. Play against intelligent AI across three difficulty tiers or battle friends in timed local PvP matches.',
              ),
              const Divider(color: RushBoxColors.bgSecondary, height: 24),
              _buildGameFeature(
                emoji: '🗡️',
                title: 'Knife Throw',
                desc: 'Reflex and precision arcade action. Hit spinning targets, avoid hitting embedded blades, and unlock legendary blade styles.',
              ),
            ],
          ),
          const SizedBox(height: RushBoxDimensions.space20),

          // Core Features & Innovations
          const LegalSectionHeader(title: 'CORE PLATFORM FEATURES'),
          const LegalCard(
            children: [
              LegalBulletPoint(
                title: '☁️ Cloud Sync & Cross-Device Play',
                desc: 'Save your unlocked levels, high scores, and stars to the cloud and switch between mobile and web without losing a single beat.',
              ),
              LegalBulletPoint(
                title: '⭐ Global Gamer Level & XP (1–100)',
                desc: 'Earn +10 XP for every active minute of gameplay across any game to level up your gamer profile.',
              ),
              LegalBulletPoint(
                title: '🪙 Global RB Points Meta-Economy',
                desc: 'Earn RB Points through daily claims and achievements to convert into in-game coins or unlock future entitlements.',
              ),
              LegalBulletPoint(
                title: '⚡ 60 FPS Native Performance & Audio',
                desc: 'Built with optimized Flutter engines, custom audio synthesis, and native haptic feedback.',
              ),
              LegalBulletPoint(
                title: '🛡️ Privacy-First & Family Safe',
                desc: 'Enjoy full gameplay in Guest mode with zero forced signups or tracking.',
              ),
            ],
          ),
          const SizedBox(height: RushBoxDimensions.space20),

          const LegalContactBanner(),
        ],
      ),
    );
  }

  Widget _buildGameFeature({required String emoji, required String title, required String desc}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: RushBoxColors.bgSecondary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: RushBoxColors.neumorphicSubtle(),
          ),
          alignment: Alignment.center,
          child: Text(emoji, style: const TextStyle(fontSize: 22)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: RushBoxTypography.titleSmall.copyWith(
                  fontWeight: FontWeight.w800,
                  color: RushBoxColors.textPrimary,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                desc,
                style: RushBoxTypography.bodySmall.copyWith(
                  color: RushBoxColors.textSecondary,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
