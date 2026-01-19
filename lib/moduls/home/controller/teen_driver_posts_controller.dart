import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/notifiers/snackbar_notifier.dart';
import '../interface/teen_driver_experience_interface.dart';
import '../model/teen_driver_experience_response_model.dart';

class TeenDriverPostsController extends ChangeNotifier {
  final SnackbarNotifier snackbarNotifier;

  TeenDriverPostsController({required this.snackbarNotifier});

  bool _isLoading = false;
  final List<TeenDriverExperienceResponseModel> _posts = [];

  bool get isLoading => _isLoading;
  List<TeenDriverExperienceResponseModel> get posts =>
      List.unmodifiable(_posts);

  Future<void> loadPosts() async {
    _isLoading = true;
    notifyListeners();

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
      },
    );

    _isLoading = false;
    notifyListeners();
  }
}
