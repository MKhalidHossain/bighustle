class ForgetPasswordRequestModel {
  final String contact;

  ForgetPasswordRequestModel({required this.contact});

  Map<String, dynamic> toJson() {
    return {
      'contact': contact,
    };
  }

  // Convert a Map to a ForgetPasswordRequestModel object
  factory ForgetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordRequestModel(
      contact: json['contact'],
    );
  }
}
