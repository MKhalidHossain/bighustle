// Example: How to use Notification API with Automatic Token Authentication
// 
// This file demonstrates how to use the notification API.
// The token is automatically applied - you don't need to add it manually!

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/app_pigeon/app_pigeon.dart';
import '../interface/notification_interface.dart';
import '../model/notification_model.dart';

/// Example 1: Get all notifications for current user
/// Token is automatically applied via AuthService interceptor
Future<void> exampleGetAllNotifications() async {
  try {
    // Step 1: Get user ID from authenticated session
    final appPigeon = Get.find<AppPigeon>();
    final authStatus = await appPigeon.currentAuth();
    
    if (authStatus is! Authenticated) {
      debugPrint('User not authenticated');
      return;
    }
    
    final userId = authStatus.auth.data['_id']?.toString() ?? 
                   authStatus.auth.data['userId']?.toString();
    
    if (userId == null) {
      debugPrint('User ID not found');
      return;
    }
    
    // Step 2: Get NotificationInterface from dependency injection
    final notificationInterface = Get.find<NotificationInterface>();
    
    // Step 3: Call API - TOKEN IS AUTOMATICALLY APPLIED HERE!
    // The AuthService interceptor adds: Authorization: Bearer {token}
    final result = await notificationInterface.getNotifications(userId: userId);
    
    // Step 4: Handle result
    result.fold(
      (failure) {
        // Handle error
        debugPrint('❌ Error: ${failure.uiMessage}');
        debugPrint('Failure Type: ${failure.failure.name}');
      },
      (success) {
        // Handle success
        final notifications = success.data ?? [];
        debugPrint('✅ Success! Found ${notifications.length} notifications');
        
        for (var notification in notifications) {
          debugPrint('  - ${notification.message} (${notification.isRead ? "Read" : "Unread"})');
        }
      },
    );
  } catch (e) {
    debugPrint('Exception: $e');
  }
}

// Example 2: Get single notification by ID
/// URL: {{baseUrl}}/notifications/696b228a3931ff2493532a0f
Future<void> exampleGetNotificationById(String notificationId) async {
  try {
    final notificationInterface = Get.find<NotificationInterface>();
    
    // Call API - Token automatically applied
    final result = await notificationInterface.getNotificationById(
      notificationId: notificationId,
    );
    
    result.fold(
      (failure) {
        debugPrint('❌ Error: ${failure.uiMessage}');
      },
      (success) {
        final notification = success.data;
        if (notification != null) {
          debugPrint('✅ Notification Details:');
          debugPrint('  ID: ${notification.id}');
          debugPrint('  Message: ${notification.message}');
          debugPrint('  Type: ${notification.type}');
          debugPrint('  Read: ${notification.isRead}');
          debugPrint('  Time: ${notification.timeAgo}');
        } else {
          debugPrint('❌ Notification data is null');
        }
      },
    );
  } catch (e) {
    debugPrint('Exception: $e');
  }
}

// Example 3: Mark all notifications as read
Future<void> exampleMarkAllAsRead() async {
  try {
    // Get user ID
    final appPigeon = Get.find<AppPigeon>();
    final authStatus = await appPigeon.currentAuth();
    
    if (authStatus is! Authenticated) {
      debugPrint('User not authenticated');
      return;
    }
    
    final userId = authStatus.auth.data['_id']?.toString() ?? 
                   authStatus.auth.data['userId']?.toString();
    
    if (userId == null) {
      debugPrint('User ID not found');
      return;
    }
    
    // Get NotificationInterface
    final notificationInterface = Get.find<NotificationInterface>();
    
    // Mark all as read - Token automatically applied
    final result = await notificationInterface.markAllAsRead(userId: userId);
    
    result.fold(
      (failure) {
        debugPrint('❌ Error: ${failure.uiMessage}');
      },
      (success) {
        debugPrint('✅ ${success.message}');
      },
    );
  } catch (e) {
    debugPrint('Exception: $e');
  }
}

// Example 4: Complete widget example
class NotificationExampleWidget extends StatefulWidget {
  const NotificationExampleWidget({super.key});

  @override
  State<NotificationExampleWidget> createState() => _NotificationExampleWidgetState();
}

class _NotificationExampleWidgetState extends State<NotificationExampleWidget> {
  List<NotificationModel> _notifications = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Get user ID
      final appPigeon = Get.find<AppPigeon>();
      final authStatus = await appPigeon.currentAuth();
      
      if (authStatus is! Authenticated) {
        setState(() {
          _error = 'User not authenticated';
          _isLoading = false;
        });
        return;
      }
      
      final userId = authStatus.auth.data['_id']?.toString() ?? 
                     authStatus.auth.data['userId']?.toString();
      
      if (userId == null) {
        setState(() {
          _error = 'User ID not found';
          _isLoading = false;
        });
        return;
      }
      
      // Get notifications - TOKEN AUTOMATICALLY APPLIED
      final notificationInterface = Get.find<NotificationInterface>();
      final result = await notificationInterface.getNotifications(userId: userId);
      
      result.fold(
        (failure) {
          setState(() {
            _error = failure.uiMessage;
            _isLoading = false;
          });
        },
        (success) {
          setState(() {
            _notifications = success.data ?? [];
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        _error = 'Exception: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification API Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadNotifications,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(_error!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadNotifications,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _notifications.isEmpty
                  ? const Center(
                      child: Text('No notifications found'),
                    )
                  : ListView.builder(
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        final notification = _notifications[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: ListTile(
                            leading: Icon(
                              notification.isRead
                                  ? Icons.notifications
                                  : Icons.notifications_active,
                              color: notification.isRead
                                  ? Colors.grey
                                  : Colors.blue,
                            ),
                            title: Text(notification.message),
                            subtitle: Text(notification.timeAgo),
                            trailing: Text(
                              notification.type,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}

// How Token Authentication Works:
// 
// 1. When you call: appPigeon.get(url)
// 2. AuthService interceptor (onRequest) is triggered
// 3. Token is retrieved from FlutterSecureStorage
// 4. Token is added to headers: Authorization: Bearer {token}
// 5. Request is sent to API
// 
// You don't need to manually add the token - it's automatic!
// 
// If token expires (401 error):
// 1. AuthService detects 401
// 2. Automatically refreshes token using refresh token
// 3. Retries original request with new token
// 4. Returns response
