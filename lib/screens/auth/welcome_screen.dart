//welcome
import 'package:flutter/material.dart';
import 'package:skillora/screens/auth/splash.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        /// Background gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFF6B6B),
              Color(0xFFFFE6E6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.30]
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            /// LOGO
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.9),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.auto_awesome,
                  color: AppColors.primary,
                  size: 55,
                ),
              ),
            ),

            const SizedBox(height: 40),

            /// TITLE
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "welcome to ",
                    style: AppTextStyles.h1.copyWith(
                      color: Colors.black,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 4,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                  TextSpan(
                    text: "Skillora",
                    style: AppTextStyles.h1.copyWith(
                      color: AppColors.primary,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 4,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),


            const SizedBox(height: 12),

            Container(
              width: 200,
              height: 30,
              decoration: BoxDecoration(
                color: Color(0xffF19C79).withOpacity(0.2),

                borderRadius: BorderRadius.circular(14)
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.auto_awesome_outlined, size: 16,color: AppColors.primary,),
                    Text(
                      "Start your journey here",
                      style: AppTextStyles.secondary,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 200),

            /// MAIN BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SkilluraSplashScreen()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Get Started",
                        style: AppTextStyles.button,
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios,
                          color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}