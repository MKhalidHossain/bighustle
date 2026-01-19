import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helpers/handle_fold.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../interface/teen_driver_experience_interface.dart';
import '../model/teen_driver_experience_request_model.dart';

class TeenDriverExperienceController extends ChangeNotifier {
  final ProcessStatusNotifier processStatusNotifier = ProcessStatusNotifier();
  final SnackbarNotifier snackbarNotifier;

  TeenDriverExperienceController(this.snackbarNotifier);

  String _title = '';
  String _description = '';
  String _mediaPath = '';

  String get title => _title;
  String get description => _description;
  String get mediaPath => _mediaPath;

  bool get canSubmit =>
      _title.isNotEmpty && _description.isNotEmpty && _mediaPath.isNotEmpty;

  void _updateButtonState() {
    if (canSubmit) {
      processStatusNotifier.setEnabled();
    } else {
      processStatusNotifier.setDisabled();
    }
  }

  set title(String value) {
    if (value != _title) {
      _title = value.trim();
      _updateButtonState();
      notifyListeners();
    }
  }

  set description(String value) {
    if (value != _description) {
      _description = value.trim();
      _updateButtonState();
      notifyListeners();
    }
  }

  set mediaPath(String value) {
    if (value != _mediaPath) {
      _mediaPath = value.trim();
      _updateButtonState();
      notifyListeners();
    }
  }

  Future<bool> submit() async {
    if (!canSubmit) {
      snackbarNotifier.notifyError(message: 'Please fill all fields.');
      return false;
    }

    processStatusNotifier.setLoading();
    final result =
        await Get.find<TeenDriverExperienceInterface>().createTeenDriverExperience(
      param: TeenDriverExperienceRequestModel(
        title: _title,
        description: _description,
        mediaPath: _mediaPath,
      ),
    );

    bool success = false;
    handleFold(
      either: result,
      processStatusNotifier: processStatusNotifier,
      successSnackbarNotifier: snackbarNotifier,
      errorSnackbarNotifier: snackbarNotifier,
      onSuccess: (_) => success = true,
    );
    return success;
  }

  @override
  void dispose() {
    processStatusNotifier.dispose();
    super.dispose();
  }
}
