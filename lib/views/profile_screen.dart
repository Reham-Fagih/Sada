import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/app_bottom_nav.dart';

/// Profile Screen — "حسابي"
///
/// NOTE: No Figma mockup was provided for this screen. It was composed to
/// match the same brand system as the other 3 screens (light theme,
/// consistent with the bank-linking screen, since both are account-
/// management style pages). Adjust freely once a real design exists.
///
/// UI ONLY. No business logic — all data below is placeholder and should
/// be supplied by [ProfileController] later.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.2,
            child: Image.asset('assets/images/city.png', fit: BoxFit.cover),
          ),
          Container(color: AppColors.background.withOpacity(0.9)),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: AppTopBar(
                    showBackButton: true,
                    titleColor: AppColors.textPrimary,
                    iconColor: AppColors.textPrimary,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 12),
                        const _ProfileHeader(
                          name: 'مستخدم صدى',
                          email: 'user@example.com',
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Expanded(
                              child: _ProfileStatCard(
                                icon: Icons.account_balance_outlined,
                                label: 'الحسابات المرتبطة',
                                value: '3',
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: _ProfileStatCard(
                                icon: Icons.auto_awesome_outlined,
                                label: 'التوأم الرقمي',
                                value: 'نشط',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'الإعدادات',
                          style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            children: [
                              _ProfileMenuItem(
                                icon: Icons.settings_outlined,
                                label: 'إعدادات الحساب',
                                onTap: () {
                                  // TODO: hook to ProfileController
                                },
                              ),
                              _MenuDivider(),
                              _ProfileMenuItem(
                                icon: Icons.shield_outlined,
                                label: 'الأمان والخصوصية',
                                onTap: () {
                                  // TODO: hook to ProfileController
                                },
                              ),
                              _MenuDivider(),
                              _ProfileMenuItem(
                                icon: Icons.notifications_none_rounded,
                                label: 'الإشعارات',
                                onTap: () {
                                  // TODO: hook to ProfileController
                                },
                              ),
                              _MenuDivider(),
                              _ProfileMenuItem(
                                icon: Icons.help_outline_rounded,
                                label: 'المساعدة والدعم',
                                onTap: () {
                                  // TODO: hook to ProfileController
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: _ProfileMenuItem(
                            icon: Icons.logout_rounded,
                            label: 'تسجيل الخروج',
                            iconColor: AppColors.copper600,
                            labelColor: AppColors.copper600,
                            onTap: () {
                              // TODO: hook to ProfileController.logout()
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                const AppBottomNavBar(currentTab: AppNavTab.profile),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =======================================================================
// Profile header (avatar + name + email)
// =======================================================================
class _ProfileHeader extends StatelessWidget {
  final String name;
  final String email;

  const _ProfileHeader({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.copper300, width: 2),
            image: const DecorationImage(
              image: AssetImage('assets/images/avatar.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'BeVietnamPro',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          style: TextStyle(
            fontFamily: 'BeVietnamPro',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

// =======================================================================
// Small stat card
// =======================================================================
class _ProfileStatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileStatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.copper100,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: AppColors.copper600),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.w400,
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// =======================================================================
// Menu item row
// =======================================================================
class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? labelColor;

  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 20, color: iconColor ?? AppColors.textPrimary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                  color: labelColor ?? AppColors.textPrimary,
                ),
              ),
            ),
            Icon(
              Icons.chevron_left_rounded,
              size: 20,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuDivider extends StatelessWidget {
  const _MenuDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
      color: AppColors.border,
    );
  }
}