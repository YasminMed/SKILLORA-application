import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromARGB(255, 153, 214, 109); // Soft Green
  static const Color secondary = Color(0xFFFF6B6B); // Coral Red
  static const Color softGreen = Color(0xFFCBDFBD); // Soft Green
  static const Color lime = Color(0xFFD4E09B); // Lime Green
  static const Color accent = Color(0xFFF19C79); // Warm Orange
  static const Color darkBrown = Color(0xFF6F5E53); // Dark Brown
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFFBDBDBD);
}

class NavItem {
  final String id;
  final String label;
  final IconData icon;

  NavItem({
    required this.id,
    required this.label,
    required this.icon,
  });
}

class CareerBottomNavBar extends StatelessWidget {
  final String activeTab;
  final Function(String) onTabChange;

  const CareerBottomNavBar({
    Key? key,
    required this.activeTab,
    required this.onTabChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<NavItem> navItems = [
      NavItem(id: 'dashboard', label: 'Dashboard', icon: Icons.dashboard),
      NavItem(id: 'jobs', label: 'Jobs', icon: Icons.work),
      NavItem(id: 'portfolio', label: 'Portfolio', icon: Icons.folder),
      NavItem(id: 'skills', label: 'Skills', icon: Icons.trending_up),
      NavItem(id: 'roadmap', label: 'Roadmap', icon: Icons.route),
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5E8),
        border: Border(
          top: BorderSide(
            color: Colors.black.withOpacity(0.05),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            top: 6,
            bottom: 10,
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 330),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 18,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: navItems.map((item) {
                final isActive = activeTab == item.id;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onTabChange(item.id),
                    child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      child: Container(
                        width: isActive ? 50 : 36,
                        height: isActive ? 50 : 36,
                        decoration: BoxDecoration(
                          color: isActive ? AppColors.primary : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          item.icon,
                          size: isActive ? 26 : 22,
                          color: isActive ? AppColors.white : AppColors.lightGrey,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}