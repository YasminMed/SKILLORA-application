import 'package:flutter/material.dart';
import 'constants/app_colors.dart';
import 'constants/app_text_styles.dart';
import 'screens/auth/welcome_screen.dart';

void main() {
  runApp(const CareerPathApp());
}

class CareerPathApp extends StatelessWidget {
  const CareerPathApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Career Path',
      debugShowCheckedModeBanner: false,

      // THEME SETTINGS
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          elevation: 0,
          titleTextStyle: AppTextStyles.h2.copyWith(color: Colors.white),
          iconTheme: const IconThemeData(color: Colors.white),
        
        ),
        textTheme: TextTheme(
          headlineLarge: AppTextStyles.h1,
          headlineMedium: AppTextStyles.h2,
          bodyMedium: AppTextStyles.body,
          bodySmall: AppTextStyles.small,
        ),
        useMaterial3: true,
      ),

      // FIRST SCREEN
      home:  WelcomeScreen(),
    );
  }
}