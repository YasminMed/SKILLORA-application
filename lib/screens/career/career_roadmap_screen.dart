import 'package:flutter/material.dart';
import 'package:skillora/constants/app_colors_career.dart';
import 'package:skillora/constants/app_text_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Career Roadmap',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.white,
      ),
      home: const CareerRoadmapScreenWidget(),
    );
  }
}

//appbar
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, this.title = "Career Roadmap"});
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
            colors: [Color(0xFFD4E09B), Color(0xFFCBDFBD)], // Linear gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.darkBrown, // Brown text
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

//roadmap screen
class CareerRoadmapScreenWidget extends StatelessWidget {
  const CareerRoadmapScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppBarWidget(),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderCard(),
                const SizedBox(height: 24),
                Text(
                  "Your Journey",
                  style: AppTextStyles.h2.copyWith(
                      color: AppColors.darkBrown, fontSize: 24),
                ),
                const SizedBox(height: 16),
                _buildRoadmapItem(
                  phase: "Phase 1",
                  title: "Junior Developer",
                  duration: "0-2 Years",
                  status: RoadmapStatus.completed,
                  skills: ["HTML/CSS", "JavaScript", "Git Basics", "Flutter Basics"],
                  achievements: ["Built 3 mobile apps", "Completed bootcamp"],
                ),
                _buildRoadmapItem(
                  phase: "Phase 2",
                  title: "Mid-Level Developer",
                  duration: "2-4 Years",
                  status: RoadmapStatus.current,
                  skills: ["State Management", "REST APIs", "Firebase", "Unit Testing"],
                  achievements: ["Lead small projects", "Mentor juniors"],
                ),
                _buildRoadmapItem(
                  phase: "Phase 3",
                  title: "Senior Developer",
                  duration: "4-6 Years",
                  status: RoadmapStatus.upcoming,
                  skills: ["Architecture", "Design Patterns", "CI/CD", "Performance Optimization"],
                  achievements: ["Architect solutions", "Tech leadership"],
                ),
                _buildRoadmapItem(
                  phase: "Phase 4",
                  title: "Tech Lead",
                  duration: "6-8 Years",
                  status: RoadmapStatus.future,
                  skills: ["Team Management", "Project Planning", "Code Review", "Stakeholder Communication"],
                  achievements: ["Lead engineering teams", "Drive technical decisions"],
                ),
                _buildRoadmapItem(
                  phase: "Phase 5",
                  title: "Engineering Manager / Architect",
                  duration: "8+ Years",
                  status: RoadmapStatus.future,
                  skills: ["Strategic Planning", "Budget Management", "Hiring", "Cross-functional Leadership"],
                  achievements: ["Shape company tech direction", "Build high-performing teams"],
                ),
                const SizedBox(height: 24),
                _buildActionButton(context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD4E09B), Color(0xFFCBDFBD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.map_outlined, color: AppColors.white, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Career Path",
                      style: AppTextStyles.h2.copyWith(color: AppColors.white, fontSize: 20),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Track your progress and plan ahead",
                      style: AppTextStyles.small.copyWith(color: AppColors.white.withOpacity(0.9)),
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

  Widget _buildRoadmapItem({
    required String phase,
    required String title,
    required String duration,
    required RoadmapStatus status,
    required List<String> skills,
    required List<String> achievements,
  }) {
    Color statusColor = _getStatusColor(status);
    IconData statusIcon = _getStatusIcon(status);
    String statusText = _getStatusText(status);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [statusColor, statusColor.withOpacity(0.7)]),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 3),
                ),
                child: Icon(statusIcon, color: AppColors.white, size: 24),
              ),
              if (status != RoadmapStatus.future)
                Container(
                  width: 3,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [statusColor, statusColor.withOpacity(0.3)],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.white, statusColor.withOpacity(0.1)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(phase, style: AppTextStyles.tiny.copyWith(color: statusColor, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Text(title, style: AppTextStyles.h2.copyWith(fontSize: 18, color: AppColors.darkBrown)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 14, color: AppColors.grey),
                      const SizedBox(width: 4),
                      Text(duration, style: AppTextStyles.small.copyWith(color: AppColors.grey)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: statusColor.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                        child: Text(statusText, style: AppTextStyles.tiny.copyWith(color: statusColor, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFD4E09B), Color(0xFFCBDFBD)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const CustomizeRoadmapSheet(),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Text("Customize Your Roadmap", style: AppTextStyles.button.copyWith(color: AppColors.darkBrown)),
      ),
    );
  }

  Color _getStatusColor(RoadmapStatus status) {
    switch (status) {
      case RoadmapStatus.completed:
        return AppColors.primary;
      case RoadmapStatus.current:
        return AppColors.accent;
      case RoadmapStatus.upcoming:
        return AppColors.lime;
      case RoadmapStatus.future:
        return Colors.grey.shade400;
    }
  }

  IconData _getStatusIcon(RoadmapStatus status) {
    switch (status) {
      case RoadmapStatus.completed:
        return Icons.check_circle;
      case RoadmapStatus.current:
        return Icons.play_circle_filled;
      case RoadmapStatus.upcoming:
        return Icons.schedule;
      case RoadmapStatus.future:
        return Icons.lock_outline;
    }
  }

  String _getStatusText(RoadmapStatus status) {
    switch (status) {
      case RoadmapStatus.completed:
        return "Completed";
      case RoadmapStatus.current:
        return "In Progress";
      case RoadmapStatus.upcoming:
        return "Next";
      case RoadmapStatus.future:
        return "Future";
    }
  }
}


enum RoadmapStatus { completed, current, upcoming, future }


class CustomizeRoadmapSheet extends StatefulWidget {
  const CustomizeRoadmapSheet({super.key});

  @override
  State<CustomizeRoadmapSheet> createState() => _CustomizeRoadmapSheetState();
}

class _CustomizeRoadmapSheetState extends State<CustomizeRoadmapSheet> {
  final TextEditingController _careerGoalController = TextEditingController();
  String _selectedExperience = "0-2 Years";
  String _selectedField = "Software Development";

  final List<String> _experienceLevels = ["0-2 Years", "2-4 Years", "4-6 Years", "6-8 Years", "8+ Years"];
  final List<String> _careerFields = ["Software Development", "Data Science", "Product Management", "UI/UX Design", "DevOps Engineering", "Mobile Development"];

  @override
  void dispose() {
    _careerGoalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(color: AppColors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(2)),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: AppColors.darkBrown),
                ),
                const SizedBox(width: 12),
                Text("Customize Roadmap", style: AppTextStyles.h2.copyWith(fontSize: 20, color: AppColors.darkBrown)),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Career Goal", style: AppTextStyles.label.copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _careerGoalController,
                    decoration: InputDecoration(
                      hintText: "e.g., Senior Software Engineer",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text("Experience Level", style: AppTextStyles.label.copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedExperience,
                    items: _experienceLevels.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (value) => setState(() => _selectedExperience = value!),
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                  ),
                  const SizedBox(height: 16),
                  Text("Field", style: AppTextStyles.label.copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedField,
                    items: _careerFields.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (value) => setState(() => _selectedField = value!),
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFFD4E09B), Color(0xFFCBDFBD)]),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text("Save Changes", style: AppTextStyles.button.copyWith(color: AppColors.darkBrown)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
