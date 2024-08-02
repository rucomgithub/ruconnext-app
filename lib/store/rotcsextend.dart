import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/model/rotcs_extend.dart';

class RotcsExtendStorage {
  static const String key = 'rotcsextend';

  static Future<void> saveExtend(RotcsExtend extend) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final extendJson = extend.toJson();
    await prefs.setString(key, jsonEncode(extendJson));
  }

  static Future<RotcsExtend> getExtend() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final registerString = prefs.getString(key);
    if (registerString != null && registerString != "") {
      final registerJson = jsonDecode(registerString);
      return RotcsExtend.fromJson(registerJson);
    }
    return RotcsExtend(studentCode: "", total: 0, detail: []);
  }

  static Future<void> removeExtend() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, '');
  }
}
