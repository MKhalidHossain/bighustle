class RegisterResponseModel {
  final String? message;
  final Data? data;

  const RegisterResponseModel({
    this.message,
    this.data,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      message: json['message'] as String?,
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (message != null) map['message'] = message;
    if (data != null) map['data'] = data!.toJson();
    return map;
  }
}

class Data {
  final String? accessToken;
  final String? refreshToken;
  final AppUser? user;

  const Data({
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      user: json['user'] != null ? AppUser.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (accessToken != null) map['accessToken'] = accessToken;
    if (refreshToken != null) map['refreshToken'] = refreshToken;
    if (user != null) map['user'] = user!.toJson();
    return map;
  }
}

class AppUser {
  final String? id;
  final String? email;
  final Profile? profile;

  const AppUser({
    this.id,
    this.email,
    this.profile,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] as String?,
      email: json['email'] as String?,
      profile: json['profile'] != null ? Profile.fromJson(json['profile']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    if (email != null) map['email'] = email;
    if (profile != null) map['profile'] = profile!.toJson();
    return map;
  }
}

class Profile {
  final String? name;
  final String? profession;
  final String? skillLevel;
  final String? desiredLevel;
  final List<String>? mainSkills;
  final List<String>? goals;
  final List<String>? growthAreas;

  const Profile({
    this.name,
    this.profession,
    this.skillLevel,
    this.desiredLevel,
    this.mainSkills,
    this.goals,
    this.growthAreas,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] as String?,
      profession: json['profession'] as String?,
      skillLevel: json['skillLevel'] as String?,
      desiredLevel: json['desiredLevel'] as String?,
      mainSkills: _toStringList(json['mainSkills']),
      goals: _toStringList(json['goals']),
      growthAreas: _toStringList(json['growthAreas']),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (name != null) map['name'] = name;
    if (profession != null) map['profession'] = profession;
    if (skillLevel != null) map['skillLevel'] = skillLevel;
    if (desiredLevel != null) map['desiredLevel'] = desiredLevel;
    if (mainSkills != null) map['mainSkills'] = mainSkills;
    if (goals != null) map['goals'] = goals;
    if (growthAreas != null) map['growthAreas'] = growthAreas;
    return map;
  }

  static List<String>? _toStringList(dynamic value) {
    if (value == null) return null;
    if (value is List) {
      return value.where((e) => e != null).map((e) => e.toString()).toList(growable: false);
    }
    if (value is String) return [value];
    return null;
  }
}
