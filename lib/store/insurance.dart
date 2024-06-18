import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/model/insurance.dart';

class InsuranceStorage {
  static const String key = 'insurance';

  static Future<void> save(Insurance insurance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final insuranceJson = insurance.toJson();
    await prefs.setString(key, jsonEncode(insuranceJson));
  }

  static Future<Insurance> get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final insuranceString = prefs.getString(key);
    print('cache storage: $insuranceString');
    if (insuranceString == null) {
      return Insurance();
      
    }

    final insuranceJson = jsonDecode(insuranceString);
      return Insurance.fromJson(insuranceJson);
  }

  static Future<void> remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('clear cache....');
    await prefs.setString(key, '{}');
  }
}
