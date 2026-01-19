import 'package:dartz/dartz.dart';

import '../../../core/api_handler/failure.dart';
import '../../../core/api_handler/success.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/services/app_pigeon/app_pigeon.dart';
import '../interface/notification_interface.dart';
import '../model/notification_model.dart';

final class NotificationInterfaceImpl extends NotificationInterface {
  final AppPigeon appPigeon;

  NotificationInterfaceImpl({required this.appPigeon});

  @override
  Future<Either<DataCRUDFailure, Success<List<NotificationModel>>>> getNotifications({
    required String userId,
  }) async {
    return asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.get(
          ApiEndpoints.getUserNotifications(userId),
        );
        final responseBody = response.data is Map
            ? Map<String, dynamic>.from(response.data)
            : <String, dynamic>{};
        final responseData = responseBody["data"];

        if (responseData == null) {
          return Success(
            message: responseBody['message']?.toString() ?? 'No notifications found',
            data: <NotificationModel>[],
          );
        }

        List<NotificationModel> notifications = [];
        if (responseData is List) {
          notifications = responseData
              .map((item) => NotificationModel.fromJson(
                  Map<String, dynamic>.from(item)))
              .toList();
        }

        return Success(
          message: responseBody['message']?.toString() ?? 'Notifications fetched successfully',
          data: notifications,
        );
      },
    );
  }

  @override
  Future<Either<DataCRUDFailure, Success<String>>> markAllAsRead({
    required String userId,
  }) async {
    return asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.patch(
          ApiEndpoints.markAllNotificationsAsRead(userId),
        );
        final responseBody = response.data is Map
            ? Map<String, dynamic>.from(response.data)
            : <String, dynamic>{};
        final message =
            responseBody['message']?.toString() ?? 'All notifications marked as read';

        return Success(
          message: message,
          data: message,
        );
      },
    );
  }
}
