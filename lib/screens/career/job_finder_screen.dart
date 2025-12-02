import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ========== APP COLORS ==========
class AppColors {
  static const Color darkBrown = Color(0xFF6F5E53);
  static const Color limeGreen = Color(0xFFD4E09B);
  static const Color sageGreen = Color(0xFFCBDFBD);
  static const Color warmOrange = Color(0xFFF19C79);
  static const Color coralRed = Color(0xFFFF6B6B);

  static const Color softGreen = Color(0xFFE8F5E9);
  static const Color white = Colors.white;
  static const Color grey = Color(0xFFEEEEEE);
  static const Color accent = warmOrange;
}

// ========== APP TEXT STYLES ==========
class AppTextStyles {
  static final TextStyle h1 = GoogleFonts.inter(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: AppColors.darkBrown,
  );

  static final TextStyle h2 = GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.darkBrown,
  );

  static final TextStyle body = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.darkBrown,
  );

  static final TextStyle button = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static final TextStyle label = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.darkBrown,
  );

  static final TextStyle secondary = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.darkBrown,
  );

  static final TextStyle small = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.darkBrown,
  );

  static final TextStyle tiny = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.darkBrown,
  );
}

// ========== MAIN APP ==========
void main() {
  runApp(const JobFinderApp());
}

class JobFinderApp extends StatelessWidget {
  const JobFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JobFinder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.limeGreen,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: Scaffold(
        body: const JobFinderScreen(),
      ),
    );
  }
}

// ========== JOB FINDER SCREEN ==========
class JobFinderScreen extends StatelessWidget {
  const JobFinderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.limeGreen.withOpacity(0.2),
                AppColors.sageGreen.withOpacity(0.1),
                Colors.white,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const JobAppBar(userName: 'Alex'),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(height: 4),
                          JobSearchBar(),
                          SizedBox(height: 24),
                          JobFilterChips(),
                          SizedBox(height: 24),
                          RecommendedJobs(),
                          SizedBox(height: 24),
                          JobListings(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Fixed Bottom Buttons
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // CV Analyzer action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.limeGreen,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.description_outlined,
                            color: AppColors.darkBrown,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'CV Analyzer',
                            style: AppTextStyles.button.copyWith(
                              color: AppColors.darkBrown,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Salary Estimation action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.warmOrange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.analytics_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Salary Est.',
                            style: AppTextStyles.button,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ================= JOB APP BAR =================
class JobAppBar extends StatelessWidget {
  final String userName;

  const JobAppBar({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFCBDFBD), Color(0xFFD4E09B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
       
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
           
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo and App Name
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFCBDFBD), Color(0xFFD4E09B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.work_outline,
                  color: AppColors.darkBrown,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text('JobFinder', style: AppTextStyles.h2.copyWith(color: AppColors.darkBrown)),
            ],
          ),
          // Notifications and Avatar
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: AppColors.darkBrown,
                      size: 20,
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.coralRed,
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFCBDFBD), Color(0xFFD4E09B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    userName[0].toUpperCase(),
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.darkBrown,
                      fontWeight: FontWeight.w600,
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

// ========== JOB SEARCH BAR ==========
class JobSearchBar extends StatelessWidget {
  const JobSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              style: AppTextStyles.body,
              decoration: InputDecoration(
                hintText: 'Search job titles or keywords...',
                hintStyle: AppTextStyles.body.copyWith(
                  color: Colors.grey.shade400,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.darkBrown.withOpacity(0.5),
                  size: 20,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.limeGreen, AppColors.sageGreen],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.limeGreen.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.tune,
            color: AppColors.darkBrown,
            size: 20,
          ),
        ),
      ],
    );
  }
}

// ================= JOB FILTER CHIPS =================
class JobFilterChips extends StatefulWidget {
  const JobFilterChips({super.key});

  @override
  State<JobFilterChips> createState() => _JobFilterChipsState();
}

