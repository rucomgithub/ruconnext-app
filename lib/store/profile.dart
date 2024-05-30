import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/profile.dart';

class ProfileStorage {
  static const String key = 'profile';

  static Future<void> saveProfile(Profile profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final profileJson = profile.toJson();
    await prefs.setString(key, jsonEncode(profileJson));
  }

  static Future<Profile> getProfile() async {
    Profile profile = Profile();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString(key);
    if (profileString != null) {
      final profileJson = jsonDecode(profileString);
      return Profile.fromJson(profileJson);
    }

    return profile;
  }

  static Future<void> removeProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
