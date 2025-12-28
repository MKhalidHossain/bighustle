import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/api_handler/failure.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../../../core/services/app_pigeon/app_pigeon.dart';

import '../interface/auth_interface.dart';
import '../model/login_request_model.dart';
import '../model/logout_request_model.dart';
import '../presentation/screen/login_screen.dart';

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

  final AuthInterface _authInterface = Get.find<AuthInterface>();
  
  // Future<void> logout() async {
  //   try {
  //     // Get the refresh token from secure storage or wherever it's stored
  //     final refreshToken = await _getStoredRefreshToken();
      
  //     if (refreshToken != null) {
  //       await _authInterface.logout(
  //         param: LogoutRequestModel(refreshToken: refreshToken),
  //       );
  //     }
      
  //     // Clear any stored tokens or user data
  //     await _clearUserData();
      
  //     // Navigate to login screen and remove all previous routes
  //     Get.offAll(() => const LoginScreen());
  //   } catch (e) {
  //     // Even if logout fails, we should still navigate to login
  //     Get.offAll(() => const LoginScreen());
  //   }
  // }
  
  // Future<String?> _getStoredRefreshToken() async {
  //   final status = await Get.find<AppPigeon>().currentAuth();
  //   if (status is Authenticated) {
  //     return status.auth.refreshToken;
  //   }
  //   return null;
  // }
  
  Future<void> _clearUserData() async {
    // TODO: Implement this method to clear any stored user data
    // Example: await SecureStorage().clearAll();
  }
  //       either: lr,
  //       processStatusNotifier: processStatusNotifier,
  //       successSnackbarNotifier: snackbarNotifier,
  //       errorSnackbarNotifier: snackbarNotifier,
  //     );
  //   });
  // }

  // Future<void> facebookLogin() async{
  //   processStatusNotifier.setLoading();
  //   await Get.find<AuthInterface>().facebookLogin().then((lr) {
  //     handleFold(
  //       either: lr,
  //       processStatusNotifier: processStatusNotifier,
  //       successSnackbarNotifier: snackbarNotifier,
  //       errorSnackbarNotifier: snackbarNotifier,
  //     );
  //   });
  // }
}
