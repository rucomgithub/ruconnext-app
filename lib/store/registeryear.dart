import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/registeryear_model.dart';

class RegisterYearStorage {
  static const String key = 'registeryear';

  static Future<void> saveRegisterYear(REGISTERYEAR registerYear) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final registerYearJson = registerYear.toJson();
    await prefs.setString(key, jsonEncode(registerYearJson));
  }

  static Future<REGISTERYEAR> getRegisterYear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final registerYearString = prefs.getString(key);
    if (registerYearString != null) {
      final registerYearJson = jsonDecode(registerYearString);
      return REGISTERYEAR.fromJson(registerYearJson);
    }
    return REGISTERYEAR();
  }

  static Future<void> removeRegisterYear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, '');
  }
}
