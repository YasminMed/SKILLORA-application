import 'package:flutter/material.dart';
import 'package:skillora/constants/app_colors_career.dart';
import 'package:skillora/constants/app_text_styles.dart';
import 'dart:math' as math;


class CareerDashboardWidget extends StatelessWidget {
  const CareerDashboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.lime.withOpacity(0.15),
            AppColors.white,
            AppColors.softGreen.withOpacity(0.10),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const AppBarWidget(userName: 'Alex'),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    CareerProgressWidget(
                      goalsCompleted: 8,
                      totalGoals: 12,
                      currentLevel: 'Mid',
                      experiencePoints: 2450,
                    ),
                    SizedBox(height: 16),
                    RecentActivitiesWidget(),
                    SizedBox(height: 16),
                    CareerSuggestionsWidget(),
                    SizedBox(height: 16),
                    PeopleWidget(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  final String userName;

  const AppBarWidget({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, const Color.fromARGB(2255, 212, 224, 155)],
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
                  Icons.work_outline,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Career Path',
                style: TextStyle(fontSize: 22,
                fontWeight: FontWeight.bold, color: AppColors.darkBrown),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                userName,
                style: TextStyle(
                  color: AppColors.white.withOpacity(0.9),
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 10),
             GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/career_profile',
                  );
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.white.withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.1),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      userName[0].toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// CIRCULAR PROGRESS PAINTER & WIDGET
// ============================================================================

class CircularProgressPainter extends CustomPainter {
  final double percentage;
  final Color activeColor;
  final Color backgroundColor;
  final double strokeWidth;

