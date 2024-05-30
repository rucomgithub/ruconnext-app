// import 'dart:convert';

// import 'package:dio/dio.dart';
import 'package:th.ac.ru.uSmart/model/runews.dart';
import 'package:th.ac.ru.uSmart/services/runewsservice.dart';
import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// import '../exceptions/dioexception.dart';

class RunewsProvider extends ChangeNotifier {
  final _service = RunewsService();
  bool isLoading = false;

  String _error = '';
  String get error => _error;

  List<runews> _runewsReccord = [];
  List<runews> get runewsRecord => _runewsReccord;

  Future<void> getAllRunews() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getAll();
      _runewsReccord = response;
    } catch (e) {
      _error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
