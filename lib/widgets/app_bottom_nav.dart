import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../views/home_screen.dart';
import '../views/city_screen.dart';
import '../views/simulation_screen.dart';
import '../views/profile_screen.dart';

/// Identifies which of the 4 main screens is currently active — used by
/// [AppBottomNavBar] to highlight the right tab and navigate between
/// screens. This is UI-layer navigation only, not business logic.
enum AppNavTab { city, home, simulation, profile }

class _NavItemData {
  final IconData icon;
  final String label;

  const _NavItemData({required this.icon, required this.label});
}

const Map<AppNavTab, _NavItemData> _navItems = {
  AppNavTab.city: _NavItemData(
    icon: Icons.account_balance_outlined,
    label: 'ربط البنوك',
  ),
  AppNavTab.home: _NavItemData(
    icon: Icons.apartment_rounded,
    label: 'الرئيسية',
  ),
  AppNavTab.simulation: _NavItemData(
    icon: Icons.bar_chart_rounded,
    label: 'محاكاة القرار',
  ),
  AppNavTab.profile: _NavItemData(
    icon: Icons.person_outline_rounded,
    label: 'حسابي',
  ),
};

/// Shared floating bottom navigation bar used across all 4 main screens.
/// Tapping a tab replaces the current screen (no stacking), which is what
/// keeps the 4 screens linked together as one cohesive app shell.
class AppBottomNavBar extends StatelessWidget {
  final AppNavTab currentTab;

  const AppBottomNavBar({super.key, required this.currentTab});

  void _navigate(BuildContext context, AppNavTab tab) {
    if (tab == currentTab) return;

    late final Widget screen;
    switch (tab) {
      case AppNavTab.home:
        screen = const HomeScreen();
        break;
      case AppNavTab.city:
        screen = const CityScreen();
        break;
      case AppNavTab.simulation:
        screen = const SimulationScreen();
        break;
      case AppNavTab.profile:
        screen = const ProfileScreen();
        break;
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listed right-to-left so the visual layout under RTL directionality
    // reads left-to-right on screen exactly as in the Figma design:
    // ربط البنوك | الرئيسية | محاكاة القرار | حسابي
    const order = [
      AppNavTab.city,
      AppNavTab.home,
      AppNavTab.simulation,
      AppNavTab.profile,
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.navy950.withOpacity(0.92),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColors.white.withOpacity(0.08)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: order.map((tab) {
            final data = _navItems[tab]!;
            final isActive = tab == currentTab;
            return _NavItem(
              icon: data.icon,
              label: data.label,
              isActive: isActive,
              onTap: () => _navigate(context, tab),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 16 : 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.copper500 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: isActive
            ? Icon(icon, size: 22, color: AppColors.white)
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 20, color: AppColors.white.withOpacity(0.7)),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: AppColors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}