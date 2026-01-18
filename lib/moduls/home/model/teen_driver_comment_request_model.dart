class TeenDriverCommentRequestModel {
  final String text;

  const TeenDriverCommentRequestModel({required this.text});

  Map<String, dynamic> toJson() => {
        'text': text,
      };

  factory TeenDriverCommentRequestModel.fromJson(Map<String, dynamic> json) {
    return TeenDriverCommentRequestModel(
      text: json['text']?.toString() ?? '',
    );
  }

  TeenDriverCommentRequestModel copyWith({String? text}) {
    return TeenDriverCommentRequestModel(
      text: text ?? this.text,
    );
  }
}
