import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/MR30_model.dart';

class MR30Storage {
  static const String key = 'mr30';

  static Future<void> saveMR30(MR30 mr30) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mr30Json = mr30.toJson();
    await prefs.setString(key, jsonEncode(mr30Json));
  }

  static Future<MR30> getMR30() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mr30String = prefs.getString(key);
    if (mr30String != null) {
      final mr30Json = jsonDecode(mr30String);
      return MR30.fromJson(mr30Json);
    }
    return MR30();
  }

  static Future<void> removeMR30() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('mr30register');
  }
}
