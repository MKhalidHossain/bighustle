# Notification API Call Flow with Token Authentication

## API Endpoint
```
GET {{baseUrl}}/notifications/{userId}
Example: GET http://10.10.5.95:5000/api/v1/notifications/696b228a3931ff2493532a0f
```

## How It Works

### 1. **Get User ID from Authenticated Session**
```dart
final appPigeon = Get.find<AppPigeon>();
final authStatus = await appPigeon.currentAuth();
if (authStatus is Authenticated) {
  final userId = authStatus.auth.data['_id']?.toString();
  // userId = "696b228a3931ff2493532a0f"
}
```

### 2. **Call Notification API (Token Automatically Applied)**
```dart
final notificationInterface = Get.find<NotificationInterface>();
final result = await notificationInterface.getNotifications(userId: userId);
```

### 3. **Token Application (Automatic)**
The `AuthService` interceptor automatically:
- Retrieves access token from secure storage
- Adds to request headers: `Authorization: Bearer {accessToken}`
- Sends request to API

**Request Headers (Automatic):**
```
GET /api/v1/notifications/696b228a3931ff2493532a0f
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
Content-Type: application/json
```

### 4. **API Response**
```json
{
    "success": true,
    "message": "Notifications fetched successfully",
    "data": [
        {
            "_id": "696b2db259d59a4bd64922c7",
            "user": "696b228a3931ff2493532a0f",
            "title": "License submitted",
            "message": "Your license has been submitted and is pending approval",
            "type": "license",
            "isRead": false,
            "createdAt": "2026-01-17T06:35:30.620Z",
            "updatedAt": "2026-01-17T06:35:30.620Z",
            "__v": 0
        },
        {
            "_id": "696b2d70614dec8a423768a6",
            "user": "696b228a3931ff2493532a0f",
            "title": "License submitted",
            "message": "Your license has been submitted and is pending approval",
            "type": "license",
            "isRead": false,
            "createdAt": "2026-01-17T06:34:24.974Z",
            "updatedAt": "2026-01-17T06:34:24.974Z",
            "__v": 0
        }
    ]
}
```

### 5. **Display in UI**
The notifications are displayed in the `NotificationScreen` with:
- **Title**: "License submitted" (shown prominently)
- **Message**: "Your license has been submitted and is pending approval"
- **Type**: "license" (shown as badge)
- **Time**: Relative time (e.g., "2 hours ago")
- **Read Status**: Visual indicator (blue background for unread)

## Complete Code Flow

```dart
// 1. Get User ID
Future<String?> _getUserId() async {
  final appPigeon = Get.find<AppPigeon>();
  final authStatus = await appPigeon.currentAuth();
  if (authStatus is Authenticated) {
    return authStatus.auth.data['_id']?.toString();
  }
  return null;
}

// 2. Load Notifications
Future<void> _loadNotifications() async {
  final userId = await _getUserId(); // "696b228a3931ff2493532a0f"
  
  // 3. Call API - Token automatically applied
  final notificationInterface = Get.find<NotificationInterface>();
  final result = await notificationInterface.getNotifications(userId: userId);
  
  // 4. Handle Response
  result.fold(
    (failure) {
      // Handle error
      print('Error: ${failure.uiMessage}');
    },
    (success) {
      // 5. Update UI with notifications
      setState(() {
        _notifications = success.data ?? [];
        _unreadCount = _notifications.where((n) => !n.isRead).length;
      });
    },
  );
}
```

## UI Display Features

### Notification Card Shows:
1. **Unread Indicator**: Blue dot for unread notifications
2. **Icon**: Type-specific icon (license, ticket, alert)
3. **Title**: Bold, prominent text
4. **Message**: Full notification message
5. **Time**: Relative time (e.g., "2 hours ago")
6. **Type Badge**: Colored badge showing notification type
7. **Background**: Blue tint for unread, white for read

### Interactive Features:
- **Tap to Mark as Read**: Tap any unread notification to mark it as read
- **Mark All as Read**: Button in app bar to mark all notifications as read
- **Pull to Refresh**: Pull down to reload notifications

## Debug Information

The app prints debug information to console:
```
📡 Notification API Call:
   URL: http://10.10.5.95:5000/api/v1/notifications/696b228a3931ff2493532a0f
   User ID: 696b228a3931ff2493532a0f
   Method: GET
   Token: Applied automatically via AuthService interceptor
✅ API Success: Notifications fetched successfully
   Notifications count: 5
```

## Key Points

1. **Token is Automatic**: No need to manually add token to requests
2. **User ID Required**: Must get user ID from authenticated session first
3. **Response Parsing**: Automatically parses JSON response to `NotificationModel` objects
4. **UI Updates**: State management updates UI automatically when data is received
5. **Error Handling**: Comprehensive error handling with user-friendly messages

## Testing

To test the API call:
1. Ensure user is logged in (token is available)
2. Navigate to NotificationScreen
3. Check console for debug output
4. Verify notifications are displayed in UI
5. Test tap to mark as read functionality
