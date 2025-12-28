import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/helpers/handle_fold.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../interface/auth_interface.dart';
import '../model/forget_password_request_model.dart';

class ForgetPasswordController extends ChangeNotifier {
  final ProcessStatusNotifier processStatusNotifier = ProcessStatusNotifier();
  final SnackbarNotifier snackbarNotifier;
  
  String _contact = '';
  String get contact => _contact;

  ForgetPasswordController(this.snackbarNotifier);

  bool canSend() {
    return _contact.isNotEmpty;
  }

  void updateButtonState() {
    if (canSend()) {
      processStatusNotifier.setEnabled();
    } else {
      processStatusNotifier.setDisabled();
    }
  }

  set contact(String value) {
    if (value != _contact) {
      _contact = value.trim();
      updateButtonState();
      notifyListeners();
    }
  }

  Future<void> sendForgetPasswordRequest({
    required VoidCallback onSuccess,
  }) async {
    if (!canSend()) {
      snackbarNotifier.notifyError(message: 'Please enter a valid contact');
      return;
    }

    processStatusNotifier.setLoading();
    
    await Future.delayed(const Duration(milliseconds: 500));
    
    await Get.find<AuthInterface>()
        .forgetPassword(
          param: ForgetPasswordRequestModel(contact: contact),
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
