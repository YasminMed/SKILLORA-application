import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

enum TimelineEventType { course, achievement, project, milestone, exam, certification }
enum TimelineEventStatus { completed, current, upcoming }

class TimelineEvent {
  final String id, title, description, grade;
  final TimelineEventType type;
  final TimelineEventStatus status;
  final int? progress;
  final List<String>? achievements;
  final IconData icon;

  TimelineEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    this.progress,
    this.achievements,
    this.grade = '',
    required this.icon,
  });

  Color get typeColor {
    switch (type) {
      case TimelineEventType.course:
        return AppColors.primary;
      case TimelineEventType.achievement:
        return AppColors.accent;
      case TimelineEventType.project:
        return AppColors.darkBrown;
      case TimelineEventType.milestone:
        return AppColors.limeGreen;
      case TimelineEventType.exam:
        return AppColors.softGreen;
      case TimelineEventType.certification:
        return AppColors.accent;
    }
  }

  String get typeName => type.toString().split('.').last.capitalize();
}

extension StringCasingExtension on String {
  String capitalize() => length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
}

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({Key? key}) : super(key: key);
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  final ScrollController _scrollController = ScrollController();
  String selectedFilter = 'All';

  final List<TimelineEvent> timelineEvents = [
    TimelineEvent(
      id: '6',
      title: 'Mobile App Development',
      description: 'Learning Flutter & React Native',
      type: TimelineEventType.course,
      status: TimelineEventStatus.current,
      progress: 65,
      icon: Icons.phone_android,
    ),
    TimelineEvent(
      id: '4',
      title: 'AWS Cloud Cert',
      description: 'Passed AWS exam',
      type: TimelineEventType.certification,
      status: TimelineEventStatus.completed,
      grade: 'Pass',
      achievements: ['AWS'],
      icon: Icons.cloud_done,
    ),
    TimelineEvent(
      id: '1',
      title: '100 Days of Code',
      description: 'Coding challenge milestone',
      type: TimelineEventType.milestone,
      status: TimelineEventStatus.completed,
      achievements: ['Consistency', 'Problem Solving'],
      icon: Icons.flag,
    ),
    TimelineEvent(
      id: '8',
      title: 'Final Year Project',
      description: 'Present capstone project',
      type: TimelineEventType.project,
      status: TimelineEventStatus.upcoming,
      icon: Icons.pause_presentation,
    ),
  ];

  List<TimelineEvent> get filteredEvents {
    if (selectedFilter == 'All') return timelineEvents;
    return timelineEvents.where((e ) => e.status.name.capitalize() == selectedFilter).toList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final counts = {
      'Completed': timelineEvents.where((e) => e.status == TimelineEventStatus.completed).length,
      'Current': timelineEvents.where((e) => e.status == TimelineEventStatus.current).length,
      'Upcoming': timelineEvents.where((e) => e.status == TimelineEventStatus.upcoming).length,
    };

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.limeGreen.withOpacity(0.15),
            AppColors.white,
            AppColors.softGreen.withOpacity(0.1)
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(20),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildJourneyStats(counts),
                    const SizedBox(height: 20),
                    _buildFilterChips(),
                    const SizedBox(height: 20),
                    Text('Your Journey', style: AppTextStyles.h2.copyWith(fontSize: 22)),
                    const SizedBox(height: 16),
                    _buildTimeline(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) => Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [AppColors.primary, AppColors.accent]),
      boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.2), blurRadius: 20, offset: const Offset(0,4))],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    child: 
        // const SizedBox(width: 12),
      Center(child: Text('My Journey', style: AppTextStyles.h2.copyWith(color: AppColors.white, fontSize: 20))),
      
  );

  Widget _buildJourneyStats(Map<String,int> counts) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [AppColors.white, AppColors.limeGreen.withOpacity(0.3)]),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0,4))],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: counts.entries.map((e) => Column(
        children: [
          Icon(e.key=='Completed'?Icons.check_circle:e.key=='Current'?Icons.play_circle_outline:Icons.upcoming, color: AppColors.grey),
          const SizedBox(height: 6),
          Text('${e.value}', style: AppTextStyles.h1.copyWith(fontSize: 20)),
          Text(e.key, style: AppTextStyles.tiny.copyWith(fontSize: 11)),
        ],
      )).toList(),
    ),
  );

  Widget _buildFilterChips() {
    final filters = ['All','Completed','Current','Upcoming'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((f){
          final selected = f == selectedFilter;
          return Padding(
            padding: const EdgeInsets.only(right:8),
            child: GestureDetector(
              onTap: () => setState(() => selectedFilter=f),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal:16, vertical:8),
                decoration: BoxDecoration(
                  gradient: selected? const LinearGradient(colors:[AppColors.primary,AppColors.accent]): null,
                  color: selected? null : AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color:selected? AppColors.primary : AppColors.grey.withOpacity(0.3)),
                  boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.05), blurRadius:10)],
                ),
                child: Text(f, style: AppTextStyles.label.copyWith(color:selected? AppColors.white: AppColors.grey)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTimeline() => Column(
    children: List.generate(filteredEvents.length, (index){
      final e = filteredEvents[index];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline line & dot
            Container(
              width: 40,
              child: Column(
                children: [
                  if(index != 0)
                    Container(height: 20, width: 2, color: AppColors.grey.withOpacity(0.3)),
                  Container(
                    width: 12, height: 12,
                    decoration: BoxDecoration(
                      color: e.status==TimelineEventStatus.completed?AppColors.primary:
                             e.status==TimelineEventStatus.current?AppColors.accent:
                             AppColors.grey.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                  if(index != filteredEvents.length-1)
                    Container(height: 60, width: 2, color: AppColors.grey.withOpacity(0.3)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: _buildEventCard(e)),
          ],
        ),
      );
    }),
  );

  Widget _buildEventCard(TimelineEvent e){
    final isCurrent = e.status==TimelineEventStatus.current;
    final isCompleted = e.status==TimelineEventStatus.completed;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors:[AppColors.white, e.typeColor.withOpacity(isCurrent?0.15:0.08)]),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color:e.typeColor.withOpacity(isCurrent?0.4:0.2), width:1),
        boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.05), blurRadius:12, offset: const Offset(0,2))],
      ),



      //main txt/ titles
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(e.typeName, style: AppTextStyles.tiny.copyWith(color:e.typeColor, fontWeight: FontWeight.w600, fontSize:11)),
          const SizedBox(height: 6),
          Text(e.title, style: AppTextStyles.button.copyWith(fontSize:16, color: AppColors.darkBrown),),
          const SizedBox(height: 4),
          Text(e.description, style: AppTextStyles.small.copyWith(fontSize:13, color:AppColors.grey), maxLines:2, overflow: TextOverflow.ellipsis),

          
          
          if(isCurrent && e.progress!=null) ...[
            const SizedBox(height:8),
            LinearProgressIndicator(
              value: (e.progress??0) / 100,
              color: e.typeColor,
              backgroundColor: Colors.grey[200],
              minHeight: 6,
            ),
          ],

          if(isCompleted && e.grade!='') ...[
            const SizedBox(height:8),
            Text('Grade: ${e.grade}', style: AppTextStyles.label.copyWith(color:e.typeColor)),
          ],
        ],
      ),
    );
  }
}
