import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/model/ruregion_mr30_model.dart';



class MR30AppStorage {
  static const String key = 'mr30App';

  static Future<void> saveMR30App(List<ResultsMr30> mr30rec) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mr30Json = mr30rec.map((item) => item.toJson()).toList();


    await prefs.setString(key, jsonEncode(mr30Json));
  }

static Future<List<ResultsMr30>> getMR30App() async {
  List<ResultsMr30> mr30 = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final mr30String = prefs.getString(key);
  if (mr30String != null) {
    final List<dynamic> mr30JsonList = jsonDecode(mr30String);
    mr30 = mr30JsonList.map((json) => ResultsMr30.fromJson(json)).toList();
  }

  return mr30;
}


  static Future<void> removeMR30App() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
