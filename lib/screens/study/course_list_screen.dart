import 'package:flutter/material.dart';
import 'package:skillora/constants/app_colors.dart';
import 'package:skillora/constants/app_text_styles.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({Key? key}) : super(key: key);

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  String selectedFilter = "All";

  final filters = ["All", "Completed", "In Progress", "Easy", "Medium", "Hard"];

  final takenCourses = [
    TakenCourse("Web Dev Fundamentals", 100, 42, "Medium", Icons.code),
    TakenCourse("UI/UX Design", 45, 25, "Easy", Icons.palette),
    TakenCourse("DS & Algorithms", 60, 58, "Hard", Icons.psychology),
  ];

  final availableCourses = [
    AvailableCourse("ML Basics", "Medium", "6 weeks", Icons.memory),
    AvailableCourse("Intro to Cybersecurity", "Hard", "4 weeks", Icons.security),
    AvailableCourse("Graphic Design Starter", "Easy", "3 weeks", Icons.brush),
  ];

  List<TakenCourse> get filteredTaken {
    switch (selectedFilter) {
      case "Completed": return takenCourses.where((c) => c.progress == 100).toList();
      case "In Progress": return takenCourses.where((c) => c.progress < 100).toList();
      case "Easy": case "Medium": case "Hard": return takenCourses.where((c) => c.difficulty == selectedFilter).toList();
      default: return takenCourses;
    }
  }

  Color difficultyColor(String diff) {
    switch (diff) {
      case "Easy": return AppColors.softGreen;
      case "Medium": return AppColors.accent;
      case "Hard": return Colors.redAccent;
      default: return AppColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [AppColors.white, AppColors.softGreen.withOpacity(0.05)]),
        ),
        child: Column(
          children: [
            
            //App Bar
            Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.primary, AppColors.accent]),
              boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.2), blurRadius: 20, offset: const Offset(0,4))],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: 
                
              Center(child: Text('Courses', style: AppTextStyles.h2.copyWith(color: AppColors.white, fontSize: 20))),
              
          ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("Taken Courses"),
                    const SizedBox(height: 8),
                    _filters(),
                    const SizedBox(height: 16),
                    ...filteredTaken.map(_takenCourseCard),
                    const SizedBox(height: 30),
                    _sectionTitle("Available Courses"),
                    const SizedBox(height: 12),
                    ...availableCourses.map(_availableCourseCard),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => Text(
        title,
        style: AppTextStyles.h1.copyWith(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.primary),
      );

  Widget _filters() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((f) {
            final active = f == selectedFilter;
            return GestureDetector(
              onTap: () => setState(() => selectedFilter = f),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  gradient: active ? const LinearGradient(colors: [AppColors.primary, AppColors.accent]) : null,
                  color: active ? null : AppColors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(f, style: active ? AppTextStyles.button : AppTextStyles.label.copyWith(color: AppColors.darkBrown)),
              ),
            );
          }).toList(),
        ),
      );

  Widget _takenCourseCard(TakenCourse c) => Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [AppColors.white, AppColors.softGreen.withOpacity(0.18)]),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.softGreen.withOpacity(0.2)),
          boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.05), blurRadius: 12)],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppColors.accent.withOpacity(0.25), AppColors.primary.withOpacity(0.2)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(c.icon, color: AppColors.accent, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(c.title, style: AppTextStyles.label.copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.timer, size: 16, color: AppColors.grey),
                      const SizedBox(width: 4),
                      Text("${c.hours} hrs", style: AppTextStyles.small),
                      const SizedBox(width: 12),
                      Icon(Icons.bolt, size: 16, color: difficultyColor(c.difficulty)),
                      const SizedBox(width: 4),
                      Text(c.difficulty, style: AppTextStyles.small),
                    ],
                  ),
                  const SizedBox(height: 6),

                  
                  // Progress Bar
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(3)),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: c.progress / 100,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(colors: [AppColors.accent, AppColors.primary]),
                                borderRadius: BorderRadius.all(Radius.circular(3)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text("${c.progress}%", style: AppTextStyles.small),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );

  Widget _availableCourseCard(AvailableCourse c) => Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [AppColors.white, AppColors.limeGreen.withOpacity(0.18)]),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.limeGreen.withOpacity(0.25)),
          boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.05), blurRadius: 12)],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppColors.limeGreen.withOpacity(0.4), AppColors.softGreen.withOpacity(0.3)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(c.icon, color: AppColors.accent, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(c.title, style: AppTextStyles.label.copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.bolt, size: 16, color: difficultyColor(c.difficulty)),
                      const SizedBox(width: 4),
                      Text(c.difficulty, style: AppTextStyles.small),
                      const SizedBox(width: 12),
                      Icon(Icons.schedule, size: 16, color: AppColors.grey),
                      const SizedBox(width: 4),
                      Text(c.duration, style: AppTextStyles.small),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [AppColors.primary, AppColors.accent]),
                borderRadius: BorderRadius.all(Radius.circular(14)),
              ),
              child: Text("Register", style: AppTextStyles.button),
            )
          ],
        ),
      );
}

// Models
class TakenCourse {
  final String title;
  final int progress;
  final int hours;
  final String difficulty;
  final IconData icon;
  TakenCourse(this.title, this.progress, this.hours, this.difficulty, this.icon);
}

class AvailableCourse {
  final String title;
  final String difficulty;
  final String duration;
  final IconData icon;
  AvailableCourse(this.title, this.difficulty, this.duration, this.icon);
}
