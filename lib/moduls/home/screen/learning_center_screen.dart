import 'package:flutter/material.dart';

import '../../../core/constants/app_routes.dart';

class LearningCenterScreen extends StatelessWidget {
  const LearningCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const backgroundColor = Color(0xFFF2F2F2);
    const primaryColor = Color(0xFF3F76F6);
    const accentGreen = Color(0xFF0AA75B);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Learning Center',
          style: TextStyle(
            fontSize: (size.width * 0.055).clamp(18.0, 24.0),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF111111),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF111111)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.06,
            vertical: size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Driver Education',
                style: TextStyle(
                  fontSize: (size.width * 0.048).clamp(16.0, 22.0),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF111111),
                ),
              ),
              SizedBox(height: size.height * 0.008),
              Text(
                'Master the road with confidence',
                style: TextStyle(
                  fontSize: (size.width * 0.04).clamp(13.0, 17.0),
                  color: const Color(0xFF555555),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Learning Progress',
                      style: TextStyle(
                        fontSize: (size.width * 0.05).clamp(16.0, 20.0),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF222222),
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: LinearProgressIndicator(
                              value: 0.4,
                              minHeight: 8,
                              backgroundColor: const Color(0xFFE0E0E0),
                              valueColor:
                                  const AlwaysStoppedAnimation(primaryColor),
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.03),
                        Text(
                          '40%',
                          style: TextStyle(
                            fontSize: (size.width * 0.04).clamp(12.0, 16.0),
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF444444),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.015),
                    _ProgressLine(
                      label: 'Lesson completed: 13/40',
                      size: size,
                    ),
                    _ProgressLine(
                      label: 'Quiz: 85%',
                      size: size,
                    ),
                    _ProgressLine(
                      label: 'Practice Hours: 28/470',
                      size: size,
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Beginner Basics',
                      style: TextStyle(
                        fontSize: (size.width * 0.05).clamp(16.0, 20.0),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF222222),
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    _LessonItemCard(
                      title: '1. Vehicle Controls',
                      titleColor: accentGreen,
                      lines: const ['Completed: 15mins', 'Score: 85%'],
                      size: size,
                    ),
                    SizedBox(height: size.height * 0.012),
                    _LessonItemCard(
                      title: '2. Road Signs',
                      titleColor: accentGreen,
                      lines: const ['Completed: 25mins', 'Score: 45%'],
                      size: size,
                    ),
                    SizedBox(height: size.height * 0.012),
                    _LessonItemCard(
                      title: '3. Road Rules',
                      titleColor: accentGreen,
                      lines: const ['Completed: 30mins', 'Score: 95%'],
                      size: size,
                    ),
                    SizedBox(height: size.height * 0.012),
                    _LessonItemCard(
                      title: '4. Road Rules',
                      titlePrefix: const Icon(
                        Icons.play_arrow,
                        size: 18,
                        color: Color(0xFF111111),
                      ),
                      lines: const ['In progress: 12 mins', '76% Complete'],
                      size: size,
                      trailing: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () =>
                              Navigator.pushNamed(
                                context,
                                AppRoutes.learningVideo,
                              ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: primaryColor,
                            side: const BorderSide(color: primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Continue'),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    const Divider(height: 20),
                    _LockedLessonItem(
                      title: '5. Turning Techniques',
                      size: size,
                    ),
                    _LockedLessonItem(
                      title: '6. Highway Techniques',
                      size: size,
                    ),
                    _LockedLessonItem(
                      title: '7. Parking Skills',
                      size: size,
                    ),
                    _LockedLessonItem(
                      title: '8. Night Driving',
                      size: size,
                    ),
                    _LockedLessonItem(
                      title: '9. Defensive Driving',
                      size: size,
                    ),
                    _LockedLessonItem(
                      title: '10. Emergency Braking',
                      size: size,
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              SizedBox(
                width: double.infinity,
                height: (size.height * 0.07).clamp(48.0, 58.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushReplacementNamed(context, AppRoutes.home);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Return to Home',
                    style: TextStyle(
                      fontSize: (size.width * 0.05).clamp(16.0, 20.0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final Widget child;

  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _ProgressLine extends StatelessWidget {
  final String label;
  final Size size;

  const _ProgressLine({required this.label, required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.008),
      child: Text(
        label,
        style: TextStyle(
          fontSize: (size.width * 0.042).clamp(13.0, 17.0),
          color: const Color(0xFF444444),
        ),
      ),
    );
  }
}

class _LessonItemCard extends StatelessWidget {
  final String title;
  final List<String> lines;
  final Size size;
  final Color? titleColor;
  final Widget? titlePrefix;
  final Widget? trailing;

  const _LessonItemCard({
    required this.title,
    required this.lines,
    required this.size,
    this.titleColor,
    this.titlePrefix,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E5E5)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (titlePrefix != null) ...[
                titlePrefix!,
                const SizedBox(width: 4),
              ],
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: (size.width * 0.046).clamp(14.0, 18.0),
                    fontWeight: FontWeight.w600,
                    color: titleColor ?? const Color(0xFF111111),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.008),
          for (final line in lines)
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.004),
              child: Text(
                line,
                style: TextStyle(
                  fontSize: (size.width * 0.041).clamp(12.0, 16.0),
                  color: const Color(0xFF555555),
                ),
              ),
            ),
          if (trailing != null) ...[
            SizedBox(height: size.height * 0.01),
            trailing!,
          ],
        ],
      ),
    );
  }
}

class _LockedLessonItem extends StatelessWidget {
  final String title;
  final Size size;

  const _LockedLessonItem({required this.title, required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.008),
      child: Row(
        children: [
          const Icon(Icons.lock, size: 18, color: Color(0xFFF2A43C)),
          SizedBox(width: size.width * 0.02),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: (size.width * 0.042).clamp(13.0, 17.0),
                color: const Color(0xFF444444),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
