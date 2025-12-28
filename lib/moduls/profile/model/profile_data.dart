import 'dart:io';

import 'package:flutter/material.dart';

class ProfileData extends ChangeNotifier {
  ProfileData._();

  static final ProfileData instance = ProfileData._();

  String name = 'Jenny Wilson';
  String phone = '+764782642';
  String dateOfBirth = '19th July, 1990';
  String email = 'josh@gmail.com';
  String userId = '12345678';
  String? avatarPath;

  void updateProfile({
    required String name,
    required String phone,
    required String dateOfBirth,
  }) {
    this.name = name;
    this.phone = phone;
    this.dateOfBirth = dateOfBirth;
    notifyListeners();
  }

  void updateAvatar(String path) {
    avatarPath = path;
    notifyListeners();
  }

  ImageProvider? get avatarImageProvider {
    if (avatarPath == null || avatarPath!.isEmpty) {
      return null;
    }
    return FileImage(File(avatarPath!));
  }
}
