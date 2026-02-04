import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/notifiers/snackbar_notifier.dart';
import '../interface/teen_driver_experience_interface.dart';
import '../model/teen_driver_experience_response_model.dart';

class TeenDriverPostsController extends ChangeNotifier {
  final SnackbarNotifier snackbarNotifier;

  TeenDriverPostsController({required this.snackbarNotifier}) {
    if (_cachedHasLoaded) {
      _posts.addAll(_cachedPosts);
      _hasLoaded = true;
    }
  }

  static final List<TeenDriverExperienceResponseModel> _cachedPosts = [];
  static bool _cachedHasLoaded = false;

  bool _isLoading = false;
  bool _hasLoaded = false;
  final List<TeenDriverExperienceResponseModel> _posts = [];

  bool get isLoading => _isLoading;
  bool get hasLoaded => _hasLoaded;
  List<TeenDriverExperienceResponseModel> get posts =>
      List.unmodifiable(_posts);

  Future<void> loadPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await Get.find<TeenDriverExperienceInterface>()
          .getTeenDriverPosts();

      result.fold(
        (failure) {
          snackbarNotifier.notifyError(
            message: failure.uiMessage.isNotEmpty
                ? failure.uiMessage
                : 'Failed to load teen posts',
          );
        },
        (success) {
          final data = success.data ?? <TeenDriverExperienceResponseModel>[];
          _posts
            ..clear()
            ..addAll(data);
          _cachedPosts
            ..clear()
            ..addAll(data);
          _cachedHasLoaded = true;
        },
      );
    } finally {
      _isLoading = false;
      _hasLoaded = true;
      _cachedHasLoaded = true;
      notifyListeners();
    }
  }
}