  CircularProgressPainter({
    required this.percentage,
    required this.activeColor,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor.withOpacity(0.2)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final progressPaint = Paint()
      ..color = activeColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * (percentage / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CircularProgressWidget extends StatelessWidget {
  final double percentage;
  final double size;
  final double strokeWidth;
  final Color activeColor;
  final Color backgroundColor;
  final String centerText;
  final String subText;

  const CircularProgressWidget({
    Key? key,
    required this.percentage,
    this.size = 120,
    this.strokeWidth = 10,
    this.activeColor = AppColors.primary,
    this.backgroundColor = AppColors.white,
    this.centerText = '',
    this.subText = 'Complete',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: CircularProgressPainter(
              percentage: percentage,
              activeColor: activeColor,
              backgroundColor: backgroundColor,
              strokeWidth: strokeWidth,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                centerText.isNotEmpty ? centerText : '${percentage.toInt()}%',
                style: AppTextStyles.h2.copyWith(
                  fontSize: 24,
                ),
              ),
              Text(
                subText,
                style: AppTextStyles.small.copyWith(
                  color: AppColors.accent.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// CAREER PROGRESS WIDGET
// ============================================================================

class CareerProgressWidget extends StatelessWidget {
  final int goalsCompleted;
  final int totalGoals;
  final String currentLevel;
  final int experiencePoints;

  const CareerProgressWidget({
    Key? key,
    required this.goalsCompleted,
    required this.totalGoals,
    required this.currentLevel,
    required this.experiencePoints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percentage = (goalsCompleted / totalGoals * 100).toDouble();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.white,
            AppColors.lime.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.lime.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Career Progress',
            style: AppTextStyles.h2.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 14),
          Center(
            child: CircularProgressWidget(
              percentage: percentage,
              centerText: '$goalsCompleted/$totalGoals',
              subText: 'Goals',
            ),
          ),
          const SizedBox(height: 14),
          _buildStatCard(
            icon: Icons.trending_up,
            label: 'Current Level',
            value: '$currentLevel Level',
          ),
          const SizedBox(height: 10),
          _buildStatCard(
            icon: Icons.stars,
            label: 'Experience Points',
            value: '$experiencePoints XP',
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.white.withOpacity(0.8),
            AppColors.white.withOpacity(0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.white.withOpacity(0.6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.accent, AppColors.secondary],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Icon(icon, color: AppColors.white, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.small.copyWith(color: AppColors.grey)),
                Text(value, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// RECENT ACTIVITIES WIDGET
// ============================================================================

class Activity {
  final String title;
  final int progress;
  final IconData icon;

  Activity({required this.title, required this.progress, required this.icon});
}

class RecentActivitiesWidget extends StatelessWidget {
  const RecentActivitiesWidget({Key? key}) : super(key: key);

  static final List<Activity> activities = [
    Activity(
      title: 'Leadership Training Workshop',
      progress: 75,
      icon: Icons.people_outline,
    ),
    Activity(
      title: 'Advanced Project Management',
      progress: 45,
      icon: Icons.assignment_outlined,
    ),
    Activity(
      title: 'Technical Skills Development',
      progress: 60,
      icon: Icons.code,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Activities', style: AppTextStyles.h2.copyWith(fontSize: 20)),
        const SizedBox(height: 10),
        ...activities.map((activity) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildActivityCard(activity),
            )),
      ],
    );
  }

  Widget _buildActivityCard(Activity activity) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.white,
            AppColors.softGreen.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.softGreen.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.accent.withOpacity(0.2),
                  AppColors.accent.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.accent.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Icon(
              activity.icon,
              color: AppColors.accent,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: AppTextStyles.label.copyWith(fontSize: 15),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: activity.progress / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.accent, AppColors.secondary],
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(3)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${activity.progress}%',
                      style: AppTextStyles.small.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.softGreen],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Text(
              'Continue',
              style: AppTextStyles.button.copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// CAREER SUGGESTIONS WIDGET
// ============================================================================

class CareerSuggestion {
  final String title;
  final String description;
  final IconData icon;
  final bool isHighlighted;

  CareerSuggestion({
    required this.title,
    required this.description,
    required this.icon,
    this.isHighlighted = false,
  });
}

class CareerSuggestionsWidget extends StatelessWidget {
  const CareerSuggestionsWidget({Key? key}) : super(key: key);

  static final List<CareerSuggestion> suggestions = [
    CareerSuggestion(
      title: 'Senior Developer Role',
      description: 'Take the next step in your technical leadership journey',
      icon: Icons.rocket_launch,
      isHighlighted: true,
    ),
    CareerSuggestion(
      title: 'Product Management Course',
      description: 'Expand your skills into product strategy and roadmapping',
      icon: Icons.lightbulb_outline,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Career Suggestions', style: AppTextStyles.h2.copyWith(fontSize: 20)),
        const SizedBox(height: 10),
        ...suggestions.map((suggestion) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildSuggestionCard(suggestion),
            )),
      ],
    );
  }

  Widget _buildSuggestionCard(CareerSuggestion suggestion) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.white,
            AppColors.lime.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.lime.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 20,
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.lime.withOpacity(0.3),
                      AppColors.softGreen.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.lime.withOpacity(0.4),
                    width: 1,
                  ),
                ),
                child: Icon(
                  suggestion.icon,
                  color: AppColors.accent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      suggestion.title,
                      style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      suggestion.description,
                      style: AppTextStyles.secondary.copyWith(fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.accent, AppColors.secondary],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accent.withOpacity(0.3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Text(
                        'Explore',
                        style: AppTextStyles.button.copyWith(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}

// ============================================================================
// PEOPLE WIDGET
// ============================================================================

class Person {
  final String name;
  final String role;
  final String initials;

  Person({
    required this.name,
    required this.role,
    required this.initials,
  });
}

class PeopleWidget extends StatelessWidget {
  const PeopleWidget({Key? key}) : super(key: key);

  static final List<Person> people = [
    Person(
      name: 'Sarah Johnson',
      role: 'Senior Product Manager',
      initials: 'SJ',
    ),
    Person(
      name: 'Michael Chen',
      role: 'Tech Lead',
      initials: 'MC',
    ),
    Person(
      name: 'Emma Williams',
      role: 'Career Coach',
      initials: 'EW',
    ),
    Person(
      name: 'James Martinez',
      role: 'Engineering Director',
      initials: 'JM',
    ),
  ];

  static final List<List<Color>> avatarGradients = [
    const [AppColors.secondary, AppColors.accent],
    const [AppColors.accent, AppColors.softGreen],
    [AppColors.softGreen, AppColors.lime],
    [AppColors.lime, AppColors.primary],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mentors & Colleagues', style: AppTextStyles.h2.copyWith(fontSize: 20)),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.85,
          ),
          itemCount: people.length,
          itemBuilder: (context, index) {
            return _buildPersonCard(people[index], index);
          },
        ),
      ],
    );
  }

  Widget _buildPersonCard(Person person, int index) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.white, Colors.grey.shade50],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.grey.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: avatarGradients[index % avatarGradients.length],
              ),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Center(
              child: Text(
                person.initials,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            person.name,
            style: AppTextStyles.small.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            person.role,
            style: AppTextStyles.tiny,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.softGreen],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Text(
              'Connect',
              style: AppTextStyles.button.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
