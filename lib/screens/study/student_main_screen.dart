import 'package:flutter/material.dart';
import 'package:skillora/screens/study/study_dashboard_screen.dart';
import 'package:skillora/screens/study/course_list_screen.dart';
import 'package:skillora/screens/study/study_goals_screen.dart';
import 'package:skillora/screens/study/notes_screen.dart';
import 'package:skillora/screens/study/time_line_screen.dart';
import 'student_bottom_navbar.dart';
class StudentMainScreen extends StatefulWidget {
  const StudentMainScreen({super.key});

  @override
  State<StudentMainScreen> createState() => _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen> {
  String activeTab = 'dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildCurrentScreen(),
      bottomNavigationBar: StudentBottomNavBar(
        activeTab: activeTab,
        onTabChange: (tab) {
          setState(() {
            activeTab = tab;
          });
        },
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (activeTab) {
      case 'dashboard':
        return const StudentDashboard();
      case 'courses':
        return const CourseListScreen();
      case 'goals':
        return const StudentGoalScreen();
      case 'notes':
        return const NotesWidget();
      case 'journey':
        return const TimelineScreen();
      default:
        return const StudentDashboard();
    }
  }
}
