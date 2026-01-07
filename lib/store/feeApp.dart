import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/model/checkregis_model.dart';

class FeeRuregionAppStorage {
  static const String key = 'feeRegionApp';

  static Future<void> saveFeeRegionApp(Summary_reg feeregion) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final feeregionJson = feeregion.toJson();
    await prefs.setString(key, jsonEncode(feeregionJson));
  }

  static Future<Summary_reg> getFeeregionApp() async {
    Summary_reg feeregion = Summary_reg();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final feeregionString = prefs.getString(key);
    if (feeregionString != null) {
      final feeregionJson = jsonDecode(feeregionString);
      return Summary_reg.fromJson(feeregionJson);
    }

    return feeregion;
  }

  static Future<void> removeFeeregionApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
