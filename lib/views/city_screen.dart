import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/app_bottom_nav.dart';

/// City Screen — "ربط البنوك" (link bank accounts)
///
/// UI ONLY. No business logic — the selected bank is local UI state used
/// purely to show selection feedback; actual linking should be wired to
/// [CityController] later.
class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  int _selectedBankIndex = 0;

  static const List<_BankOption> _banks = [
    _BankOption(name: 'مصرف الإنماء', code: 'ALINMA BANK'),
    _BankOption(name: 'البنك الأهلي السعودي', code: 'SNB'),
    _BankOption(name: 'مصرف الراجحي', code: 'ALRAJHI BANK'),
    _BankOption(name: 'بنك الرياض', code: 'RIYAD BANK'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ---------- Light, washed-out background ----------
          Opacity(
            opacity: 0.25,
            child: Image.asset('assets/images/city.png', fit: BoxFit.cover),
          ),
          Container(color: AppColors.background.withOpacity(0.85)),

          // ---------- Main content ----------
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
                        const SizedBox(height: 20),
                        Text(
                          'ربط البنوك',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'قم بربط حساباتك البنكية لبناء مدينتك المالية.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // ---------- Bank selection card ----------
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'اختر البنك',
                                    style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Icon(
                                    Icons.tune_rounded,
                                    size: 20,
                                    color: AppColors.textSecondary,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              for (int i = 0; i < _banks.length; i++) ...[
                                _BankTile(
                                  bank: _banks[i],
                                  isSelected: _selectedBankIndex == i,
                                  onTap: () {
                                    setState(() => _selectedBankIndex = i);
                                  },
                                ),
                                if (i != _banks.length - 1)
                                  const SizedBox(height: 10),
                              ],
                              const SizedBox(height: 10),
                              _AddOtherBankButton(
                                onTap: () {
                                  // TODO: hook to CityController.addOtherBank()
                                },
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // TODO: hook to CityController.linkSelectedBank()
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.navy900,
                                    foregroundColor: AppColors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(16),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    'ربط الحساب الآن',
                                    style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),
                        const _SecurityInfoCard(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                const AppBottomNavBar(currentTab: AppNavTab.city),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =======================================================================
// Bank option data + tile
// =======================================================================
class _BankOption {
  final String name;
  final String code;

  const _BankOption({required this.name, required this.code});
}

class _BankTile extends StatelessWidget {
  final _BankOption bank;
  final bool isSelected;
  final VoidCallback onTap;

  const _BankTile({
    required this.bank,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.copper100.withOpacity(0.35)
              : AppColors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.copper500 : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              size: 20,
              color: isSelected ? AppColors.copper500 : AppColors.textSecondary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bank.name,
                    style: TextStyle(
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    bank.code,
                    style: TextStyle(
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.navy900.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.account_balance_rounded,
                size: 18,
                color: AppColors.navy900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =======================================================================
// "مصرف آخر" dashed add-button
// =======================================================================
class _AddOtherBankButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddOtherBankButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: DottedBorderBox(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'مصرف آخر',
                style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 6),
              Icon(Icons.add_rounded, size: 16, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}

/// Simple dashed-border wrapper (no extra package required).
class DottedBorderBox extends StatelessWidget {
  final Widget child;

  const DottedBorderBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(color: AppColors.border, radius: 16),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;

  _DashedBorderPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final dashedPath = _dashPath(path, dashLength: 6, gapLength: 4);
    canvas.drawPath(dashedPath, paint);
  }

  Path _dashPath(Path source, {required double dashLength, required double gapLength}) {
    final dashedPath = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0;
      bool draw = true;
      while (distance < metric.length) {
        final length = draw ? dashLength : gapLength;
        if (draw) {
          dashedPath.addPath(
            metric.extractPath(distance, distance + length),
            Offset.zero,
          );
        }
        distance += length;
        draw = !draw;
      }
    }
    return dashedPath;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =======================================================================
// Security info card
// =======================================================================
class _SecurityInfoCard extends StatelessWidget {
  const _SecurityInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.navy900.withOpacity(0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.copper100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.verified_user_outlined,
              size: 17,
              color: AppColors.copper600,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'اتصال آمن ومشفر بنسبة 100%',
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'نحن نستخدم تقنيات التشفير المتقدمة المتوافقة مع معايير البنك المركزي السعودي لحماية بياناتك. لا نقوم بتخزين بيانات الدخول الخاصة بك أبدًا.',
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    height: 1.5,
                    color: AppColors.textSecondary,
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