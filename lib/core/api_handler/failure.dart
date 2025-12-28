enum Failure {dioFailure, socketFailure, authFailure, severFailure, firebaseFailure, unknownFailure, outOfMemoryError, noData, timeout, forbidden}
class DataCRUDFailure {
  final Failure failure;
  /// Message to be shown to the user
  /// Defaults to `fullError`
  final String uiMessage;
  final String fullError;

  DataCRUDFailure({required this.failure, String? uiMessage, required this.fullError}):uiMessage = uiMessage ?? fullError;

  @override
  String toString() {
    return 'DataCRUDFailure(failure: ${failure.name}, message: $fullError)';
  }
}