import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/helpers/handle_fold.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../interface/auth_interface.dart';
import '../model/reset_password_request_model.dart';

class ResetPasswordController extends ChangeNotifier {
  final ProcessStatusNotifier processStatusNotifier = ProcessStatusNotifier();
  final SnackbarNotifier snackbarNotifier;
  
  String _email = '';
  String _newPassword = '';
  String _confirmPassword = '';
  
  String get email => _email;
  String get newPassword => _newPassword;
  String get confirmPassword => _confirmPassword;

  ResetPasswordController(this.snackbarNotifier);

  bool canReset() {
    return _email.isNotEmpty && 
           _newPassword.isNotEmpty && 
           _newPassword.length >= 6 &&
           _confirmPassword.isNotEmpty &&
           _newPassword == _confirmPassword;
  }

  void updateButtonState() {
    if (canReset()) {
      processStatusNotifier.setEnabled();
    } else {
      processStatusNotifier.setDisabled();
    }
  }

  set email(String value) {
    if (value != _email) {
      _email = value.trim();
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

  Future<void> resetPassword({
    required VoidCallback onSuccess,
  }) async {
    if (!canReset()) {
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
    
    await Future.delayed(const Duration(milliseconds: 500));
    
    await Get.find<AuthInterface>()
        .resetPassword(
          param: ResetPasswordRequestModel(
            email: email, 
            newPassword: newPassword,
            confirmPassword: confirmPassword,
          ),
        )
        .then((result) {
      handleFold(
        either: result,
        processStatusNotifier: processStatusNotifier,
        successSnackbarNotifier: snackbarNotifier,
        errorSnackbarNotifier: snackbarNotifier,
        onSuccess: (_) {
          onSuccess();
        },
      );
    });
  }

  @override
  void dispose() {
    processStatusNotifier.dispose();
    super.dispose();
  }
}
