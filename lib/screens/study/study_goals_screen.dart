import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

class Goal {
  final String id;
  final String title;
  final int progress;
  final bool isCompleted;

  Goal({
    required this.id,
    required this.title,
    required this.progress,
    this.isCompleted = false,
  });

  // Default styling for UI
  Color get categoryColor => AppColors.primary;
  IconData get categoryIcon => Icons.flag_outlined;
}

class StudentGoalScreen extends StatefulWidget {
  const StudentGoalScreen({Key? key}) : super(key: key);

  @override
  _StudentGoalScreenState createState() => _StudentGoalScreenState();
}

class _StudentGoalScreenState extends State<StudentGoalScreen> {
  final List<Goal> goals = [
    Goal(id: '1', title: 'Complete Data Structures Course', progress: 75),
    Goal(id: '2', title: 'Learn Flutter Development', progress: 45),
  ];

  String selectedFilter = 'All';

  List<Goal> get filteredGoals {
    if (selectedFilter == 'All') return goals;
    if (selectedFilter == 'Active') return goals.where((g) => !g.isCompleted && g.progress < 100).toList();
    if (selectedFilter == 'Completed') return goals.where((g) => g.isCompleted || g.progress == 100).toList();
    return goals;
  }

  @override
  Widget build(BuildContext context) {
    final activeGoals = goals.where((g) => !g.isCompleted).length;
    final completedGoals = goals.where((g) => g.isCompleted).length;
    final totalProgress = goals.isEmpty ? 0.0 : goals.fold<double>(0, (sum, g) => sum + g.progress) / goals.length;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.limeGreen.withOpacity(0.15),
                AppColors.white,
                AppColors.softGreen.withOpacity(0.1),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildGoalSummary(activeGoals, completedGoals, totalProgress),
                        const SizedBox(height: 20),
                        _buildFilterChips(),
                        const SizedBox(height: 16),
                        _buildGoalsList(),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Floating button
        Positioned(
          bottom: 20,
          right: 20,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.primary, AppColors.accent]),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: FloatingActionButton.extended(
              onPressed: () {},
              backgroundColor: Colors.transparent,
              elevation: 0,
              icon: const Icon(Icons.add, color: AppColors.white),
              label: Text('Add Goal', style: AppTextStyles.button.copyWith(color: AppColors.white)),
            ),
          ),
        ),
      ],
    );
  }

  _buildAppBar() => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [AppColors.primary, AppColors.accent]),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Center(
          child: Text('My Goals', style: AppTextStyles.h2.copyWith(color: AppColors.white, fontSize: 20)),
        ),
      );

  Widget _buildGoalSummary(int active, int completed, double progress) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.white, AppColors.limeGreen.withOpacity(0.3)]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Goals Overview', style: AppTextStyles.h2.copyWith(fontSize: 20)),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildSummaryCard('Active', '$active', Icons.flag_outlined, AppColors.primary),
              const SizedBox(width: 12),
              _buildSummaryCard('Completed', '$completed', Icons.check_circle_outline, AppColors.softGreen),
            ],
          ),
          const SizedBox(height: 12),
          _buildProgressBar('Overall Progress', progress),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [AppColors.white, AppColors.white.withOpacity(0.4)]),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(value, style: AppTextStyles.h1.copyWith(color: color, fontSize: 24)),
            Text(label, style: AppTextStyles.small.copyWith(color: AppColors.grey, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(String label, double progress) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.white, AppColors.white.withOpacity(0.4)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(label, style: AppTextStyles.small.copyWith(color: AppColors.grey)),
            Text('${progress.toInt()}%', style: AppTextStyles.button.copyWith(color: AppColors.darkBrown)),
          ]),
          const SizedBox(height: 8),
          Container(
            height: 8,
            decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4)),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress / 100,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [AppColors.accent, AppColors.primary]),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['All', 'Active', 'Completed'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isSelected = selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => selectedFilter = filter),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  gradient: isSelected ? const LinearGradient(colors: [AppColors.primary, AppColors.accent]) : null,
                  color: isSelected ? null : AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  filter,
                  style: AppTextStyles.label.copyWith(color: isSelected ? AppColors.white : AppColors.grey),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildGoalsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: filteredGoals.map((goal) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildGoalCard(goal),
        );
      }).toList(),
    );
  }

  Widget _buildGoalCard(Goal goal) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.white, goal.categoryColor.withOpacity(0.08)]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: goal.categoryColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: goal.categoryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(goal.categoryIcon, color: goal.categoryColor, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(goal.title, style: AppTextStyles.button.copyWith(color: AppColors.black)),
              ),
              Text('${goal.progress}%', style: AppTextStyles.label.copyWith(color: goal.categoryColor)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 6,
            decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(3)),
            child: FractionallySizedBox(
              widthFactor: goal.progress / 100,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: goal.categoryColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
