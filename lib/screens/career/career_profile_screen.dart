import 'package:flutter/material.dart';
import 'package:skillora/constants/app_colors_career.dart';
import 'package:skillora/constants/app_text_styles.dart';

// ============================================================================
// NEW APPBAR WIDGET
// ============================================================================
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, this.title = "Career Profile"});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD4E09B), Color(0xFFCBDFBD)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            // BACK BUTTON
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF5C432A),
                size: 20,
              ),
            ),
            const Spacer(),
            // TITLE
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF5C432A),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

// ============================================================================
// MAIN APP
// ============================================================================
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
      home: const CareerProfileScreen(),
    );
  }
}

// ============================================================================
// CAREER PROFILE SCREEN
// ============================================================================
class CareerProfileScreen extends StatelessWidget {
  const CareerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const AppBarWidget(title: "Career Profile"),
      body: SingleChildScrollView(
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
                      colors: [AppColors.primary, AppColors.lime],
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
              color: AppColors.darkBrown,
              onTap: () => _editNameSheet(context),
            ),
            _profileAction(
              icon: Icons.lock,
              text: "Change Password",
              color: AppColors.darkBrown,
              onTap: () => _editPasswordSheet(context),
            ),

            const SizedBox(height: 20),
            _sectionTitle("Navigation"),
            _profileAction(
              icon: Icons.school,
              text: "Switch to Study Mode",
              color: AppColors.darkBrown,
              onTap: () => _switchStudySheet(context),
            ),
            _profileAction(
              icon: Icons.swap_horiz,
              text: "Switch to Another Account",
              color: AppColors.darkBrown,
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
                  onYes: () {
                    Navigator.pushNamed(context, "/login");
                  },
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
    );
  }

  // ================================================================
  // SECTION TITLE
  // ================================================================
  Widget _sectionTitle(String title) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: AppTextStyles.h2.copyWith(
          color: AppColors.grey,
          fontSize: 18,
        ),
      ),
    );
  }

  // ================================================================
  // PROFILE ACTION TILE
  // ================================================================
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
              colors: [AppColors.lime, AppColors.primary],
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

  // ================================================================
  // CONFIRM DIALOG
  // ================================================================
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

  // ================================================================
  // BOTTOM SHEETS
  // ================================================================
  void _editNameSheet(BuildContext context) {
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
              const TextField(
                decoration: InputDecoration(
                  labelText: "New Name",
                  border: OutlineInputBorder(),
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
                child: Text("Save", style: AppTextStyles.button),
              ),
            ],
          ),
        );
      },
    );
  }

  void _editPasswordSheet(BuildContext context) {
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
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "New Password",
                  border: OutlineInputBorder(),
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
                child: Text("Update Password", style: AppTextStyles.button),
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
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
          ),
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
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/modes");
                  },
                  child: Text("Go", style: AppTextStyles.button),
                ),
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
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
          ),
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
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/login");
                  },
                  child: Text("Go to Login", style: AppTextStyles.button),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
