import 'teen_driver_comment_response_model.dart';

class TeenDriverExperienceResponseModel {
  final String id;
  final String authorId;
  final String authorName;
  final String title;
  final String description;
  final String? mediaUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int version;
  final int commentsCount;
  final int likesCount;
  final List<TeenDriverCommentResponseModel> comments;

  TeenDriverExperienceResponseModel({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.title,
    required this.description,
    this.mediaUrl,
    this.createdAt,
    this.updatedAt,
    required this.version,
    required this.commentsCount,
    required this.likesCount,
    required this.comments,
  });

  factory TeenDriverExperienceResponseModel.fromJson(
      Map<String, dynamic> json) {
    String readString(dynamic value) => value?.toString() ?? '';

    String authorId = '';
    String authorName = '';
    final authorData = json['authorId'];
    if (authorData is Map) {
      authorId = readString(authorData['_id']);
      authorName = readString(authorData['name']);
    } else {
      authorId = readString(authorData);
    }

    String? mediaUrl;
    final mediaData = json['mediaUrl'];
    if (mediaData is Map) {
      final url = readString(mediaData['url']);
      mediaUrl = url.isEmpty ? null : url;
    } else {
      final url = readString(mediaData);
      mediaUrl = url.isEmpty ? null : url;
    }

    final commentsData = json['comments'] is List
        ? List<dynamic>.from(json['comments'])
        : <dynamic>[];
    final likes =
        json['likes'] is List ? List<dynamic>.from(json['likes']) : <dynamic>[];
    final comments = commentsData
        .map((item) => TeenDriverCommentResponseModel.fromJson(
            Map<String, dynamic>.from(item)))
        .toList();

    return TeenDriverExperienceResponseModel(
      id: json['_id']?.toString() ?? '',
      authorId: authorId,
      authorName: authorName,
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      mediaUrl: mediaUrl,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
      version: json['__v'] is num ? (json['__v'] as num).toInt() : 0,
      commentsCount: comments.length,
      likesCount: likes.length,
      comments: comments,
    );
  }
}
