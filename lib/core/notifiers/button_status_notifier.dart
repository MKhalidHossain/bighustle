import 'package:flutter/material.dart';

sealed class ButtonStatus {
  String message;
  ButtonStatus({this.message = ""});
}

class EnabledStatus extends ButtonStatus {
  EnabledStatus({String? message })
      : super(message: message ?? "Enabled");
}

class DisabledStatus extends ButtonStatus {
  DisabledStatus({String? message })
      : super(message: message ?? "Disabled");
}

class LoadingStatus extends ButtonStatus {
  LoadingStatus({String? message })
      : super(message: message ?? "Loading");
}

class ErrorStatus extends ButtonStatus {
  ErrorStatus({String? message })
      : super(message: message ?? "Error");
}

class SuccessStatus extends ButtonStatus {
  SuccessStatus({String? message })
      : super(message: message ?? "Success");
}

class ProcessStatusNotifier extends ChangeNotifier{

  /// By default the button status is set to DisabledStatus.
  /// If you want to set the initial button status to a different status, pass it in the constructor
  ProcessStatusNotifier({ButtonStatus? initialStatus}) {
    _status = initialStatus ?? DisabledStatus();
  }
  ButtonStatus _status = DisabledStatus();
  ButtonStatus get status => _status;

  void setLoading({String? message}) {
    _status = LoadingStatus(message: message);
    notifyListeners();
  }
  setSuccess({String? message}) {
    _status = SuccessStatus(message: message);
    notifyListeners();
  }
  setError({String? message}) {
    _status = ErrorStatus(message: message);
    notifyListeners();
  }
  setEnabled({String? message}) {
    if(_status is EnabledStatus) return;
    _status = EnabledStatus(message: message);
    notifyListeners();
  }
  setDisabled({String? message}) {
    _status = DisabledStatus(message: message);
    notifyListeners();
  }

  void reset(String? message) {
    _status = EnabledStatus(message: message);
    notifyListeners();
  }
}