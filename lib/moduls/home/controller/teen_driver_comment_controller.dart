import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/notifiers/snackbar_notifier.dart';
import '../../../core/services/app_pigeon/app_pigeon.dart';
import '../interface/teen_driver_experience_interface.dart';
import '../model/teen_driver_comment_request_model.dart';
import '../model/teen_driver_comment_response_model.dart';

class TeenDriverCommentController extends ChangeNotifier {
  final SnackbarNotifier snackbarNotifier;

  TeenDriverCommentController({required this.snackbarNotifier});

  String _text = '';
  bool _isSubmitting = false;
  bool _isLoading = false;
  bool _isLiking = false;
  bool _isLiked = false;
  int _likesCount = 0;
  String _likeUserName = '';
  final List<TeenDriverCommentResponseModel> _comments = [];

  String get text => _text;
  bool get isSubmitting => _isSubmitting;
  bool get isLoading => _isLoading;
  bool get isLiking => _isLiking;
  bool get isLiked => _isLiked;
  int get likesCount => _likesCount;
  String get likeUserName => _likeUserName;
  bool get canSubmit => _text.isNotEmpty && !_isSubmitting;
  List<TeenDriverCommentResponseModel> get comments =>
      List.unmodifiable(_comments);

  set text(String value) {
    if (value != _text) {
      _text = value.trim();
      notifyListeners();
    }
  }

  Future<void> loadComments({required String postId}) async {
    if (postId.trim().isEmpty) {
      snackbarNotifier.notifyError(message: 'Post id is missing.');
      return;
    }

    _isLoading = true;
    notifyListeners();

    final currentUser = await _getCurrentUserInfo();
    final result =
        await Get.find<TeenDriverExperienceInterface>().getTeenDriverPosts();

    result.fold(
      (failure) {
        snackbarNotifier.notifyError(
          message: failure.uiMessage.isNotEmpty
              ? failure.uiMessage
              : 'Failed to load comments',
        );
      },
      (success) {
        final posts = success.data ?? [];
        List<TeenDriverCommentResponseModel> postComments = [];
        for (final post in posts) {
          if (post.id == postId.trim()) {
            postComments = post.comments;
            _likesCount = post.likesCount;
            if (currentUser.id.isNotEmpty &&
                post.likes.contains(currentUser.id)) {
              _isLiked = true;
              _likeUserName =
                  currentUser.name.isNotEmpty ? currentUser.name : 'You';
            } else {
              _isLiked = false;
            }
            break;
          }
        }
        _comments
          ..clear()
          ..addAll(postComments);
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<TeenDriverCommentResponseModel?> submit({required String postId}) async {
    if (_text.isEmpty) {
      snackbarNotifier.notifyError(message: 'Please enter a comment.');
      return null;
    }
    if (_isSubmitting) {
      return null;
    }

    _isSubmitting = true;
    notifyListeners();

    TeenDriverCommentResponseModel? createdComment;
    final result = await Get.find<TeenDriverExperienceInterface>()
        .addTeenDriverPostComment(
      postId: postId,
      param: TeenDriverCommentRequestModel(text: _text),
    );

    result.fold(
      (failure) {
        snackbarNotifier.notifyError(
          message: failure.uiMessage.isNotEmpty
              ? failure.uiMessage
              : 'Failed to add comment',
        );
      },
      (success) {
        createdComment = success.data;
        snackbarNotifier.notifySuccess(message: success.message);
      },
    );

    if (createdComment != null) {
      _comments.add(createdComment!);
    }
    _isSubmitting = false;
    notifyListeners();

    return createdComment;
  }

  Future<void> likePost({required String postId}) async {
    if (_isLiking) {
      return;
    }
    if (_isLiked) {
      return;
    }
    if (postId.trim().isEmpty) {
      snackbarNotifier.notifyError(message: 'Post id is missing.');
      return;
    }

    _isLiking = true;
    notifyListeners();

    final currentUser = await _getCurrentUserInfo();
    final result = await Get.find<TeenDriverExperienceInterface>()
        .likeTeenDriverPost(postId: postId.trim());

    result.fold(
      (failure) {
        snackbarNotifier.notifyError(
          message:
              failure.uiMessage.isNotEmpty ? failure.uiMessage : 'Like failed',
        );
      },
      (success) {
        _likesCount = success.data ?? _likesCount;
        _isLiked = true;
        _likeUserName =
            currentUser.name.isNotEmpty ? currentUser.name : 'You';
      },
    );

    _isLiking = false;
    notifyListeners();
  }

  Future<_UserSnapshot> _getCurrentUserInfo() async {
    try {
      final appPigeon = Get.find<AppPigeon>();
      final status = await appPigeon.currentAuth();
      if (status is Authenticated) {
        final data = status.auth.data;
        final userMap =
            data['user'] is Map ? Map<String, dynamic>.from(data['user']) : null;
        String readString(dynamic value) => value?.toString() ?? '';
        final id = readString(
          userMap?['_id'] ??
              userMap?['id'] ??
              userMap?['userId'] ??
              data['_id'] ??
              data['id'] ??
              data['userId'],
        );
        final name = readString(
          userMap?['name'] ?? data['name'] ?? data['fullName'],
        );
        return _UserSnapshot(id: id, name: name);
            }
    } catch (_) {}
    return const _UserSnapshot(id: '', name: '');
  }
}

class _UserSnapshot {
  final String id;
  final String name;

  const _UserSnapshot({required this.id, required this.name});
}
