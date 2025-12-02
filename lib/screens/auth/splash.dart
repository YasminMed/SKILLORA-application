import 'dart:async';
import 'package:flutter/material.dart';
import 'package:skillora/constants/app_colors.dart';
import 'package:skillora/screens/auth/signup_screen.dart';

class SkilluraSplashScreen extends StatefulWidget {
  const SkilluraSplashScreen({super.key});

  @override
  State<SkilluraSplashScreen> createState() => _SkilluraSplashScreenState();
}

class _SkilluraSplashScreenState extends State<SkilluraSplashScreen> {
  final PageController _controller = PageController();
  late Timer _timer;
  int _currentIndex = 0;

  final List<Map<String, String>> splashData = [
    {
      "image": "assets/images/splash_1.png",
      "title": "Track Your Study Journey",
      "text":
          "Stay organized and monitor your progress with smooth and smart tools."
    },
    {
      "image": "assets/images/splash_2.png",
      "title": "Build Your Career Path",
      "text":
          "Discover courses, improve your skills, and shape your professional future."
    },
    {
      "image": "assets/images/splash_3.png",
      "title": "Achieve Your Academic Goals",
      "text":
          "Set goals, stay motivated, and progress through your learning roadmap."
    },
  ];

  @override
  void initState() {
    super.initState();

    // AUTO SLIDER — FIXED WITH SAFETY
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return; // الشاشة مو موجودة

      if (_controller.hasClients) {
        setState(() {
          _currentIndex =
              (_currentIndex + 1) % splashData.length; // loop safely
        });

        _controller.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // مهم جداً لإيقاف التايمر
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // ---------------- SLIDER ----------------
            Expanded(
              flex: 6,
              child: PageView.builder(
                controller: _controller,
                itemCount: splashData.length,
                onPageChanged: (index) {
                  if (mounted) {
                    setState(() => _currentIndex = index);
                  }
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  return Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(26),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primary.withOpacity(0.15),
                                    AppColors.accent.withOpacity(0.15),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(26),
                              ),
                              child: Image.asset(
                                splashData[index]["image"]!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // ---------------- DOTS ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                splashData.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  height: 8,
                  width: _currentIndex == index ? 28 : 10,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? AppColors.primary
                        : AppColors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ---------------- TEXT ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Text(
                    splashData[_currentIndex]["title"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    splashData[_currentIndex]["text"]!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.darkBrown.withOpacity(0.85),
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ---------------- BUTTON ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 55),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => SignUpScreen()),
                  );
                },
                child: const Text(
                  "Create account",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 26),
          ],
        ),
      ),
    );
  }
}
