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
      home: Scaffold(
        body: SafeArea(child: const PastelJobFinderWidget()),
      ),
    );
  }
}

//appbar
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, this.title = "Find Jobs"});

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

//job models
class Job {
  final int id;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String logo;
  final String type;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.logo,
    required this.type,
  });
}

//job finder screen
class PastelJobFinderWidget extends StatefulWidget {
  const PastelJobFinderWidget({Key? key}) : super(key: key);

  @override
  State<PastelJobFinderWidget> createState() => _PastelJobFinderWidgetState();
}

class _PastelJobFinderWidgetState extends State<PastelJobFinderWidget> {
  String searchQuery = '';
  String selectedFilter = 'All';
  Set<int> savedJobs = {};

  final List<String> filters = ['All', 'Full-time', 'Part-time', 'Remote'];

  final List<Job> jobs = [
    Job(
        id: 1,
        title: 'UI/UX Designer',
        company: 'Google',
        location: 'Family Mall',
        salary: '\$1k - \$900',
        logo: '🎨',
        type: 'Full-time'),
    Job(
        id: 2,
        title: 'Frontend Developer',
        company: 'Meta',
        location: 'Remote',
        salary: '\$90k - \$140k',
        logo: '💻',
        type: 'Full-time'),
    Job(
        id: 3,
        title: 'Product Manager',
        company: 'Amazon',
        location: 'Empire',
        salary: '\$20k - \$1k',
        logo: '📦',
        type: 'Full-time'),
    Job(
        id: 4,
        title: 'Mobile Developer',
        company: 'Apple',
        location: '32Park',
        salary: '\$95k - \$135k',
        logo: '📱',
        type: 'Full-time'),
    Job(
        id: 5,
        title: 'Data Analyst',
        company: 'Microsoft',
        location: 'Redmond',
        salary: '\$75k - \$110k',
        logo: '📊',
        type: 'Part-time'),
  ];

  void toggleSaveJob(int jobId) {
    setState(() {
      savedJobs.contains(jobId) ? savedJobs.remove(jobId) : savedJobs.add(jobId);
    });
  }

  List<Job> get filteredJobs {
    final limitedJobs = jobs.take(4).toList(); // Only 4 jobs
    return limitedJobs.where((job) {
      final searchMatch = job.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          job.company.toLowerCase().contains(searchQuery.toLowerCase());
      final filterMatch = selectedFilter == 'All' ||
          job.type == selectedFilter ||
          (selectedFilter == 'Remote' && job.location == 'Remote');
      return searchMatch && filterMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.softGreen,
        child: Column(
          children: [
            const AppBarWidget(title: "Find Jobs"),
      
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // search bar
                    SizedBox(
                      height: 42,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.grey.withOpacity(0.3)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Icon(Icons.search, size: 20, color: AppColors.grey),
                            const SizedBox(width: 6),
                            Expanded(
                              child: TextField(
                                onChanged: (v) => setState(() => searchQuery = v),
                                decoration: InputDecoration(
                                  hintText: "Search...",
                                  border: InputBorder.none,
                                  hintStyle: AppTextStyles.body.copyWith(color: AppColors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
      
                    // filter dropdown
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.grey.withOpacity(0.3)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: DropdownButton<String>(
                        value: selectedFilter,
                        underline: const SizedBox(),
                        isExpanded: true,
                        onChanged: (v) => setState(() => selectedFilter = v!),
                        items: filters.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e, style: AppTextStyles.body.copyWith(color: AppColors.darkBrown)),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 18),
      
                    // two btns
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/salary_estimator',
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: AppColors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text("Salary Estimation"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/cv_analyzer',
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondary,
                              foregroundColor: AppColors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text("CV Analyzer"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
      
                    // job cards
                    Column(
                      children: filteredJobs.map((job) {
                        final isSaved = savedJobs.contains(job.id);
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.grey.withOpacity(0.3)),
                          ),
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 52,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: AppColors.grey.withOpacity(0.3)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(job.logo, style: const TextStyle(fontSize: 28)),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(job.title,
                                            style: AppTextStyles.body.copyWith(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.darkBrown,
                                            )),
                                        const SizedBox(height: 5),
                                        Text(job.company,
                                            style: AppTextStyles.body.copyWith(
                                              color: AppColors.grey,
                                              fontSize: 14,
                                            )),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => toggleSaveJob(job.id),
                                    icon: Icon(
                                      isSaved ? Icons.bookmark : Icons.bookmark_border,
                                      color: isSaved ? AppColors.secondary : AppColors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  Icon(Icons.location_on, size: 15, color: AppColors.grey),
                                  const SizedBox(width: 6),
                                  Text(job.location, style: AppTextStyles.body.copyWith(color: AppColors.grey)),
                                  const SizedBox(width: 10),
                                  Text("•", style: TextStyle(color: AppColors.grey)),
                                  const SizedBox(width: 10),
                                  Text(job.salary, style: AppTextStyles.body.copyWith(color: AppColors.grey)),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
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
}
