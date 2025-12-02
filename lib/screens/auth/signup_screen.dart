import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skillora/screens/modes.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // BACK BUTTON
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
                onPressed: () => Navigator.pop(context),
              ),

              const SizedBox(height: 10),

              /// TITLE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign Up",
                      style: AppTextStyles.h1.copyWith(
                        color: Colors.black,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Create new account",
                      style: AppTextStyles.secondary.copyWith(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // WHITE CARD
              Container(
                height: 440,
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
                margin: const EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.4),
                    width: 1.4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Email
                    Text("Email", style: AppTextStyles.secondary.copyWith(color: Colors.black)),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        decoration: _inputDecoration(),
                      ),
                    ),
                    const SizedBox(height: 22),

                    /// Password
                    Text("Password", style: AppTextStyles.secondary.copyWith(color: Colors.black)),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        obscureText: true,
                        decoration: _inputDecoration(),
                      ),
                    ),
                    const SizedBox(height: 22),

                    /// Confirm Password
                    Text("Confirm Password", style: AppTextStyles.secondary.copyWith(color: Colors.black)),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        obscureText: true,
                        decoration: _inputDecoration(),
                      ),
                    ),

                    const SizedBox(height: 60),

                    /// CREATE ACCOUNT BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          _showSuccessPopup(context);
                        },
                        child: Text(
                          "Create Account",
                          style: AppTextStyles.button.copyWith(fontSize: 15),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// LOGIN LINK
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: AppTextStyles.small.copyWith(
                            color: Colors.black87,
                            fontSize: 13,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const LoginScreen()),
                            );
                          },
                          child: Text(
                            "Log in",
                            style: AppTextStyles.small.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  /// POPUP SUCCESS WINDOW WITH LOTTIE
  void _showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
    
      barrierDismissible: false, // user cannot dismiss manually
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // LOTTIE SUCCESS CHECK
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Lottie.asset("assets/lottie/Check.json"),
                ),

                const SizedBox(height: 10),

                // TEXT
                const Text(
                  "New account created successfully",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // WAIT 2 SECONDS THEN GO TO LOGIN SCREEN
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pop(context); // close popup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  /// INPUT FIELD DECORATION
  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade200,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
