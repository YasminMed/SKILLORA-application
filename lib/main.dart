import 'package:flutter/material.dart';
import 'package:skillora/screens/auth/forgot_password_screen.dart';
import 'package:skillora/screens/auth/login_screen.dart';
import 'package:skillora/screens/auth/reset_password_screen.dart';
import 'package:skillora/screens/auth/signup_screen.dart';
import 'package:skillora/screens/auth/splash.dart';
import 'package:skillora/screens/auth/submit_code_screen.dart';
import 'package:skillora/screens/career/career_main_layout.dart.dart';
import 'package:skillora/screens/career/career_profile_screen.dart';
import 'package:skillora/screens/career/cv_analyzer_screen.dart';
import 'package:skillora/screens/career/salary_estimation_screen.dart';

import 'package:skillora/screens/modes.dart';

import 'package:skillora/screens/study/student_main_screen.dart';
import 'package:skillora/screens/study/study_profile_screen.dart';

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
      title: 'Skillura',
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

      initialRoute: '/',
      routes: {
        //auth and splash paths
        '/': (context) => const WelcomeScreen(),
        '/splash': (context) => const SkilluraSplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/forgot_password': (context) => const ForgotPasswordEmailScreen(),
        '/code_submit': (context) => const SubmitCodeScreen(),
        '/reset_pass':(context)=> const ResetPasswordScreen(),
        '/modes': (context) => const Modes(),
        
        '/student_main': (context) => const StudentMainScreen(),
        '/student_profile': (context) => const StudyProfileWidget(),
        
        '/career_main': (context) => const CareerMainLayout(),
        '/career_profile': (context) => const CareerProfileScreen(),
        '/cv_analyzer': (context) => const CVAnalyzerWidget(),
        '/salary_estimator': (context) => const SalaryEstimationWidget(),

      }
    );
  }
}