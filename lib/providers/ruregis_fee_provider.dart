// import 'dart:convert';

// import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/model/checkregis_model.dart';
import 'package:th.ac.ru.uSmart/model/ruregis_fee_model.dart';
import 'package:th.ac.ru.uSmart/services/ruregis_service.dart';

import 'package:flutter/material.dart';
import '../model/mr30_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../exceptions/dioexception.dart';

class RuregisFeeProvider extends ChangeNotifier {
  final _ruregisService = RuregisService();

  // List<Ruregis> _ruregis = [];
  String _error = '';
  String get error => _error;
  String stdcode = '';
  bool isLoading = false;

  // List<Ruregis> get ruregis => _ruregis;

  Ruregisfee _ruregisfee = Ruregisfee();
  Ruregisfee get ruregisfee => _ruregisfee;

  Summary_reg _summary = Summary_reg();
  Summary_reg get summary => _summary;

  List<RECORD> _mr30record = [];
  List<RECORD> get mr30record => _mr30record;

  List<ResultsFee> _summaryrec = [];
  List<ResultsFee> get summaryrec => _summaryrec;
  int sumIntCredit = 0;

  Future<void> fetchFeeRuregis() async {
    isLoading = true;
    _error = '';

    notifyListeners();
    try {
      final response = await _ruregisService.getFeeRuregis();
      _ruregisfee = response;
      // print('length ${_ruregisfee.rec!.length}');
      //  print('fee $_ruregisfee');
    } on Exception {
      isLoading = false;
      _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    }

    //await _service.asyncName();

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchLocationExam() async {
    isLoading = true;
    _error = '';

    notifyListeners();
    try {
      final response = await _ruregisService.getFeeRuregis();
      _ruregisfee = response;
      // print('length ${_ruregisfee.rec!.length}');
      //  print('fee $_ruregisfee');
    } on Exception {
      isLoading = false;
      _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    }

    //await _service.asyncName();

    isLoading = false;
    notifyListeners();
  }

  Future<void> getCalPay(mr30, stdcode, semester, year) async {
    isLoading = true;
    print(mr30);
    //final Map<String, dynamic> jsonData = json.decode(mr30ruregion);
    double sumCredit = 0;
    int countElements = 0;
    String courseNo = '';
    mr30.forEach((element) => {
          sumCredit += element.cREDIT,
          countElements++,
        });
    sumIntCredit = sumCredit.round();
    List<Map<String, dynamic>> resultArray = [];

    // วนลูปผ่าน mr30 และดึง courseNo และ cREDIT มาเก็บใน resultArray
    mr30.forEach((element) {
      resultArray.add({
        'COURSE_NO': element['courseNo'],
        'CREDIT': element['cREDIT'],
      });
    });
    try {
      final response = await _ruregisService.getProfileRuregion(stdcode);
      // print('${response} ${sumIntCredit} ${countElements}');
      final responseCheck = await _ruregisService.postCalPayRegion(
          response, sumIntCredit, countElements, semester, year, resultArray);
      _summary = responseCheck;
      // print('summary ${_summary.success}');
    } on Exception {
    } catch (e) {}

    isLoading = false;

    notifyListeners();
  }

  Future<void> getCalPayRegionApp() async {
    isLoading = true;
    try {
      print('getCalPayRegionApp');
      final responseCheck = await _ruregisService.postCalPayRegionApp();
      _summary = responseCheck;

      print('summary ${_summary}');
    } on Exception {
    } catch (e) {}

    isLoading = false;

    notifyListeners();
  }

  Future<void> summaryFee() async {
    isLoading = true;
    _error = '';

    notifyListeners();
    // print('summaryFees');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<RECORD> res = [];
      final sres = prefs.getString('mr30ruregis')!;

      final responsefee = await _ruregisService.getFeeRuregis();
      _ruregisfee = responsefee;

      res = RECORD.decode(sres);
      _mr30record = res;

      _mr30record
          .forEach((element) => print('mr30storage ${element.courseNo}'));
      _mr30record
          .forEach((element) => print('mr30storage ${element.courseCredit}'));

      _ruregisfee.rec?.forEach((element) {
        var contain = _ruregisfee.rec!.where((e) => element.feeno == 1);
        // print('feeno 1 : ${element.feeno}');
      });
      final response = await _ruregisService.getFeeRuregis();
      _ruregisfee = response;
    } on Exception {
      isLoading = false;
      _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    }

    //await _service.asyncName();

    isLoading = false;
    notifyListeners();
  }
}
