import 'package:flutter/material.dart';
import 'package:skillora/constants/app_colors.dart';
import 'package:skillora/constants/app_text_styles.dart';

class StudyProfileWidget extends StatelessWidget {
  const StudyProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: AppColors.white,
        child: Column(
          children: [
            // appbar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: AppColors.white),
                    ),
                  ),
                  const Text(
                    "Profile",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // body
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
                            child: Text(
                              "S",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "SmSm",
                          style: TextStyle(
                            color: AppColors.black.withOpacity(0.87),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "smsm@example.com",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 14,
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
                      icon: Icons.route,
                      text: "Switch to Career Path",
                      color: AppColors.darkBrown,
                      onTap: () => _switchCareerSheet(context),
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
            ),
          ],
        ),
      ),
    );
  }

  // sec title
  Widget _sectionTitle(String title) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  //action tile
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
          colors: [AppColors.white, AppColors.softGreen.withOpacity(0.15)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.softGreen.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 12,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
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
            style: TextStyle(
                color: color, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: color, size: 16),
        ),
      ),
    );
  }

  // confirm dialog
  void _confirmAction(BuildContext context,
      {required String title,
      required String message,
      required VoidCallback onYes}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: Text(title,
              style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          content: Text(message,
              style: const TextStyle(color: AppColors.darkBrown)),
          actions: [
            TextButton(
              child: const Text("Cancel",
                  style: TextStyle(color: AppColors.grey)),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text("Yes",
                  style:
                      TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
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

  // bottom sheets

  void _editNameSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Edit Name",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary)),
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
                ),
                onPressed: () => Navigator.pop(context),
                child: Text("Edit",style: AppTextStyles.button, ), ),
              
            ],
          ),
        );
      },
    );
  }

  void _editPasswordSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Change Password",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary)),
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
                ),
                onPressed: () => Navigator.pop(context),
                child: Text("Edit",style: AppTextStyles.button, ),),
              
            ],
          ),
        );
      },
    );
  }

  void _switchCareerSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, //full width
    backgroundColor: Colors.transparent, 
    builder: (context) {
      return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Switch to Career Path?",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary)),
            const SizedBox(height: 16),
            SizedBox(
              width: 200, 
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/modes");
                },
                child: Text("Sure", style: AppTextStyles.button),
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
    builder: (context) {
      return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Switch Account?",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary)),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/login");
                },
                child: Text("Switch", style: AppTextStyles.button),
              ),
            ),
          ],
        ),
      );
    },
  );
}
}
