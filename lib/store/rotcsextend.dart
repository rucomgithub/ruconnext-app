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
    final extendString = prefs.getString(key);
    print('cache storage: $extendString');
    if (extendString != null) {
      final extendJson = jsonDecode(extendString);
      return RotcsExtend.fromJson(extendJson);
    }

    return RotcsExtend();
  }

  static Future<void> removeExtend() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('clear cache....');
    await prefs.setString(key, '{}');
  }
}
