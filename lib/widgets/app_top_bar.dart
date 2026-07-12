import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../views/home_screen.dart';

/// Shared header used across all 4 main screens: avatar + "صدى" title,
/// with an optional back arrow (used on every screen except Home).
///
/// UI ONLY — the back button performs simple navigation (pop, or fall back
/// to Home), not business logic.
class AppTopBar extends StatelessWidget {
  final bool showBackButton;
  final Color? titleColor;
  final Color? iconColor;

  const AppTopBar({
    super.key,
    this.showBackButton = false,
    this.titleColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedTitleColor = titleColor ?? AppColors.white;
    final resolvedIconColor = iconColor ?? AppColors.white;

    return Row(
      children: [
        // Avatar
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: resolvedIconColor.withOpacity(0.5),
              width: 1.5,
            ),
            image: const DecorationImage(
              image: AssetImage('assets/images/avatar.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'صدى',
              style: TextStyle(
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: resolvedTitleColor,
              ),
            ),
          ),
        ),
        if (showBackButton)
          IconButton(
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              }
            },
            icon: Icon(Icons.arrow_forward_rounded, color: resolvedIconColor),
          )
        else
          // Keeps the title perfectly centered when there's no back button.
          const SizedBox(width: 44),
      ],
    );
  }
}