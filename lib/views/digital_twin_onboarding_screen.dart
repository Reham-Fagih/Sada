import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/app_bottom_nav.dart';

/// "التوأم الرقمي" (Digital Twin) onboarding screen.
///
/// NOTE: This file is UI ONLY, as requested. Selection state is kept
/// locally with setState purely to make the screen tappable/preview-able.
/// Once CityController is ready, move `_selected*` fields there and have
/// this View read/write through the controller instead.
class DigitalTwinOnboardingScreen extends StatefulWidget {
  const DigitalTwinOnboardingScreen({super.key});

  @override
  State<DigitalTwinOnboardingScreen> createState() => _DigitalTwinOnboardingScreenState();
}

class _DigitalTwinOnboardingScreenState extends State<DigitalTwinOnboardingScreen> {
  // ---- Local UI-only state (placeholder for CityController) ----
  int _habitIndex = 0;
  int _toneIndex = 1;
  int _goalIndex = 0;
  bool _isRecording = false;

  final List<String> _habits = const [
    'أوفر أكثر مما أصرف',
    'أصرف بقدر دخلي',
    'أصرف أكثر مما أخطط',
    'أخصص جزءًا من دخلي للاستثمار',
  ];

  final List<_ToneOption> _tones = const [
    _ToneOption(icon: Icons.credit_card_rounded, label: 'بطريقة مباشرة\nوصريحة'),
    _ToneOption(icon: Icons.sentiment_satisfied_alt_rounded, label: 'بطريقة ودية\nومشجعة'),
    _ToneOption(icon: Icons.bolt_rounded, label: 'بطريقة تحفيزية'),
    _ToneOption(icon: Icons.bar_chart_rounded, label: 'بطريقة احترافية\nوتحليلية'),
  ];

  final List<String> _goals = const [
    'شراء سيارة',
    'بناء صندوق ادخار',
    'سداد الديون',
    'تحقيق الاستقرار المالي',
    'تنمية الاستثمارات',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 110),
                    child: Column(
                      children: [
                        _buildHeroImage(),
                        const SizedBox(height: 20),
                        _buildIntro(),
                        const SizedBox(height: 20),
                        _buildFormCard(),
                      ],
                    ),
                  ),
                  const Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AppBottomNavBar(currentTab: AppNavTab.city),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Top bar
  // ---------------------------------------------------------------------
  Widget _buildTopBar(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
          Expanded(
            child: Center(
              child: Text(
                'صدى',
                style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_forward_rounded),
            color: AppColors.textPrimary,
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Hero image
  // ---------------------------------------------------------------------
  Widget _buildHeroImage() {
    // TODO: replace with the real hero illustration asset, e.g.
    // assets/images/twin_hero.png. city.png is used here as a placeholder
    // background so the screen renders with existing assets.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          height: 220,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/city.png',
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.navy950.withOpacity(0.55),
                      AppColors.navy950.withOpacity(0.15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Intro text
  // ---------------------------------------------------------------------
  Widget _buildIntro() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          Text(
            'دعنا نبني توأمك الرقمي',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'أجب عن بعض الأسئلة حتى يتمكن من إنشاء نسخة رقمية تفهم شخصيتك المالية وتساعدك على اتخاذ قرارات أفضل.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.6,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Main form card
  // ---------------------------------------------------------------------
  Widget _buildFormCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy950.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _sectionTitle('كيف تصف عاداتك المالية؟'),
          const SizedBox(height: 14),
          ..._habits.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _RadioOptionTile(
                    label: entry.value,
                    selected: _habitIndex == entry.key,
                    onTap: () => setState(() => _habitIndex = entry.key),
                  ),
                ),
              ),
          const SizedBox(height: 8),
          const _SectionDivider(),
          const SizedBox(height: 20),
          _sectionTitle('كيف تفضل أن يتحدث معك التوأم الرقمي؟'),
          const SizedBox(height: 14),
          _buildToneGrid(),
          const SizedBox(height: 8),
          const _SectionDivider(),
          const SizedBox(height: 20),
          _sectionTitle('ما هو هدفك المالي الحالي؟'),
          const SizedBox(height: 14),
          _buildGoalsWrap(),
          const SizedBox(height: 28),
          _buildVoiceSection(),
          const SizedBox(height: 28),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'BeVietnamPro',
        fontWeight: FontWeight.w700,
        fontSize: 17,
        height: 1.4,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildToneGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _tones.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        final tone = _tones[index];
        return _ToneCard(
          icon: tone.icon,
          label: tone.label,
          selected: _toneIndex == index,
          onTap: () => setState(() => _toneIndex = index),
        );
      },
    );
  }

  Widget _buildGoalsWrap() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: _goals.asMap().entries.map((entry) {
        return _GoalChip(
          label: entry.value,
          selected: _goalIndex == entry.key,
          onTap: () => setState(() => _goalIndex = entry.key),
        );
      }).toList(),
    );
  }

  Widget _buildVoiceSection() {
    return Column(
      children: [
        Text(
          'أضف بصمتك الصوتية',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'BeVietnamPro',
            fontWeight: FontWeight.w700,
            fontSize: 17,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'سجل رسالة قصيرة حتى يتعرف التوأم الرقمي على أسلوبك في الحديث.',
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
        GestureDetector(
          onTap: () => setState(() => _isRecording = !_isRecording),
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isRecording ? AppColors.copper500 : AppColors.lavender400,
              boxShadow: [
                BoxShadow(
                  color:
                      (_isRecording ? AppColors.copper500 : AppColors.lavender400)
                          .withOpacity(0.35),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              _isRecording ? Icons.stop_rounded : Icons.mic_rounded,
              color: AppColors.white,
              size: 30,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          _isRecording ? 'جاري التسجيل...' : 'اضغط للتسجيل',
          style: TextStyle(
            fontFamily: 'BeVietnamPro',
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'مدة التسجيل المقترحة: 30-60 ثانية',
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

  Widget _buildSubmitButton() {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          // TODO: wire up to CityController once logic is implemented.
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.navy900,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.auto_awesome_rounded, size: 18),
            const SizedBox(width: 8),
            Text(
              'إنشاء التوأم الرقمي',
              style: TextStyle(
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// Reusable private widgets
// ===========================================================================

class _RadioOptionTile extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _RadioOptionTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.copper500 : Colors.transparent,
            width: 1.4,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? AppColors.copper500 : AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToneOption {
  final IconData icon;
  final String label;

  const _ToneOption({required this.icon, required this.label});
}

class _ToneCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ToneCard({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.copper500 : Colors.transparent,
            width: 1.4,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: selected ? AppColors.copper600 : AppColors.textSecondary,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.w600,
                fontSize: 12,
                height: 1.3,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoalChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _GoalChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.navy900 : AppColors.background,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'BeVietnamPro',
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: selected ? AppColors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: AppColors.border,
    );
  }
}