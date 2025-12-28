import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/api_handler/failure.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../interface/auth_interface.dart';
import '../model/login_request_model.dart';

class LoginsScreenController extends ChangeNotifier {
  final ProcessStatusNotifier processStatusNotifier = ProcessStatusNotifier();
  final SnackbarNotifier snackbarNotifier;
  String _emailOrId = '';
  String get emailOrId => _emailOrId;

  bool get canSubmit => _emailOrId.isNotEmpty && _password.isNotEmpty;

  canLogin() {
    if (canSubmit) {
      processStatusNotifier.setEnabled();
    } else {
      processStatusNotifier.setDisabled();
    }
  }
  
  set emailOrId(String value) {
    if (value != _emailOrId) {
      _emailOrId = value.trim();
      canLogin();
      notifyListeners();
    }
  }

  String _password = '';
  LoginsScreenController(this.snackbarNotifier);
  String get password => _password;
  
  set password(String value) {
    if (value != _password) {
      _password = value;
      canLogin();
      notifyListeners();
    }
  }

  Future<bool> login({
    required VoidCallback needVerification,
  }) async {
    processStatusNotifier.setLoading();
    
    try {
      final result = await Get.find<AuthInterface>().login(
        param: LoginRequestModel(emailOrId: emailOrId, password: password),
      );
      
      return await result.fold(
        (failure) {
          if (failure.failure == Failure.forbidden) {
            needVerification();
          } else {
            final errorMessage = failure.uiMessage.isNotEmpty 
                ? failure.uiMessage
                : 'Invalid email or password. Please try again.';
            snackbarNotifier.notifyError(message: errorMessage);
          }
          processStatusNotifier.setError();
          return false;
        },
        (success) async {
          processStatusNotifier.setSuccess();
          return true;
        },
      );
    } on FormatException catch (e) {
      processStatusNotifier.setError();
      snackbarNotifier.notifyError(
        message: 'Invalid response from server. Please try again.',
      );
      return false;
    } catch (e) {
      snackbarNotifier.notifyError(
        message: 'An unexpected error occurred. Please try again.',
      );
       return false;
    }
  }

}
