import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/yearsemester.dart';

class YearSemtesterStorage {
  static const String key = 'yearsemester';

  static Future<void> saveYearSemester(YearSemester yearSemester) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final yearSemesterJson = yearSemester.toJson();
    await prefs.setString(key, jsonEncode(yearSemesterJson));
  }

  static Future<YearSemester> getYearSemester() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final yearSemesterString = prefs.getString(key);
    if (yearSemesterString != null) {
      final yearSemesterJson = jsonDecode(yearSemesterString);
      return YearSemester.fromJson(yearSemesterJson);
    }
    return YearSemester(year: "", semester: "");
  }

  static Future<void> removeYearSemester() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, '');
  }
}
