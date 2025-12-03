import 'package:flutter/material.dart';
import 'package:skillora/constants/app_colors_career.dart';
import 'package:skillora/constants/app_text_styles.dart';

void main() {
  runApp(const CVAnalyzerApp());
}

class CVAnalyzerApp extends StatelessWidget {
  const CVAnalyzerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV Analyzer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const CVAnalyzerWidget(),
    );
  }
}


class CVAnalyzerWidget extends StatefulWidget {
  const CVAnalyzerWidget({Key? key}) : super(key: key);

  @override
  State<CVAnalyzerWidget> createState() => _CVAnalyzerWidgetState();
}

class _CVAnalyzerWidgetState extends State<CVAnalyzerWidget> {
  bool isUploaded = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Custom AppBar
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFCBDFBD), Color(0xFFD4E09B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.darkBrown),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'CV Analyzer',
                    style: AppTextStyles.h2.copyWith(fontSize: 20, color: AppColors.darkBrown),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 430),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: isUploaded ? _buildAnalysisView() : _buildUploadView(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // upload view
  Widget _buildUploadView() {
    return Column(
      children: [
        const SizedBox(height: 32),
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.softGreen.withOpacity(0.3),
            borderRadius: BorderRadius.circular(60),
          ),
          child: Icon(
            Icons.insert_drive_file,
            size: 60,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 24),
        Text('Analyze Your CV', style: AppTextStyles.h2),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              isUploaded = true;
            });
          },
          icon: const Icon(Icons.upload_file),
          label: Text('Upload CV', style: AppTextStyles.button),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.darkBrown,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Supported formats: PDF, DOC, DOCX',
          style: AppTextStyles.tiny.copyWith(color: AppColors.grey),
        ),
        const SizedBox(height: 32),
        _buildInfoCard(
          'ATS Compatibility Check',
          'Ensure your CV passes applicant tracking systems',
          AppColors.lime,
          Icons.check_circle_outline,
        ),
        const SizedBox(height: 8),
        _buildInfoCard(
          'Skills Analysis',
          'Identify and highlight your key skills',
          AppColors.accent,
          Icons.psychology_outlined,
        ),
        const SizedBox(height: 8),
        _buildInfoCard(
          'Improvement Tips',
          'Get personalized recommendations',
          AppColors.softGreen,
          Icons.lightbulb_outline,
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CareerDetailsWidget()),
            );
          },
          child: Text(
            'View Career Details →',
            style: AppTextStyles.label.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String description, Color color, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.label),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.tiny.copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // analysis view
  Widget _buildAnalysisView() {
    final strengths = [
      'Strong technical skills section',
      'Clear work experience timeline',
      'Quantified achievements',
      'Professional summary included',
    ];
    final improvements = [
      'Add more action verbs',
      'Include relevant certifications',
      'Optimize for ATS keywords',
      'Add links to portfolio/projects',
    ];
    final skills = [
      'JavaScript',
      'React',
      'Python',
      'SQL',
      'Project Management',
      'Team Leadership',
      'Problem Solving',
      'Communication',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                  value: 0.78,
                  strokeWidth: 12,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
              Column(
                children: [
                  Text('78', style: AppTextStyles.h1.copyWith(fontSize: 48)),
                  Text('Good CV!', style: AppTextStyles.body.copyWith(color: AppColors.grey)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Text('Strengths', style: AppTextStyles.h2.copyWith(fontSize: 20)),
        const SizedBox(height: 8),
        _buildListCard(strengths, Icons.check_circle, AppColors.primary),
        const SizedBox(height: 8),
        Text('Areas to Improve', style: AppTextStyles.h2.copyWith(fontSize: 20)),
        const SizedBox(height: 8),
        _buildListCard(improvements, Icons.error_outline, AppColors.accent),
        const SizedBox(height: 8),
        Text('Detected Skills', style: AppTextStyles.h2.copyWith(fontSize: 20)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((skill) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(skill, style: AppTextStyles.small),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Text('Recommendations', style: AppTextStyles.h2.copyWith(fontSize: 20)),
        const SizedBox(height: 8),
        _buildRecommendationCard(
          'Add Portfolio Link',
          'Include links to your GitHub, portfolio, or professional website',
          AppColors.lime,
          Icons.lightbulb_outline,
        ),
        _buildRecommendationCard(
          'Quantify More Results',
          'Add more numbers and metrics to showcase your achievements',
          AppColors.accent,
          Icons.trending_up,
        ),
        _buildRecommendationCard(
          'Update Skills Section',
          'Add emerging technologies and tools relevant to your field',
          AppColors.softGreen,
          Icons.emoji_events_outlined,
        ),
      ],
    );
  }

  Widget _buildListCard(List<String> items, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 12),
                Expanded(child: Text(item, style: AppTextStyles.small)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRecommendationCard(String title, String description, Color color, IconData icon) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.label),
                const SizedBox(height: 4),
                Text(description, style: AppTextStyles.tiny.copyWith(color: AppColors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// career details widget
class CareerDetailsWidget extends StatelessWidget {
  const CareerDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom AppBar
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          color: AppColors.softGreen,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.darkBrown),
                onPressed: () => Navigator.pop(context),
              ),
              Text('Career Details', style: AppTextStyles.h2.copyWith(fontSize: 20, color: AppColors.darkBrown)),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 430),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  // Hero Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.lime],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Icon(Icons.engineering, color: AppColors.darkBrown, size: 32),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Software Engineer',
                                    style: AppTextStyles.h2.copyWith(fontSize: 22, color: AppColors.darkBrown),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Technology & Development',
                                    style: AppTextStyles.small.copyWith(color: AppColors.darkBrown.withOpacity(0.7)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildInfoChip(Icons.attach_money, '\$85K - \$120K'),
                            const SizedBox(width: 8),
                            _buildInfoChip(Icons.trending_up, 'High Demand'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Overview
                  Text('Overview', style: AppTextStyles.h2.copyWith(fontSize: 20)),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'Software engineers design, develop, and maintain software applications. They work with programming languages, frameworks, and tools to create solutions that solve real-world problems.',
                      style: AppTextStyles.body,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Key Responsibilities
                  Text('Key Responsibilities', style: AppTextStyles.h2.copyWith(fontSize: 20)),
                  const SizedBox(height: 8),
                  _buildResponsibilityCard('Write clean, efficient code', 'Develop high-quality software using best practices', Icons.code, AppColors.primary),
                  _buildResponsibilityCard('Collaborate with teams', 'Work with designers, product managers, and other engineers', Icons.people, AppColors.lime),
                  _buildResponsibilityCard('Debug and troubleshoot', 'Identify and fix issues in existing software systems', Icons.bug_report, AppColors.accent),
                  const SizedBox(height: 24),
                  // Skills
                  Text('Required Skills', style: AppTextStyles.h2.copyWith(fontSize: 20)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildSkillChip('JavaScript', AppColors.primary),
                      _buildSkillChip('React', AppColors.lime),
                      _buildSkillChip('Python', AppColors.accent),
                      _buildSkillChip('Git', AppColors.primary),
                      _buildSkillChip('Problem Solving', AppColors.lime),
                      _buildSkillChip('Teamwork', AppColors.accent),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.darkBrown),
          const SizedBox(width: 4),
          Text(label, style: AppTextStyles.small),
        ],
      ),
    );
  }

  Widget _buildResponsibilityCard(String title, String desc, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.label),
                const SizedBox(height: 4),
                Text(desc, style: AppTextStyles.tiny.copyWith(color: AppColors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(skill, style: AppTextStyles.small.copyWith(color: AppColors.darkBrown)),
    );
  }
}
