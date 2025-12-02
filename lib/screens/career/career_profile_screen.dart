import 'package:flutter/material.dart';
import 'package:skillora/constants/app_colors_career.dart';
import 'package:skillora/constants/app_text_styles.dart';



// ------------------------------
// Main App
// ------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Career Profile',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.white,
      ),
      home:  CareerProfileScreen(),
    );
  }
}

// ------------------------------
// Custom App Bar Widget
// ------------------------------
class AppBarWidget extends StatelessWidget {
  final String userName;
  const AppBarWidget({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.person,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Career Profile',
                style: AppTextStyles.h1,
              ),
            ],
          ),

          // Removed initial and kept an empty circle
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
             
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: const SizedBox(), // EMPTY (NO J ANYMORE)
          ),
        ],
      ),
    );
  }
}

// ------------------------------
// Career Profile Screen
// ------------------------------
class CareerProfileScreen extends StatelessWidget {
  const CareerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: SafeArea(
        child: Column(
          children: [
            const AppBarWidget(userName: 'John'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Avatar + Name
                    Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, AppColors.accent],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              color: AppColors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "John Doe",
                          style: AppTextStyles.h2.copyWith(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "john.doe@example.com",
                          style: AppTextStyles.small.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    _sectionTitle("Account Settings"),
                    _profileAction(
                      icon: Icons.person,
                      text: "Edit Profile Name",
                      color: AppColors.primary,
                      onTap: () => _editNameSheet(context),
                    ),
                    _profileAction(
                      icon: Icons.lock,
                      text: "Change Password",
                      color: AppColors.primary,
                      onTap: () => _editPasswordSheet(context),
                    ),

                    const SizedBox(height: 20),
                    _sectionTitle("Navigation"),
                    _profileAction(
                      icon: Icons.school,
                      text: "Switch to Study Mode",
                      color: AppColors.primary,
                      onTap: () => _switchStudySheet(context),
                    ),
                    _profileAction(
                      icon: Icons.swap_horiz,
                      text: "Switch to Another Account",
                      color: AppColors.primary,
                      onTap: () => _switchAccountSheet(context),
                    ),

                    const SizedBox(height: 20),
                    _sectionTitle("Danger Zone"),
                    _profileAction(
                      icon: Icons.logout,
                      text: "Logout",
                      color: Colors.red,
                      onTap: () {
                        _confirmAction(
                          context,
                          title: "Logout",
                          message: "Are you sure you want to log out?",
                          onYes: () {},
                        );
                      },
                    ),
                    _profileAction(
                      icon: Icons.delete_forever,
                      text: "Delete Account",
                      color: Colors.red.shade700,
                      onTap: () {
                        _confirmAction(
                          context,
                          title: "Delete Account",
                          message: "This action cannot be undone!",
                          onYes: () {},
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------
  // Section Title
  // ------------------------------
  Widget _sectionTitle(String title) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: AppTextStyles.h2.copyWith(
          color: AppColors.primary,
          fontSize: 18,
        ),
      ),
    );
  }

  // ------------------------------
  // Profile Action Tile
  // ------------------------------
  Widget _profileAction({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.white,
            AppColors.softGreen.withOpacity(0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.softGreen.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 12,
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.accent, AppColors.primary],
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.white, size: 20),
        ),
        title: Text(
          text,
          style: AppTextStyles.body.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: color, size: 16),
      ),
    );
  }

  // ------------------------------
  // Confirm Dialog
  // ------------------------------
  void _confirmAction(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onYes,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            title,
            style: AppTextStyles.h2.copyWith(
              color: AppColors.primary,
              fontSize: 18,
            ),
          ),
          content: Text(
            message,
            style: AppTextStyles.body,
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancel",
                style: AppTextStyles.button.copyWith(
                  color: AppColors.grey,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(
                "Yes",
                style: AppTextStyles.button.copyWith(
                  color: AppColors.primary,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                onYes();
              },
            ),
          ],
        );
      },
    );
  }

  // ------------------------------
  // Bottom Sheets
  // ------------------------------
  void _editNameSheet(BuildContext context) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 22,
            right: 22,
            top: 22,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Edit Profile Name",
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.primary,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                style: AppTextStyles.body,
                decoration: InputDecoration(
                  labelText: "New Name",
                  labelStyle: AppTextStyles.label,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: AppColors.primary, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Save",
                  style: AppTextStyles.button,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _editPasswordSheet(BuildContext context) {
    final oldPass = TextEditingController();
    final newPass = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 22,
            right: 22,
            top: 22,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Change Password",
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.primary,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: oldPass,
                obscureText: true,
                style: AppTextStyles.body,
                decoration: InputDecoration(
                  labelText: "Old Password",
                  labelStyle: AppTextStyles.label,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: newPass,
                obscureText: true,
                style: AppTextStyles.body,
                decoration: InputDecoration(
                  labelText: "New Password",
                  labelStyle: AppTextStyles.label,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Update Password",
                  style: AppTextStyles.button,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _switchStudySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Switch to Study Mode?",
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.primary,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text("Go", style: AppTextStyles.button),
              ),
            ],
          ),
        );
      },
    );
  }

  void _switchAccountSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Switch account?",
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.primary,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text("Go to Login", style: AppTextStyles.button),
              ),
            ],
          ),
        );
      },
    );
  }
}
