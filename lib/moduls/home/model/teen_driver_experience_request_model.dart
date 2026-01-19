class TeenDriverExperienceRequestModel {
  final String title;
  final String description;
  final String mediaPath;

  const TeenDriverExperienceRequestModel({
    required this.title,
    required this.description,
    required this.mediaPath,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'media': mediaPath,
      };

  factory TeenDriverExperienceRequestModel.fromJson(
      Map<String, dynamic> json) {
    return TeenDriverExperienceRequestModel(
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      mediaPath: json['media']?.toString() ?? '',
    );
  }

  TeenDriverExperienceRequestModel copyWith({
    String? title,
    String? description,
    String? mediaPath,
  }) {
    return TeenDriverExperienceRequestModel(
      title: title ?? this.title,
      description: description ?? this.description,
      mediaPath: mediaPath ?? this.mediaPath,
    );
  }
}
