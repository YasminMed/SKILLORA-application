import 'package:flutter/material.dart';
import 'package:skillora/constants/app_colors_career.dart';
import 'package:skillora/constants/app_text_styles.dart';

void main() {
  runApp(const MyApp());
}

// ============================================================================
// APPBAR WIDGET (Text only, small height, gradient)
// ============================================================================
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, this.title = "Portfolio"});

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
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.darkBrown,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

// ============================================================================
// MODELS
// ============================================================================
class Project {
  final String id;
  final String title;
  final String description;
  final Color color;
  final List<String> tags;
  final int rating;
  final String link;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.tags,
    required this.rating,
    required this.link,
  });
}

class Skill {
  final String name;
  final int level;
  final Color color;

  Skill({
    required this.name,
    required this.level,
    required this.color,
  });
}

class Achievement {
  final IconData icon;
  final String title;
  final String description;

  Achievement({
    required this.icon,
    required this.title,
    required this.description,
  });
}

// ============================================================================
// PORTFOLIO SCREEN
// ============================================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Inter"),
      home: const PortfolioScreen(),
    );
  }
}

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  String activeTab = 'projects';

  final List<Project> projects = [
    Project(
      id: '1',
      title: 'E-Commerce Mobile App',
      description: 'Full-featured shopping app with payment integration and real-time inventory',
      color: AppColors.softGreen,
      tags: ['Flutter', 'Firebase', 'Stripe'],
      rating: 5,
      link: '#',
    ),
    Project(
      id: '2',
      title: 'Fitness Tracking Dashboard',
      description: 'Analytics dashboard for tracking workouts, calories, and progress metrics',
      color: AppColors.accent,
      tags: ['React', 'Node.js', 'MongoDB'],
      rating: 4,
      link: '#',
    ),
    Project(
      id: '3',
      title: 'Social Media Platform',
      description: 'Real-time messaging and content sharing platform with 10K+ users',
      color: AppColors.lime,
      tags: ['Next.js', 'PostgreSQL', 'Redis'],
      rating: 5,
      link: '#',
    ),
  ];

  final List<Skill> skills = [
    Skill(name: 'Flutter & Dart', level: 90, color: AppColors.secondary),
    Skill(name: 'React & TypeScript', level: 85, color: AppColors.accent),
    Skill(name: 'Node.js & Express', level: 80, color: AppColors.lime),
    Skill(name: 'Firebase & MongoDB', level: 75, color: AppColors.softGreen),
    Skill(name: 'UI/UX Design', level: 70, color: AppColors.darkBrown),
  ];

  final List<Achievement> achievements = [
    Achievement(
      icon: Icons.emoji_events,
      title: 'Best Mobile App 2024',
      description: 'Winner at Tech Innovation Awards',
    ),
    Achievement(
      icon: Icons.star,
      title: '50+ Projects Completed',
      description: 'Successfully delivered to clients',
    ),
    Achievement(
      icon: Icons.code,
      title: 'Open Source Contributor',
      description: '500+ contributions on GitHub',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFF5F5E8),
        child: Column(
          children: [
            // 🔹 REPLACED APPBAR
            const AppBarWidget(title: "My Portfolio"),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    // Profile Card
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Avatar
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [AppColors.softGreen, AppColors.accent],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'JD',
                                      style: AppTextStyles.body.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'John Doe',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF3A3A3A),
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Full Stack Developer',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF9A9A9A),
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          _buildSocialButton(Icons.code),
                                          const SizedBox(width: 8),
                                          _buildSocialButton(Icons.business_center),
                                          const SizedBox(width: 8),
                                          _buildSocialButton(Icons.email),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Stats
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildStatItem('50+', 'Projects', AppColors.secondary),
                                _buildStatItem('5+', 'Years Exp', AppColors.accent),
                                _buildStatItem('4.9', 'Rating', AppColors.lime),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Tab Buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildTabButton('Projects', 'projects'),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildTabButton('Skills', 'skills'),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildTabButton('Awards', 'achievements'),
                          ),
                        ],
                      ),
                    ),

                    // Content
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildTabContent(),
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

  Widget _buildSocialButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5ED),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(icon, size: 16, color: const Color(0xFF5A5A5A)),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: color,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFFB0B0B0),
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton(String label, String tab) {
    final isActive = activeTab == tab;
    return GestureDetector(
      onTap: () {
        setState(() {
          activeTab = tab;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.secondary : AppColors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isActive ? AppColors.white : const Color(0xFFA0A0A0),
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (activeTab) {
      case 'projects':
        return _buildProjectsTab();
      case 'skills':
        return _buildSkillsTab();
      case 'achievements':
        return _buildAchievementsTab();
      default:
        return _buildProjectsTab();
    }
  }

  Widget _buildProjectsTab() {
    return Column(
      children: projects.map((project) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      project.color.withOpacity(0.7),
                      project.color,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.work_outline,
                    size: 48,
                    color: AppColors.white.withOpacity(0.8),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3A3A3A),
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project.description,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9A9A9A),
                        fontFamily: 'Inter',
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.tags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5ED),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tag,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF7A7A7A),
                              fontFamily: 'Inter',
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < project.rating ? Icons.star : Icons.star_border,
                          size: 16,
                          color: index < project.rating ? AppColors.accent : const Color(0xFFD0D0D0),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSkillsTab() {
    return Column(
      children: skills.map((skill) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    skill.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3A3A3A),
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    '${skill.level}%',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: skill.color,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0E8),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: skill.level / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: skill.color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAchievementsTab() {
    return Column(
      children: achievements.map((achievement) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF5F0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  achievement.icon,
                  size: 28,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      achievement.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3A3A3A),
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      achievement.description,
                      style: AppTextStyles.body
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
