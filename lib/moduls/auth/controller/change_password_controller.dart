import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helpers/handle_fold.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../interface/auth_interface.dart';
import '../model/change_password_request_model.dart';

class ChangePasswordController extends ChangeNotifier {
  final ProcessStatusNotifier processStatusNotifier = ProcessStatusNotifier();
  final SnackbarNotifier snackbarNotifier;

  String _oldPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';

  String get oldPassword => _oldPassword;
  String get newPassword => _newPassword;
  String get confirmPassword => _confirmPassword;

  ChangePasswordController(this.snackbarNotifier);

  bool canChange() {
    return _oldPassword.isNotEmpty &&
        _newPassword.isNotEmpty &&
        _newPassword.length >= 6 &&
        _confirmPassword.isNotEmpty &&
        _newPassword == _confirmPassword;
  }

  void updateButtonState() {
    if (canChange()) {
      processStatusNotifier.setEnabled();
    } else {
      processStatusNotifier.setDisabled();
    }
  }

  set oldPassword(String value) {
    if (value != _oldPassword) {
      _oldPassword = value;
      updateButtonState();
      notifyListeners();
    }
  }

  set newPassword(String value) {
    if (value != _newPassword) {
      _newPassword = value;
      updateButtonState();
      notifyListeners();
    }
  }

  set confirmPassword(String value) {
    if (value != _confirmPassword) {
      _confirmPassword = value;
      updateButtonState();
      notifyListeners();
    }
  }

  Future<void> changePassword({required VoidCallback onSuccess}) async {
    if (!canChange()) {
      if (_newPassword != _confirmPassword) {
        snackbarNotifier.notifyError(message: 'Passwords do not match');
      } else {
        snackbarNotifier.notifyError(
          message: 'Please fill all fields correctly',
        );
      }
      return;
    }

    processStatusNotifier.setLoading();

    await Get.find<AuthInterface>()
        .changePassword(
          param: ChangePasswordRequestModel(
            oldPassword: _oldPassword,
            newPassword: _newPassword,
          ),
        )
        .then((result) {
      handleFold(
        either: result,
        processStatusNotifier: processStatusNotifier,
        successSnackbarNotifier: snackbarNotifier,
        errorSnackbarNotifier: snackbarNotifier,
        onSuccess: (_) => onSuccess(),
      );
    });
  }

  @override
  void dispose() {
    processStatusNotifier.dispose();
    super.dispose();
  }
}
