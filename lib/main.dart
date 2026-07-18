import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PostureSenseApp());
}

class PostureSenseApp extends StatelessWidget {
  const PostureSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  theme: AppTheme.lightTheme,
      title: 'PostureSense',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),

      
    );
  }
}