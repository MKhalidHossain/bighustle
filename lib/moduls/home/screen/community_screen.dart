import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<_CommunityComment> _comments = [
    _CommunityComment(name: 'Adams', message: 'Big fan senor'),
    _CommunityComment(name: 'John Doe', message: 'Nice performance'),
    _CommunityComment(name: 'Gary Whisper', message: 'Awesome!!!'),
    _CommunityComment(name: 'Joey', message: 'Outstanding..'),
    _CommunityComment(name: 'Adams', message: 'Big fan senor'),
    _CommunityComment(name: 'John Doe', message: 'Nice performance'),
    _CommunityComment(name: 'Gary Whisper', message: 'Awesome!!!'),
    _CommunityComment(name: 'Joey', message: 'Outstanding..'),
    _CommunityComment(name: 'Adams', message: 'Big fan senor'),
    _CommunityComment(name: 'John Doe', message: 'Nice performance'),
    _CommunityComment(name: 'Gary Whisper', message: 'Awesome!!!'),
  ];
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) {
      return;
    }

    setState(() {
      _comments.add(_CommunityComment(name: 'You', message: text));
    });
    _commentController.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) {
        return;
      }
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  void _showComposerMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Create a new post')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewInsets = MediaQuery.of(context).viewInsets;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.06,
                vertical: size.height * 0.015,
              ),
              child: Row(
                children: [
                  SizedBox(width: size.width * 0.08),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Community',
                        style: TextStyle(
                          fontSize: (size.width * 0.06).clamp(20.0, 26.0),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF222222),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _showComposerMessage,
                    icon: const Icon(Icons.edit_outlined),
                    color: const Color(0xFF222222),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06,
                  vertical: size.height * 0.01,
                ),
                itemBuilder: (context, index) {
                  final comment = _comments[index];
                  return _CommunityCommentTile(comment: comment);
                },
                separatorBuilder: (_, __) => SizedBox(
                  height: size.height * 0.02,
                ),
                itemCount: _comments.length,
              ),
            ),
            AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: EdgeInsets.fromLTRB(
                size.width * 0.06,
                size.height * 0.01,
                size.width * 0.06,
                viewInsets.bottom + size.height * 0.02,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: size.width * 0.09,
                        height: size.width * 0.09,
                        decoration: const BoxDecoration(
                          color: Color(0xFF666666),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      SizedBox(width: size.width * 0.03),
                      Expanded(
                        child: Text(
                          'Rosy, Mark & Maria liked the live-stream',
                          style: TextStyle(
                            fontSize: (size.width * 0.04).clamp(12.0, 16.0),
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF222222),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => _addComment(),
                            decoration: const InputDecoration(
                              hintText: 'Add Comment',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: _addComment,
                          icon: const Icon(Icons.send),
                          color: const Color(0xFF222222),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommunityComment {
  final String name;
  final String message;

  const _CommunityComment({required this.name, required this.message});
}

class _CommunityCommentTile extends StatelessWidget {
  final _CommunityComment comment;

  const _CommunityCommentTile({required this.comment});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: size.width * 0.04,
          backgroundColor: const Color(0xFFE0E0E0),
          child: Icon(
            Icons.person,
            color: const Color(0xFF8A8A8A),
            size: size.width * 0.04,
          ),
        ),
        SizedBox(width: size.width * 0.04),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.name,
                style: TextStyle(
                  fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF9A9A9A),
                ),
              ),
              SizedBox(height: size.height * 0.004),
              Text(
                comment.message,
                style: TextStyle(
                  fontSize: (size.width * 0.048).clamp(14.0, 20.0),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF222222),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
