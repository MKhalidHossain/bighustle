class NotificationModel {
  final String id;
  final String userId;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    // Handle userId field - can be 'user', 'userId', or nested 'user._id'
    String extractUserId() {
      if (json['user'] != null) {
        if (json['user'] is String) {
          return json['user'].toString();
        } else if (json['user'] is Map) {
          final userMap = Map<String, dynamic>.from(json['user']);
          return userMap['_id']?.toString() ?? 
                 userMap['id']?.toString() ?? 
                 userMap['userId']?.toString() ?? '';
        }
      }
      return json['userId']?.toString() ?? '';
    }

    // Handle date parsing with fallback
    DateTime parseDate(String? dateKey) {
      if (json[dateKey] == null) return DateTime.now();
      try {
        return DateTime.parse(json[dateKey].toString());
      } catch (e) {
        return DateTime.now();
      }
    }

    return NotificationModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      userId: extractUserId(),
      title: json['title']?.toString() ?? '',
      message: json['message']?.toString() ?? json['body']?.toString() ?? '',
      type: json['type']?.toString() ?? json['notificationType']?.toString() ?? '',
      isRead: json['isRead'] as bool? ?? 
              (json['read'] as bool?) ?? 
              (json['is_read'] as bool?) ?? 
              false,
      createdAt: parseDate('createdAt'),
      updatedAt: parseDate('updatedAt'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': userId,
      'title': title,
      'message': message,
      'type': type,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
}
