import 'package:flutter/material.dart';
import 'package:skillora/constants/app_colors.dart';
import 'package:skillora/constants/app_text_styles.dart';
import 'package:skillora/screens/career/career_main_layout.dart.dart';
import 'package:skillora/screens/study/student_main_screen.dart';
import 'package:skillora/screens/study/study_dashboard_screen.dart';



void main() {
  runApp(const Modes());
}

class Modes extends StatelessWidget {
  const Modes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Choose Your Path',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.white,
      ),
      home: const PathSelectionScreen(),
    );
  }
}

class PathSelectionScreen extends StatefulWidget {
  const PathSelectionScreen({Key? key}) : super(key: key);

  @override
  State<PathSelectionScreen> createState() => _PathSelectionScreenState();
}

class _PathSelectionScreenState extends State<PathSelectionScreen>
    with SingleTickerProviderStateMixin {
  String? _hoveredPath;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFAFAFA),
              Colors.white,
              Color(0xFFF5F5F5),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 393),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Header Section
                    Column(
                      children: [
                        Text(
                          'Choose Your Path',
                          style: AppTextStyles.h1.copyWith(
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Select the journey you want to explore',
                          style: AppTextStyles.small.copyWith(
                            color: AppColors.darkBrown,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Path Cards
                    _PathCard(
                      title: 'Study Path',
                      description: 'Plan and track your academic journey',
                      icon: Icons.school,
                      gradientColors: const [
                        Color(0xFFFF6B6B),
                        Color(0xFFF19C79),
                      ],
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>StudentMainScreen()));
                      },
                    ),
                    const SizedBox(height: 16),
                    _PathCard(
                      title: 'Career Path',
                      description: 'Build and grow your professional future',
                      icon: Icons.work,
                      gradientColors: const [
                        Color.fromARGB(255, 147, 163, 68),
                        Color.fromARGB(255, 192, 231, 164),

                      ],
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>CareerMainLayout()));

                      },
                    ),

                    // Bottom Hint
                    const SizedBox(height: 32),
                    Text(
                      'You can switch paths anytime in settings',
                      style: AppTextStyles.tiny.copyWith(
                        color: AppColors.darkBrown.withOpacity(0.6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// PATH CARD WIDGET
// ============================================================================

class _PathCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const _PathCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.gradientColors,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_PathCard> createState() => _PathCardState();
}

class _PathCardState extends State<_PathCard>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () {
        _controller.forward().then((_) => _controller.reverse());
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.gradientColors
                  .map((color) => color.withOpacity(0.9))
                  .toList(),
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: widget.gradientColors[0].withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.gradientColors[0].withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background Pattern
              Positioned.fill(
                child: Opacity(
                  opacity: 0.1,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.white.withOpacity(0.3),
                                AppColors.white.withOpacity(0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.white.withOpacity(0.3),
                                AppColors.white.withOpacity(0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

// Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Icon Container
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _rotationAnimation.value,
                          child: Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Icon(
                                widget.icon,
                                size: 32,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 16),

                    // Text Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: AppTextStyles.button.copyWith(
                              color: AppColors.white,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.description,
                            style: AppTextStyles.small.copyWith(
                              color: AppColors.white.withOpacity(0.9),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Arrow Icon
                    AnimatedOpacity(
                      opacity: _isPressed ? 1.0 : 0.6,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        Icons.arrow_forward,
                        color: AppColors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}