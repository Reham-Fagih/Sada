import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/app_bottom_nav.dart';

/// Simulation Screen — "محاكاة القرار"
///
/// UI ONLY. No business logic — the simulation options are static UI data.
/// The selected option and "ابدأ المحاكاة" action should be wired to
/// [SimulationController] later.
class SimulationScreen extends StatelessWidget {
  const SimulationScreen({super.key});

  static const List<_SimulationOption> _options = [
    _SimulationOption(
      icon: Icons.flight_takeoff_rounded,
      title: 'سفر',
      subtitle: 'خطط لرحلتك القادمة بذكاء',
    ),
    _SimulationOption(
      icon: Icons.directions_car_filled_rounded,
      title: 'شراء سيارة',
      subtitle: 'محاكاة تكاليف الامتلاك والصيانة',
    ),
    _SimulationOption(
      icon: Icons.payments_outlined,
      title: 'قرض شخصي',
      subtitle: 'توقع الفوائد وفترة السداد',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy950,
      extendBody: true,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: AppTopBar(showBackButton: true),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    const _FutureVisionImageCard(),
                    const SizedBox(height: 18),
                    Text(
                      'استكشاف تأثير قراراتك المالية على مستقبلك قبل اتخاذها.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        height: 1.6,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    for (int i = 0; i < _options.length; i++) ...[
                      _SimulationOptionCard(
                        option: _options[i],
                        onTap: () {
                          // TODO: hook to SimulationController.selectOption()
                        },
                      ),
                      if (i != _options.length - 1) const SizedBox(height: 12),
                    ],
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: hook to SimulationController.startSimulation()
                        },
                        icon: const Icon(Icons.auto_graph_rounded, size: 18),
                        label: Text(
                          'ابدأ المحاكاة',
                          style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.navy800,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            const AppBottomNavBar(currentTab: AppNavTab.simulation),
          ],
        ),
      ),
    );
  }
}

// =======================================================================
// Top rounded image card with "رؤية مستقبلية" floating chip
// =======================================================================
class _FutureVisionImageCard extends StatelessWidget {
  const _FutureVisionImageCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/city.png',
            height: 190,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            height: 190,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.navy950.withOpacity(0.05),
                  AppColors.navy950.withOpacity(0.45),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 14,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'رؤية مستقبلية',
                    style: TextStyle(
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.auto_awesome, size: 14, color: AppColors.copper600),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =======================================================================
// Simulation option data + card
// =======================================================================
class _SimulationOption {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SimulationOption({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class _SimulationOptionCard extends StatelessWidget {
  final _SimulationOption option;
  final VoidCallback onTap;

  const _SimulationOptionCard({required this.option, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.background.withOpacity(0.97),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Icon(
                Icons.chevron_left_rounded,
                size: 20,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.title,
                      style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      option.subtitle,
                      style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w400,
                        fontSize: 11.5,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.copper100,
                  shape: BoxShape.circle,
                ),
                child: Icon(option.icon, size: 20, color: AppColors.copper600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}