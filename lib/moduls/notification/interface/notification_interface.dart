import 'package:dartz/dartz.dart';

import '../../../core/api_handler/base_repository.dart';
import '../../../core/api_handler/failure.dart';
import '../../../core/api_handler/success.dart';
import '../model/notification_model.dart';

abstract base class NotificationInterface extends BaseRepository {
  Future<Either<DataCRUDFailure, Success<List<NotificationModel>>>> getNotifications({
    required String userId,
  });

  Future<Either<DataCRUDFailure, Success<NotificationModel>>> getNotificationById({
    required String notificationId,
  });

  Future<Either<DataCRUDFailure, Success<String>>> markAllAsRead({
    required String userId,
  });
}
