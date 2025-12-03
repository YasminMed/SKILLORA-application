import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
            Color(0xFFFF6B6B),
            Color(0xFFFFE6E6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.60]

          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                //back btn
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                //title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Update password",
                      style: AppTextStyles.h1.copyWith(
                        color: Colors.black,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Create your new password",
                      style: AppTextStyles.secondary.copyWith(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

                const SizedBox(height: 40),

                //white card
                Container(
                  height: 400,
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
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
                    children: [
                      SizedBox(height: 20,),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(100),

                      ),
                      child: Center(child: Icon(Icons.key, size: 32,color: Colors.white,),),
                      
                    ),
                    SizedBox(height: 25,),

                      //password
                    Align(alignment:Alignment.centerLeft,child:  Text("Password", style: AppTextStyles.secondary. copyWith(color: Colors.black),)),
                    SizedBox(
                      height: 40,
                      child: TextField(
                      
                        decoration: _inputDecoration(),
                      ),
                    ),
                    const SizedBox(height: 22),

                    //confirm password
                   Align(alignment: Alignment.centerLeft,child: Text("Confirm password", style: AppTextStyles.secondary. copyWith(color: Colors.black),)),
                    SizedBox(
                      height: 40,
                      child: TextField(
                      
                        decoration: _inputDecoration(),
                      ),
                    ),
                    const SizedBox(height: 40),

                      //save btn
                      SizedBox(
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
                            Navigator.pushNamed(
                              context,
                              '/modes',
                            );
                          },
                          child: Text("Save Password", style: AppTextStyles.button),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }


   /// input decoration
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
