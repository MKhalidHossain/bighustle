import 'package:dartz/dartz.dart';
import '../api_handler/failure.dart';
import '../api_handler/success.dart';
import '../notifiers/button_status_notifier.dart';
import '../notifiers/snackbar_notifier.dart';
import '../services/debug/debug_service.dart';


T? handleFold<T>({
  Debugger? debugger,
  required Either<DataCRUDFailure, Success<T>> either,
  ProcessStatusNotifier? processStatusNotifier,
  SnackbarNotifier? errorSnackbarNotifier,
  SnackbarNotifier? successSnackbarNotifier,
  void Function(T data)? onSuccess,
  void Function(DataCRUDFailure failure)? onError,
}) {
  return either.fold(
    (failure) {
      debugger?.dekhao(failure.toString());
      processStatusNotifier?.setEnabled();
      errorSnackbarNotifier?.notifyError(message: failure.uiMessage);
      if(onError != null) onError(failure);
      return null;
    },
    (result) {
      processStatusNotifier?.setSuccess(
        message: (result as Success).message
      );
      successSnackbarNotifier?.notifySuccess(
        message: (result as Success).message
      );
      if(onSuccess != null && result.data is T) onSuccess(result.data as T);
      debugger?.dekhao("success result is ${(result as Success).message}");
      return result.data;
    },
  );
}
