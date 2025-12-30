import 'package:flutter/material.dart';

import '../../../core/constants/app_routes.dart';

class TeenDriverPostsScreen extends StatelessWidget {
  const TeenDriverPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const primaryColor = Color(0xFF3F76F6);
    final posts = List.generate(
      6,
      (index) => const _TeenPost(
        title: 'Snowy Driving Experience',
        author: 'Mike_Graham',
        description: 'First Snowy Ride Experience',
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Teen driver posts',
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
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06,
                  vertical: size.height * 0.02,
                ),
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return _PostCard(
                    post: post,
                    size: size,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Opened ${post.title}')),
                      );
                    },
                  );
                },
                separatorBuilder: (_, __) =>
                    SizedBox(height: size.height * 0.018),
                itemCount: posts.length,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.06,
                vertical: size.height * 0.02,
              ),
              child: SizedBox(
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
            ),
          ],
        ),
      ),
    );
  }
}

class _TeenPost {
  final String title;
  final String author;
  final String description;

  const _TeenPost({
    required this.title,
    required this.author,
    required this.description,
  });
}

class _PostCard extends StatelessWidget {
  final _TeenPost post;
  final Size size;
  final VoidCallback onTap;

  const _PostCard({
    required this.post,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: TextStyle(
                  fontSize: (size.width * 0.048).clamp(16.0, 20.0),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF111111),
                ),
              ),
              SizedBox(height: size.height * 0.012),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  'assets/images/Frame 2147228840.png',
                  width: double.infinity,
                  height: size.height * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: size.height * 0.012),
              Text(
                post.author,
                style: TextStyle(
                  fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF111111),
                ),
              ),
              SizedBox(height: size.height * 0.006),
              Text(
                post.description,
                style: TextStyle(
                  fontSize: (size.width * 0.042).clamp(13.0, 17.0),
                  color: const Color(0xFF555555),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              const Divider(height: 1, color: Color(0xFFE0E0E0)),
            ],
          ),
        ),
      ),
    );
  }
}
