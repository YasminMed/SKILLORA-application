import 'package:flutter/material.dart';

// ================== IMPORT CAREER SCREENS ==================
import 'package:skillora/screens/career/career_dashboard_screen.dart';
import 'package:skillora/screens/career/job_finder_screen.dart';
import 'package:skillora/screens/career/portfolio_screen.dart';
import 'package:skillora/screens/career/skill_tracker_screen.dart';
import 'package:skillora/screens/career/career_roadmap_screen.dart';
import 'package:skillora/screens/career/careert_bottom_nav_bar.dart';


// ================== IMPORT NAV BAR ==================
// 
class CareerMainLayout extends StatefulWidget {
  const CareerMainLayout({super.key});

  @override
  State<CareerMainLayout> createState() => _CareerMainLayoutState();
}

class _CareerMainLayoutState extends State<CareerMainLayout> {
  // current active tab
  String activeTab = "dashboard";

  // handle tab change
  void _onTabChange(String tabId) {
    setState(() {
      activeTab = tabId;
    });
  }

  // screens map
  Widget _getScreen(String tab) {
    switch (tab) {
      case "jobs":
        return const PastelJobFinderWidget();
      case "portfolio":
        return const PortfolioScreen();
      case "skills":
        return const SkillTrackerScreen();
      case "roadmap":
        return const CareerRoadmapScreenWidget();
      default:
        return const CareerDashboardWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(activeTab),

      bottomNavigationBar: CareerBottomNavBar(
        activeTab: activeTab,
        onTabChange: _onTabChange,
      ),
    );
  }
}
