import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/model/counter_region_model.dart';




class CounterRegionAppStorage {
  static const String key = 'counterRegionApp';

  static Future<void> saveCounterRegionApp(CounterRegion counterregion) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final counterregionJson = counterregion.toJson();
    await prefs.setString(key, jsonEncode(counterregionJson));
  }

  static Future<CounterRegion> getCounterRegionApp() async {
    CounterRegion counterregion = CounterRegion();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final counterregionString = prefs.getString(key);
    if (counterregionString != null) {
      final counterregionJson = jsonDecode(counterregionString);
      return CounterRegion.fromJson(counterregionJson);
    }

    return counterregion;
  }

  static Future<void> removeCounterRegionApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
