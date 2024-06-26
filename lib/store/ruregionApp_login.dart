import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/model/region_login_model.dart';



class RuregionAppLoginStorage {
  static const String key = 'regionApplogin';

  static Future<void> saveProfile(Loginregion profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final regionApplogin = profile.toJson();
    await prefs.setString(key, jsonEncode(regionApplogin));
  }

  static Future<Loginregion> getProfile() async {
    Loginregion profile = Loginregion();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString(key);
    if (profileString != null) {
      final regionlogin = jsonDecode(profileString);
      return Loginregion.fromJson(regionlogin);
    }
    return profile;
  }

  static Future<void> removeProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

}
