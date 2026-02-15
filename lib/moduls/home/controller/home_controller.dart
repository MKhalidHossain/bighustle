import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/notifiers/snackbar_notifier.dart';
import '../interface/home_interface.dart';
import '../model/home_response_model.dart';

class HomeController extends ChangeNotifier {
  final SnackbarNotifier snackbarNotifier;

  HomeController({required this.snackbarNotifier});

  bool _isLoading = false;
  HomeResponseModel _homeData = HomeResponseModel.empty();
  bool _isDisposed = false;
  bool _hasLoaded = false;

  bool get isLoading => _isLoading;
  HomeResponseModel get homeData => _homeData;
  bool get hasLoaded => _hasLoaded;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void _safeNotify() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  Future<void> loadHomeData() async {
    _isLoading = true;
    _safeNotify();

    try {
      final result = await Get.find<HomeInterface>().getHomeData();
      if (_isDisposed) return;

      result.fold(
        (failure) {
          snackbarNotifier.notifyError(
            message: failure.uiMessage.isNotEmpty
                ? failure.uiMessage
                : 'Failed to load home data',
          );
        },
        (success) {
          _homeData = success.data ?? HomeResponseModel.empty();
        },
      );
    } finally {
      _isLoading = false;
      _hasLoaded = true;
      _safeNotify();
    }
  }
}
