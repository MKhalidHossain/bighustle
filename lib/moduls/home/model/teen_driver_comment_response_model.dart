class TeenDriverCommentResponseModel {
  final String id;
  final String userId;
  final String userName;
  final String text;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TeenDriverCommentResponseModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.text,
    this.createdAt,
    this.updatedAt,
  });

  factory TeenDriverCommentResponseModel.fromJson(Map<String, dynamic> json) {
    String readString(dynamic value) => value?.toString() ?? '';
    String userId = '';
    String userName = '';
    final userData = json['user'];
    if (userData is Map) {
      userId = readString(userData['_id']);
      userName = readString(userData['name']);
    } else {
      userId = readString(userData);
    }
    return TeenDriverCommentResponseModel(
      id: json['_id']?.toString() ?? '',
      userId: userId,
      userName: userName,
      text: json['text']?.toString() ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
    );
  }
}
