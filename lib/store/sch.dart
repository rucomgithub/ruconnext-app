import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/model/scholarship.dart';

class SchStorage {
  static const String key = 'sch';
  static Future<void> saveSch(Scholarship sch) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final schJson = sch.toJson();
    await prefs.setString(key, jsonEncode(schJson));
  }

  static Future<Scholarship> getSch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final schString = prefs.getString(key);
    //print('cache storage: $schString');
    if (schString != null) {
      final schJson = jsonDecode(schString);
      return Scholarship.fromJson(schJson);
    }

    return Scholarship();
  }

  static Future<void> removeSch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //print('clear cache....');
    await prefs.setString(key, '{}');
  }
}
