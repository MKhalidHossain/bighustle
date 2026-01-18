import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/notifiers/snackbar_notifier.dart';
import '../interface/teen_driver_experience_interface.dart';
import '../model/teen_driver_comment_request_model.dart';
import '../model/teen_driver_comment_response_model.dart';

class TeenDriverCommentController extends ChangeNotifier {
  final SnackbarNotifier snackbarNotifier;

  TeenDriverCommentController({required this.snackbarNotifier});

  String _text = '';
  bool _isSubmitting = false;
  bool _isLoading = false;
  final List<TeenDriverCommentResponseModel> _comments = [];

  String get text => _text;
  bool get isSubmitting => _isSubmitting;
  bool get isLoading => _isLoading;
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
}
