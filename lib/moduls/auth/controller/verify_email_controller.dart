import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/helpers/handle_fold.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../interface/auth_interface.dart';
import '../model/verify_email_request_model.dart';

class VerifyEmailController extends ChangeNotifier {
  final ProcessStatusNotifier processStatusNotifier = ProcessStatusNotifier();
  final SnackbarNotifier snackbarNotifier;
  
  String _contact = '';
  String _otp = '';
  
  String get contact => _contact;
  String get otp => _otp;

  VerifyEmailController(this.snackbarNotifier);

  bool canVerify() {
    return _contact.isNotEmpty && _otp.isNotEmpty && _otp.length >= 6;
  }

  void updateButtonState() {
    if (canVerify()) {
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
      snackbarNotifier.notifyError(message: 'Please enter contact and valid OTP');
      return;
    }

    processStatusNotifier.setLoading();
    
    await Future.delayed(const Duration(milliseconds: 500));
    
    await Get.find<AuthInterface>()
        .verifyEmail(
          param: VerifyEmailRequestModel(contact: contact, otp: otp),
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
