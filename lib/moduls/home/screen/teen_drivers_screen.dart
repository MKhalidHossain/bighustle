import 'package:flutter/material.dart';

import '../../../core/constants/app_routes.dart';

class TeenDriversScreen extends StatelessWidget {
  const TeenDriversScreen({super.key});

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const primaryColor = Color(0xFF3F76F6);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Teen Drivers',
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
                'Good Morning, John! 👋',
                style: TextStyle(
                  fontSize: (size.width * 0.02).clamp(18.0, 24.0),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF222222),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              _CardContainer(
                size: size,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Learning Progress',
                      style: TextStyle(
                        fontSize: (size.width * 0.05).clamp(16.0, 22.0),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF222222),
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: 0.4,
                              minHeight: 8,
                              backgroundColor: const Color(0xFFE0E0E0),
                              valueColor: const AlwaysStoppedAnimation(
                                primaryColor,
                              ),
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
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Lesson completed: 13/40',
                      style: TextStyle(
                        fontSize: (size.width * 0.043).clamp(13.0, 17.0),
                        color: const Color(0xFF444444),
                      ),
                    ),
                    SizedBox(height: size.height * 0.012),
                    Text(
                      'Quiz: 85%',
                      style: TextStyle(
                        fontSize: (size.width * 0.043).clamp(13.0, 17.0),
                        color: const Color(0xFF444444),
                      ),
                    ),
                    SizedBox(height: size.height * 0.012),
                    Text(
                      'Practice Hours: 28/470',
                      style: TextStyle(
                        fontSize: (size.width * 0.043).clamp(13.0, 17.0),
                        color: const Color(0xFF444444),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    SizedBox(
                      width: double.infinity,
                      height: (size.height * 0.065).clamp(44.0, 54.0),
                      child: ElevatedButton(
                        onPressed: () =>
                            Navigator.pushNamed(
                              context,
                              AppRoutes.learningCenter,
                            ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          'Continue Learning',
                          style: TextStyle(
                            fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              _CardContainer(
                size: size,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Stats',
                      style: TextStyle(
                        fontSize: (size.width * 0.05).clamp(16.0, 22.0),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF222222),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      children: [
                        _StatTile(size: size, label: '13 Lessons'),
                        SizedBox(width: size.width * 0.03),
                        _StatTile(size: size, label: '28 Hours'),
                        SizedBox(width: size.width * 0.03),
                        _StatTile(size: size, label: '85% Score'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              _CardContainer(
                size: size,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What's Next",
                      style: TextStyle(
                        fontSize: (size.width * 0.05).clamp(16.0, 22.0),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF222222),
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    Text(
                      'Night Driving Lessons',
                      style: TextStyle(
                        fontSize: (size.width * 0.047).clamp(15.0, 20.0),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF222222),
                      ),
                    ),
                    SizedBox(height: size.height * 0.008),
                    Text(
                      'Duration: 15mins',
                      style: TextStyle(
                        fontSize: (size.width * 0.043).clamp(13.0, 17.0),
                        color: const Color(0xFF555555),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    SizedBox(
                      width: double.infinity,
                      height: (size.height * 0.06).clamp(42.0, 52.0),
                      child: ElevatedButton.icon(
                        onPressed: () => _showMessage(context, 'Start lesson'),
                        icon: const Icon(Icons.arrow_forward),
                        label: Text(
                          'Start',
                          style: TextStyle(
                            fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent posts',
                    style: TextStyle(
                      fontSize: (size.width * 0.04).clamp(16.0, 22.0),
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF222222),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoutes.teenDriverPosts,
                    ),
                    child: Text(
                      'See more',
                      style: TextStyle(
                        fontSize: (size.width * 0.042).clamp(12.0, 16.0),
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              _CardContainer(
                size: size,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        'assets/images/Frame 2147228840.png',
                        width: double.infinity,
                        height: size.height * 0.2,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    Text(
                      'Mike_Graham',
                      style: TextStyle(
                        fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF222222),
                      ),
                    ),
                    SizedBox(height: size.height * 0.008),
                    Text(
                      'First Snowy Ride Experience',
                      style: TextStyle(
                        fontSize: (size.width * 0.042).clamp(13.0, 17.0),
                        color: const Color(0xFF555555),
                      ),
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
              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardContainer extends StatelessWidget {
  final Size size;
  final Widget child;

  const _CardContainer({required this.size, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
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

class _StatTile extends StatelessWidget {
  final Size size;
  final String label;

  const _StatTile({required this.size, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
        decoration: BoxDecoration(
          color: const Color(0xFFE9EEFF),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: (size.width * 0.04).clamp(12.0, 16.0),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF444444),
          ),
        ),
      ),
    );
  }
}
