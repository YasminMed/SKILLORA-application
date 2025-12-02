import 'package:flutter/material.dart';

void main() {
  runApp(const SkillTrackerApp());
}

class SkillTrackerApp extends StatelessWidget {
  const SkillTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillTracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Inter',
      ),
      home: const SkillTrackerScreen(),
    );
  }
}

class SkillTrackerScreen extends StatelessWidget {
  const SkillTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFAFAFA),
            Colors.white,
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // AppBar replacement
            const SkillTrackerAppBar(userName: 'Alex'),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SkillsOverview(),
                      SizedBox(height: 24),
                      SkillsInProgress(),
                      SizedBox(height: 24),
                      RecommendedSkills(),
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

// ==================== APP BAR ====================
class SkillTrackerAppBar extends StatelessWidget {
  final String userName;

  const SkillTrackerAppBar({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD4E09B), Color(0xFFCBDFBD)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo and App Name
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFD4E09B), Color(0xFFCBDFBD)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.trending_up,
                  color: Color(0xFF6F5E53),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'SkillTracker',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6F5E53),
                      height: 1,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Track your growth',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // User Avatar
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF19C79), Color(0xFFFF6B6B)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF6B6B).withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                userName[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== SKILLS OVERVIEW ====================
class SkillsOverview extends StatelessWidget {
  const SkillsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = [
      SkillOverviewData(
        name: 'Programming',
        progress: 0.75,
        color: const Color(0xFFD4E09B),
        icon: Icons.code,
      ),
      SkillOverviewData(
        name: 'Design',
        progress: 0.60,
        color: const Color(0xFFF19C79),
        icon: Icons.palette_outlined,
      ),
      SkillOverviewData(
        name: 'Data Analysis',
        progress: 0.45,
        color: const Color(0xFFCBDFBD),
        icon: Icons.storage_outlined,
      ),
      SkillOverviewData(
        name: 'Communication',
        progress: 0.80,
        color: const Color(0xFFFF6B6B),
        icon: Icons.chat_bubble_outline,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Skills Overview',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6F5E53),
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: skills.length,
          itemBuilder: (context, index) {
            return CircularSkillCard(skill: skills[index]);
          },
        ),
      ],
    );
  }
}

class SkillOverviewData {
  final String name;
  final double progress;
  final Color color;
  final IconData icon;

  SkillOverviewData({
    required this.name,
    required this.progress,
    required this.color,
    required this.icon,
  });
}

class CircularSkillCard extends StatelessWidget {
  final SkillOverviewData skill;

  const CircularSkillCard({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 75,
            height: 75,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 75,
                  height: 75,
                  child: CircularProgressIndicator(
                    value: 1.0,
                    strokeWidth: 6,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xFFF3F4F6)),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(
                  width: 75,
                  height: 75,
                  child: CircularProgressIndicator(
                    value: skill.progress,
                    strokeWidth: 6,
                    valueColor: AlwaysStoppedAnimation<Color>(skill.color),
                    backgroundColor: Colors.transparent,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: skill.color.withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    skill.icon,
                    color: skill.color,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            skill.name,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6F5E53),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(
            '${(skill.progress * 100).toInt()}%',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: skill.color,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== SKILLS IN PROGRESS ====================
class SkillsInProgress extends StatelessWidget {
  const SkillsInProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = [
      SkillProgressData(
        name: 'React Development',
        level: 'Intermediate',
        completion: 0.68,
        color: const Color(0xFFD4E09B),
        xp: '340/500 XP',
      ),
      SkillProgressData(
        name: 'UI/UX Design',
        level: 'Beginner',
        completion: 0.45,
        color: const Color(0xFFF19C79),
        xp: '225/500 XP',
      ),
      SkillProgressData(
        name: 'Python Programming',
        level: 'Advanced',
        completion: 0.82,
        color: const Color(0xFFCBDFBD),
        xp: '410/500 XP',
      ),
      SkillProgressData(
        name: 'Public Speaking',
        level: 'Intermediate',
        completion: 0.55,
        color: const Color(0xFFFF6B6B),
        xp: '275/500 XP',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Skills in Progress',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6F5E53),
              ),
            ),
            Row(
              children: const [
                Icon(
                  Icons.emoji_events_outlined,
                  color: Color(0xFF6F5E53),
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  'Keep going!',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6F5E53),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: skills.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return SkillProgressCard(skill: skills[index]);
          },
        ),
      ],
    );
  }
}

class SkillProgressData {
  final String name;
  final String level;
  final double completion;
  final Color color;
  final String xp;

  SkillProgressData({
    required this.name,
    required this.level,
    required this.completion,
    required this.color,
    required this.xp,
  });
}

class SkillProgressCard extends StatelessWidget {
  final SkillProgressData skill;

  const SkillProgressCard({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: skill.color.withOpacity(0.25),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: skill.color.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.book_outlined,
              color: skill.color,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            skill.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6F5E53),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            skill.level,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${(skill.completion * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: skill.color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: skill.completion,
                    backgroundColor: const Color(0xFFF3F4F6),
                    valueColor: AlwaysStoppedAnimation<Color>(skill.color),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  skill.xp,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== RECOMMENDED SKILLS ====================
class RecommendedSkills extends StatelessWidget {
  const RecommendedSkills({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = [
      RecommendedSkillData(
        name: 'Machine Learning',
        category: 'AI & Data',
        duration: '12 weeks',
        icon: Icons.psychology_outlined,
        color: const Color(0xFFD4E09B),
      ),
      RecommendedSkillData(
        name: 'Agile Management',
        category: 'Project Management',
        duration: '8 weeks',
        icon: Icons.track_changes_outlined,
        color: const Color(0xFFF19C79),
      ),
      RecommendedSkillData(
        name: 'Creative Thinking',
        category: 'Soft Skills',
        duration: '6 weeks',
        icon: Icons.lightbulb_outline,
        color: const Color(0xFFCBDFBD),
      ),
      RecommendedSkillData(
        name: 'TypeScript Mastery',
        category: 'Programming',
        duration: '10 weeks',
        icon: Icons.flash_on_outlined,
        color: const Color(0xFFFF6B6B),
      ),
      RecommendedSkillData(
        name: 'Leadership Skills',
        category: 'Management',
        duration: '8 weeks',
        icon: Icons.groups_outlined,
        color: const Color(0xFF6F5E53),
      ),
      RecommendedSkillData(
        name: 'Growth Hacking',
        category: 'Marketing',
        duration: '7 weeks',
        icon: Icons.rocket_launch_outlined,
        color: const Color(0xFFD4E09B),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recommended Skills to Learn',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6F5E53),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'View all',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6F5E53),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: skills.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return RecommendedSkillCard(skill: skills[index]);
            },
          ),
        ),
      ],
    );
  }
}

class RecommendedSkillData {
  final String name;
  final String category;
  final String duration;
  final IconData icon;
  final Color color;

  RecommendedSkillData({
    required this.name,
    required this.category,
    required this.duration,
    required this.icon,
    required this.color,
  });
}

class RecommendedSkillCard extends StatelessWidget {
  final RecommendedSkillData skill;

  const RecommendedSkillCard({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: skill.color.withOpacity(0.25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              skill.icon,
              color: skill.color,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            skill.name,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6F5E53),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            skill.category,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
            ),
          ),
          const Spacer(),
          Text(
            skill.duration,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: skill.color,
            ),
          ),
        ],
      ),
    );
  }
}
