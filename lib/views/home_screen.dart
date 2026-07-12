import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/app_bottom_nav.dart';

/// Home Screen — "الرئيسية"
///
/// UI ONLY. No business logic here — this screen is purely presentational.
/// Data (income, linked accounts count, etc.) is currently hardcoded as
/// placeholders and should later be supplied by [HomeController].
/// Feature-card callbacks are left empty / TODO — wire them to the
/// controller when logic is implemented.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy950,
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ---------- Background city image ----------
          Image.asset(
            'assets/images/city.png',
            fit: BoxFit.cover,
          ),

          // ---------- Dark overlay gradient ----------
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.navy950.withOpacity(0.35),
                  AppColors.navy950.withOpacity(0.55),
                  AppColors.navy950.withOpacity(0.92),
                ],
                stops: const [0.0, 0.35, 1.0],
              ),
            ),
          ),

          // ---------- Main content ----------
          SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: AppTopBar(showBackButton: false),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 18),
                        const _CityStatusChip(),
                        const SizedBox(height: 24),
                        const _FinancialCard(
                          monthlyIncome: '3,400.00 ر.س',
                          linkedAccountsCount: 3,
                        ),
                        const SizedBox(height: 24),
                        _FeatureGrid(
                          onLinkAccountTap: () {
                            // TODO: hook to HomeController.linkAnotherBankAccount()
                          },
                          onSimulationTap: () {
                            // TODO: navigate to SimulationScreen via controller
                          },
                          onDigitalTwinTap: () {
                            // TODO: navigate to digital twin creation flow
                          },
                          onPastChatsTap: () {
                            // TODO: navigate to past conversations
                          },
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                const AppBottomNavBar(currentTab: AppNavTab.home),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =======================================================================
// City status chip ("حالة المدينة")
// =======================================================================
class _CityStatusChip extends StatelessWidget {
  const _CityStatusChip();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.14),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.white.withOpacity(0.25)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'حالة المدينة',
              style: TextStyle(
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 6),
            Icon(Icons.location_on_outlined, size: 16, color: AppColors.white),
          ],
        ),
      ),
    );
  }
}

// =======================================================================
// Financial summary card
// =======================================================================
class _FinancialCard extends StatelessWidget {
  final String monthlyIncome;
  final int linkedAccountsCount;

  const _FinancialCard({
    required this.monthlyIncome,
    required this.linkedAccountsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.navy900.withOpacity(0.75),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.white.withOpacity(0.08)),
      ),
      child: Column(
        children: [
          Text(
            'إجمالي الدخل الشهري',
            style: TextStyle(
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            monthlyIncome,
            style: TextStyle(
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.w700,
              fontSize: 30,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.copper300.withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.account_balance_outlined,
                    size: 18,
                    color: AppColors.copper300,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الحسابات المرتبطة',
                        style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '$linkedAccountsCount حسابات بنكية',
                        style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =======================================================================
// Feature cards grid (2x2)
// =======================================================================
class _FeatureGrid extends StatelessWidget {
  final VoidCallback onLinkAccountTap;
  final VoidCallback onSimulationTap;
  final VoidCallback onDigitalTwinTap;
  final VoidCallback onPastChatsTap;

  const _FeatureGrid({
    required this.onLinkAccountTap,
    required this.onSimulationTap,
    required this.onDigitalTwinTap,
    required this.onPastChatsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _FeatureCard(
                icon: Icons.add_card_outlined,
                label: 'ربط حساب بنكي آخر',
                onTap: onLinkAccountTap,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _FeatureCard(
                icon: Icons.bar_chart_rounded,
                label: 'محاكاة القرار',
                onTap: onSimulationTap,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _FeatureCard(
                icon: Icons.person_pin_circle_outlined,
                label: 'إنشاء التوأم الرقمي',
                onTap: onDigitalTwinTap,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _FeatureCard(
                icon: Icons.chat_bubble_outline_rounded,
                label: 'المحادثات السابقة',
                onTap: onPastChatsTap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.background.withOpacity(0.95),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.copper100,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 22, color: AppColors.copper600),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}