class _JobFilterChipsState extends State<JobFilterChips> {
  String? activeFilter;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildAIMatchChip(),
          const SizedBox(width: 10),
          _buildFilterChip('type', 'Job Type', Icons.work_outline),
          const SizedBox(width: 10),
          _buildFilterChip('location', 'Location', Icons.location_on_outlined),
          const SizedBox(width: 10),
          _buildFilterChip('salary', 'Salary Range', Icons.attach_money),
        ],
      ),
    );
  }

  Widget _buildAIMatchChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.coralRed, AppColors.warmOrange],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.coralRed.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text('AI Match', style: AppTextStyles.label.copyWith(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String id, String label, IconData icon) {
    final isActive = activeFilter == id;
    return GestureDetector(
      onTap: () {
        setState(() {
          activeFilter = isActive ? null : id;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.limeGreen : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? AppColors.limeGreen : Colors.grey.shade200,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isActive ? 0.15 : 0.05),
              blurRadius: isActive ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppColors.darkBrown,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(label, style: AppTextStyles.label),
            const SizedBox(width: 4),
            Icon(
              isActive ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: AppColors.darkBrown,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}

// ================= RECOMMENDED JOBS =================
class RecommendedJobs extends StatelessWidget {
  const RecommendedJobs({super.key});

  @override
  Widget build(BuildContext context) {
    final jobs = [
      RecommendedJob(
        companyName: 'TechCorp',
        jobTitle: 'Senior Product Manager',
        location: 'San Francisco',
        salary: '\$120k-\$150k',
        matchScore: 95,
        companyInitial: 'T',
        companyGradient: [const Color(0xFF667eea), const Color(0xFF764ba2)],
      ),
      RecommendedJob(
        companyName: 'InnovateLab',
        jobTitle: 'UX Designer Lead',
        location: 'Remote',
        salary: '\$100k-\$130k',
        matchScore: 88,
        companyInitial: 'I',
        companyGradient: [const Color(0xFFf093fb), const Color(0xFFf5576c)],
      ),
      RecommendedJob(
        companyName: 'DataWorks',
        jobTitle: 'Data Analyst',
        location: 'New York',
        salary: '\$90k-\$110k',
        matchScore: 82,
        companyInitial: 'D',
        companyGradient: [const Color(0xFF4facfe), const Color(0xFF00f2fe)],
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.warmOrange.withOpacity(0.2),
                    AppColors.coralRed.withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: AppColors.coralRed,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Text('Recommended for You', style: AppTextStyles.h2),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index < jobs.length - 1 ? 16 : 0,
                ),
                child: RecommendedJobCard(job: jobs[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class RecommendedJob {
  final String companyName;
  final String jobTitle;
  final String location;
  final String salary;
  final int matchScore;
  final String companyInitial;
  final List<Color> companyGradient;

  RecommendedJob({
    required this.companyName,
    required this.jobTitle,
    required this.location,
    required this.salary,
    required this.matchScore,
    required this.companyInitial,
    required this.companyGradient,
  });
}

class RecommendedJobCard extends StatelessWidget {
  final RecommendedJob job;

  const RecommendedJobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white,
            AppColors.limeGreen.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.limeGreen.withOpacity(0.4), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Company Logo and Match Score
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: job.companyGradient),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: job.companyGradient[0].withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    job.companyInitial,
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.limeGreen, AppColors.sageGreen],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.limeGreen.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: AppColors.darkBrown, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '${job.matchScore}% Match',
                      style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Job Details
          Text(
            job.jobTitle,
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            job.companyName,
            style: AppTextStyles.secondary.copyWith(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${job.location} • ${job.salary}',
            style: AppTextStyles.small.copyWith(color: Colors.grey.shade500),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.limeGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Apply', style: AppTextStyles.button),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                ),
                child: const Icon(Icons.bookmark_outline, color: AppColors.darkBrown),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// ================= JOB LISTINGS =================
class JobListings extends StatelessWidget {
  const JobListings({super.key});

  @override
  Widget build(BuildContext context) {
    final jobs = [
      'Software Engineer',
      'Product Manager',
      'UX Designer',
      'Data Analyst',
      'Marketing Specialist',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Job Listings', style: AppTextStyles.h2),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(jobs[index], style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
