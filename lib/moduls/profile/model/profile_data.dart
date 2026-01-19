import 'dart:io';

import 'package:flutter/material.dart';

import 'profile_response_model.dart';

class ProfileData extends ChangeNotifier {
  ProfileData._();

  static final ProfileData instance = ProfileData._();

  String name = 'Jenny Wilson';
  String phone = '+764782642';
  String dateOfBirth = '19th July, 1990';
  String email = 'josh@gmail.com';
  String userId = '12345678';
  String avatarUrl = '';
  String? avatarPath;
  bool ticketAlerts = false;
  bool licenseExpiryAlerts = false;
  bool inactiveAlerts = false;
  bool teenDriverAlerts = false;
  bool communityAlerts = false;
  bool hasLoaded = false;

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

  void updateFromProfile(ProfileResponseModel profile) {
    name = profile.name.isNotEmpty ? profile.name : name;
    phone = profile.phone.isNotEmpty ? profile.phone : phone;
    email = profile.email.isNotEmpty ? profile.email : email;
    userId = profile.id.isNotEmpty ? profile.id : userId;
    avatarUrl = profile.avatarUrl;
    ticketAlerts = profile.ticketAlerts;
    licenseExpiryAlerts = profile.licenseExpiryAlerts;
    inactiveAlerts = profile.inactiveAlerts;
    teenDriverAlerts = profile.teenDriverAlerts;
    communityAlerts = profile.communityAlerts;
    if (profile.dateOfBirth != null) {
      final date = profile.dateOfBirth!;
      dateOfBirth =
          '${date.year.toString().padLeft(4, '0')}-'
          '${date.month.toString().padLeft(2, '0')}-'
          '${date.day.toString().padLeft(2, '0')}';
    }
    hasLoaded = true;
    notifyListeners();
  }

  void updateNotificationSettings({
    required bool ticketAlerts,
    required bool licenseExpiryAlerts,
    required bool inactiveAlerts,
    required bool teenDriverAlerts,
    required bool communityAlerts,
  }) {
    this.ticketAlerts = ticketAlerts;
    this.licenseExpiryAlerts = licenseExpiryAlerts;
    this.inactiveAlerts = inactiveAlerts;
    this.teenDriverAlerts = teenDriverAlerts;
    this.communityAlerts = communityAlerts;
    notifyListeners();
  }

  void updateAvatar(String path) {
    avatarPath = path;
    notifyListeners();
  }

  ImageProvider? get avatarImageProvider {
    if (avatarPath != null && avatarPath!.isNotEmpty) {
      return FileImage(File(avatarPath!));
    }
    if (avatarUrl.isEmpty) {
      return null;
    }
    return NetworkImage(avatarUrl);
  }
}
