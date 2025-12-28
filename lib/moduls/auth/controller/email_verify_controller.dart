import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helpers/handle_fold.dart';
import '../../../core/helpers/validation.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../interface/auth_interface.dart';
import '../model/verify_email_register_request_model.dart';

class EmailVerifyController extends ChangeNotifier {
  final ProcessStatusNotifier processStatusNotifier = ProcessStatusNotifier();
  final SnackbarNotifier snackbarNotifier;

  String _email = '';
  String _otp = '';

  String get email => _email;
  String get otp => _otp;

  EmailVerifyController(this.snackbarNotifier);

  bool canVerify() {
    return _email.isNotEmpty && isEmail(_email) && _otp.isNotEmpty && _otp.length >= 6;
  }

  void updateButtonState() {
    if (canVerify()) {
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

  set otp(String value) {
    if (value != _otp) {
      _otp = value;
      updateButtonState();
      notifyListeners();
    }
  }

  Future<void> verifyEmail({
    required VoidCallback onSuccess,
  }) async {
    if (!canVerify()) {
      snackbarNotifier.notifyError(message: 'Please enter email and valid OTP');
      return;
    }

    processStatusNotifier.setLoading();

    await Future.delayed(const Duration(milliseconds: 500));

    await Get.find<AuthInterface>()
        .verifyRegisterEmail(
          param: VerifyEmailRegisterRequestModel(email: email, otp: otp),
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
