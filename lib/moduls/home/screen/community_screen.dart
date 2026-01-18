import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/notifiers/snackbar_notifier.dart';
import '../../../core/services/app_pigeon/app_pigeon.dart';
import '../controller/teen_driver_comment_controller.dart';
import '../implement/teen_driver_experience_interface_impl.dart';
import '../interface/teen_driver_experience_interface.dart';
import '../model/teen_driver_comment_response_model.dart';

class CommunityScreen extends StatefulWidget {
  final String postId;

  const CommunityScreen({super.key, this.postId = ''});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final TeenDriverCommentController _controller;
  late final SnackbarNotifier _snackbarNotifier;
  bool _initialized = false;

  void _onControllerUpdate() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    if (_initialized) {
      _controller.removeListener(_onControllerUpdate);
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      if (!Get.isRegistered<TeenDriverExperienceInterface>()) {
        Get.put<TeenDriverExperienceInterface>(
          TeenDriverExperienceInterfaceImpl(appPigeon: Get.find<AppPigeon>()),
        );
      }
      _snackbarNotifier = SnackbarNotifier(context: context);
      _controller =
          TeenDriverCommentController(snackbarNotifier: _snackbarNotifier);
      _controller.addListener(_onControllerUpdate);
      if (widget.postId.trim().isNotEmpty) {
        _controller.loadComments(postId: widget.postId.trim());
      }
    }
  }

  String _commentName(TeenDriverCommentResponseModel comment) {
    if (comment.userName.isNotEmpty) {
      return comment.userName;
    }
    if (comment.userId.isEmpty) {
      return 'User';
    }
    final id = comment.userId;
    final shortId = id.length > 6 ? id.substring(0, 6) : id;
    return 'User $shortId';
  }

  Future<void> _addComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) {
      return;
    }
    if (widget.postId.trim().isEmpty) {
      _snackbarNotifier.notifyError(message: 'Post id is missing.');
      return;
    }

    _controller.text = text;
    final createdComment =
        await _controller.submit(postId: widget.postId.trim());
    if (!mounted) {
      return;
    }
    if (createdComment == null) {
      return;
    }
    _commentController.clear();
    _controller.text = '';
    await _controller.loadComments(postId: widget.postId.trim());

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
    final isSubmitting = _initialized ? _controller.isSubmitting : false;
    final hasPostId = widget.postId.trim().isNotEmpty;
    final canSubmit =
        _initialized ? _controller.canSubmit && hasPostId : false;
    final isLoading = _initialized ? _controller.isLoading : false;
    final comments = _initialized ? _controller.comments : [];

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
              child: isLoading && comments.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.06,
                        vertical: size.height * 0.01,
                      ),
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return _CommunityCommentTile(
                          comment: _CommunityComment(
                            name: _commentName(comment),
                            message: comment.text,
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(
                        height: size.height * 0.02,
                      ),
                      itemCount: comments.length,
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
                            onChanged: (value) => _controller.text = value,
                            onSubmitted: (_) => _addComment(),
                            decoration: const InputDecoration(
                              hintText: 'Add Comment',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: canSubmit && !isSubmitting
                              ? _addComment
                              : null,
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
