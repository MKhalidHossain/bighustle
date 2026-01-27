# Notification API Usage with Token Authentication

## Overview
The notification API automatically applies authentication tokens to all requests through the `AuthService` interceptor. You don't need to manually add tokens - it's handled automatically!

## How Token Authentication Works

### Automatic Token Application
1. **AppPigeon** uses Dio for HTTP requests
2. **AuthService** is an interceptor that automatically adds the Bearer token to all requests
3. Token is attached in the `Authorization` header: `Bearer {accessToken}`
4. Token is retrieved from secure storage automatically

### Code Flow:
```
NotificationScreen → NotificationInterface → AppPigeon.get() → AuthService Interceptor → API Request with Token
```

## API Endpoints

### 1. Get All Notifications for a User
**Endpoint:** `GET {{baseUrl}}/notifications/{userId}`

**Usage:**
```dart
final notificationInterface = Get.find<NotificationInterface>();
final result = await notificationInterface.getNotifications(userId: userId);

result.fold(
  (failure) {
    // Handle error
    print('Error: ${failure.uiMessage}');
  },
  (success) {
    // Handle success
    final notifications = success.data ?? [];
    print('Found ${notifications.length} notifications');
  },
);
```

### 2. Get Single Notification by ID
**Endpoint:** `GET {{baseUrl}}/notifications/{notificationId}`

**Usage:**
```dart
final notificationInterface = Get.find<NotificationInterface>();
final result = await notificationInterface.getNotificationById(
  notificationId: '696b228a3931ff2493532a0f'
);

result.fold(
  (failure) {
    print('Error: ${failure.uiMessage}');
  },
  (success) {
    final notification = success.data;
    print('Notification: ${notification.message}');
  },
);
```

### 3. Mark All Notifications as Read
**Endpoint:** `PATCH {{baseUrl}}/notifications/read/{userId}`

**Usage:**
```dart
final notificationInterface = Get.find<NotificationInterface>();
final result = await notificationInterface.markAllAsRead(userId: userId);

result.fold(
  (failure) {
    print('Error: ${failure.uiMessage}');
  },
  (success) {
    print('Success: ${success.message}');
  },
);
```

## Complete Example: Notification Screen

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/notifiers/snackbar_notifier.dart';
import '../../../../core/services/app_pigeon/app_pigeon.dart';
import '../../interface/notification_interface.dart';
import '../../model/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final SnackbarNotifier _snackbarNotifier;
  bool _isLoading = false;
  List<NotificationModel> _notifications = [];
  int _unreadCount = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _snackbarNotifier = SnackbarNotifier(context: context);
    _loadNotifications();
  }

  // Get current user ID from authenticated session
  Future<String?> _getUserId() async {
    try {
      final appPigeon = Get.find<AppPigeon>();
      final authStatus = await appPigeon.currentAuth();
      if (authStatus is Authenticated) {
        final auth = authStatus.auth;
        final userId = auth.data['_id'] ?? 
            auth.data['userId'] ?? 
            auth.data['user']?['_id'] ?? 
            auth.data['user']?['id'];
        if (userId != null) {
          return userId.toString();
        }
      }
    } catch (e) {
      // Handle error
    }
    return null;
  }

  // Load notifications - TOKEN IS AUTOMATICALLY APPLIED HERE
  Future<void> _loadNotifications() async {
    final userId = await _getUserId();
    if (userId == null || userId.isEmpty) {
      _snackbarNotifier.notifyError(
        message: 'Unable to get user information. Please login again.',
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Get NotificationInterface from dependency injection
      final notificationInterface = Get.find<NotificationInterface>();
      
      // Call API - Token is automatically added by AuthService interceptor
      final result = await notificationInterface.getNotifications(userId: userId);

      result.fold(
        (failure) {
          _snackbarNotifier.notifyError(
            message: failure.uiMessage.isNotEmpty
                ? failure.uiMessage
                : 'Failed to load notifications',
          );
        },
        (success) {
          setState(() {
            _notifications = success.data ?? [];
            _unreadCount = _notifications.where((notification) => !notification.isRead).length;
          });
        },
      );
    } catch (e) {
      _snackbarNotifier.notifyError(
        message: 'An error occurred while loading notifications',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadNotifications,
              child: _notifications.isEmpty
                  ? const Center(child: Text('No notifications'))
                  : ListView.builder(
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        final notification = _notifications[index];
                        return ListTile(
                          title: Text(notification.message),
                          subtitle: Text(notification.timeAgo),
                          leading: Icon(
                            notification.isRead 
                                ? Icons.notifications 
                                : Icons.notifications_active,
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}
```

## How Token is Applied (Internal Mechanism)

### AuthService Interceptor
Located in: `lib/core/services/app_pigeon/auth/auth_service.dart`

```dart
@override
Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
  // Get current auth from secure storage
  final auth = await _authStorage.getCurrentAuth();
  final accessToken = auth?._accessToken;
  
  // Automatically add Bearer token to Authorization header
  if (accessToken != null) {
    options.headers['Authorization'] = 'Bearer $accessToken';
  }
  
  handler.next(options);
}
```

### Request Flow:
1. You call: `appPigeon.get(ApiEndpoints.getUserNotifications(userId))`
2. Dio intercepts the request via `AuthService.onRequest()`
3. Token is automatically added: `Authorization: Bearer {token}`
4. Request is sent to API
5. Response is returned

## Token Refresh (Automatic)
If the token expires (401 error), the `AuthService` automatically:
1. Detects 401 error
2. Refreshes the token using refresh token
3. Retries the original request with new token
4. Returns the response

## Important Notes

1. **No Manual Token Management Needed**: The token is automatically applied to all requests
2. **Secure Storage**: Tokens are stored in FlutterSecureStorage
3. **Automatic Refresh**: Expired tokens are automatically refreshed
4. **User ID Required**: You need to get the user ID from the authenticated session first

## Testing the API

### Using the URL directly:
```
GET {{baseUrl}}/notifications/696b228a3931ff2493532a0f
Headers:
  Authorization: Bearer {your_access_token}
```

### In Flutter Code:
```dart
// Token is automatically added, just call:
final result = await notificationInterface.getNotificationById(
  notificationId: '696b228a3931ff2493532a0f'
);
```

## Response Format

### Success Response:
```json
{
  "success": true,
  "message": "Notifications fetched successfully",
  "data": [
    {
      "_id": "696b228a3931ff2493532a0f",
      "user": "userId123",
      "title": "Notification Title",
      "message": "Notification message",
      "type": "license",
      "isRead": false,
      "createdAt": "2024-01-01T00:00:00.000Z",
      "updatedAt": "2024-01-01T00:00:00.000Z"
    }
  ]
}
```

### Error Response (401 - Unauthorized):
```json
{
  "success": false,
  "message": "Invalid or expired token"
}
```
The AuthService will automatically refresh the token and retry the request.
