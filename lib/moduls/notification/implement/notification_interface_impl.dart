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
        
        // Handle different response formats
        dynamic responseData = responseBody["data"] ?? responseBody;
        
        // If responseData is null or empty, return empty list
        if (responseData == null) {
          return Success(
            message: responseBody['message']?.toString() ?? 'No notifications found',
            data: <NotificationModel>[],
          );
        }

        List<NotificationModel> notifications = [];
        
        // Handle list response
        if (responseData is List) {
          notifications = responseData
              .where((item) => item != null)
              .map((item) {
                try {
                  return NotificationModel.fromJson(
                    Map<String, dynamic>.from(item)
                  );
                } catch (e) {
                  // Skip invalid items
                  return null;
                }
              })
              .whereType<NotificationModel>()
              .toList();
        } 
        // Handle single object response (wrap in list)
        else if (responseData is Map) {
          try {
            final notification = NotificationModel.fromJson(
              Map<String, dynamic>.from(responseData)
            );
            notifications = [notification];
          } catch (e) {
            // If parsing fails, return empty list
            notifications = [];
          }
        }

        return Success(
          message: responseBody['message']?.toString() ?? 'Notifications fetched successfully',
          data: notifications,
        );
      },
    );
  }

  @override
  Future<Either<DataCRUDFailure, Success<NotificationModel>>> getNotificationById({
    required String notificationId,
  }) async {
    return asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.get(
          ApiEndpoints.getNotificationById(notificationId),
        );
        final responseBody = response.data is Map
            ? Map<String, dynamic>.from(response.data)
            : <String, dynamic>{};
        final responseData = responseBody["data"] ?? responseBody;

        if (responseData == null) {
          return Success(
            message: responseBody['message']?.toString() ?? 'Notification not found',
            data: NotificationModel(
              id: '',
              userId: '',
              title: '',
              message: '',
              type: '',
              isRead: false,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );
        }

        final notification = NotificationModel.fromJson(
          responseData is Map
              ? Map<String, dynamic>.from(responseData)
              : <String, dynamic>{},
        );

        return Success(
          message: responseBody['message']?.toString() ?? 'Notification fetched successfully',
          data: notification,
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
