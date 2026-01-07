import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/model/ruregis_model.dart';

class ProfileAppStorage {
  static const String key = 'profileApp';

  static Future<void> saveProfileApp(Ruregis profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final profileJson = profile.toJson();
    await prefs.setString(key, jsonEncode(profileJson));
  }

  static Future<Ruregis> getProfileApp() async {
    Ruregis profile = Ruregis();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString(key);
    if (profileString != null) {
      final profileJson = jsonDecode(profileString);
      return Ruregis.fromJson(profileJson);
    }

    return profile;
  }

  static Future<void> removeProfileApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
