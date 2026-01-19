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
  bool _isInitialized = false;
  List<NotificationModel> _notifications = [];
  int _unreadCount = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isInitialized = true;
      _snackbarNotifier = SnackbarNotifier(context: context);
      _loadNotifications();
    }
  }

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
      // Silently fail
    }
    return null;
  }

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
      final notificationInterface = Get.find<NotificationInterface>();
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
            // Calculate only unread notifications count
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

  Future<void> _markAllAsRead() async {
    final userId = await _getUserId();
    if (userId == null || userId.isEmpty) {
      _snackbarNotifier.notifyError(
        message: 'Unable to get user information. Please login again.',
      );
      return;
    }

    try {
      final notificationInterface = Get.find<NotificationInterface>();
      final result = await notificationInterface.markAllAsRead(userId: userId);

      result.fold(
        (failure) {
          _snackbarNotifier.notifyError(
            message: failure.uiMessage.isNotEmpty
                ? failure.uiMessage
                : 'Failed to mark all as read',
          );
        },
        (success) {
          _snackbarNotifier.notifySuccess(
            message: success.message.isNotEmpty
                ? success.message
                : 'All notifications marked as read',
          );
          // Update local state immediately
          setState(() {
            _notifications = _notifications.map((notification) {
              return NotificationModel(
                id: notification.id,
                userId: notification.userId,
                title: notification.title,
                message: notification.message,
                type: notification.type,
                isRead: true, // Mark all as read
                createdAt: notification.createdAt,
                updatedAt: notification.updatedAt,
              );
            }).toList();
            _unreadCount = 0;
          });
          // Optionally reload from server to ensure sync
          _loadNotifications();
        },
      );
    } catch (e) {
      _snackbarNotifier.notifyError(
        message: 'An error occurred while marking notifications as read',
      );
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type.toLowerCase()) {
      case 'license':
        return Icons.credit_card;
      case 'ticket':
        return Icons.receipt;
      case 'alert':
        return Icons.warning;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        actions: [
          if (_unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text(
                'Mark all as read',
                style: TextStyle(
                  color: Color(0xFF1976F3),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadNotifications,
              child: _notifications.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_none,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No notifications',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        // Header with unread count
                        if (_unreadCount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  'Notification',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1976F3),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '$_unreadCount',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        // Notifications list
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: _notifications.length,
                            itemBuilder: (context, index) {
                              final notification = _notifications[index];
                              final isUnread = !notification.isRead;
                              
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isUnread 
                                      ? const Color(0xFFEAF5FF) 
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: const Color(0xFFDDE3EE),
                                      child: Icon(
                                        _getNotificationIcon(notification.type),
                                        size: 20,
                                        color: const Color(0xFF5A6472),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            notification.message,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            notification.timeAgo,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF8E8E8E),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
    );
  }
}
