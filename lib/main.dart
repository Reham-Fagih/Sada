import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'utils/app_theme.dart';
import 'views/home_screen.dart';

void main() {
  runApp(const SadaApp());
}

class SadaApp extends StatelessWidget {
  const SadaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'صدى',

      theme: AppTheme.lightTheme,

      // Arabic RTL Support
      locale: const Locale('ar'),

      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      home: const HomeScreen(),
    );
  }
}