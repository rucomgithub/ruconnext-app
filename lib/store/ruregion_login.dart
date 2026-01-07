import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/model/region_login_model.dart';

class RuregionLoginStorage {
  static const String key = 'regionApplogin';

  static Future<void> saveProfile(Loginregion res) async {
    print('save profile $res');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final regionlogin = res.toJson();
    await prefs.setString(key, jsonEncode(regionlogin));
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
