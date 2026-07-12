import 'package:flutter/material.dart';

import 'utils/app_theme.dart';
import 'views/home_screen.dart';

void main() {
  runApp(const EchoApp());
}

class EchoApp extends StatelessWidget {
  const EchoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'صدى',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}