import 'dart:collection';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/profile.dart';
import '../model/register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/registeryear_model.dart';
import '../services/registerservice.dart';
import '../model/mr30_model.dart';

class RegisterProvider extends ChangeNotifier {
  final _service = RegisterService();
  bool isLoading = false;

  Map<String, List<String>> _listGroupYearSemester = {};

  Map<String, List<String>> get listGroupYearSemester => _listGroupYearSemester;

  REGISTERYEAR _registeryear = REGISTERYEAR();
  REGISTERYEAR get registeryear => _registeryear;

  MR30 _mr30 = MR30();
  MR30 get mr30 => _mr30;

  List<RECORD> _mr30record = [];
  List<RECORD> get mr30record => _mr30record;

  Register _register = Register();
  Register get register => _register;

  String _error = '';
  String get error => _error;

  List<REGISTERECORD> _registerrecord = [];
  List<REGISTERECORD> get registerrecord => _registerrecord;

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  void getMR30Register() async{
       SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getAllregisterLatest();
      _mr30 = response;

      _mr30.rECORD?.forEach((element) {
        var contain = _mr30record.where((e) => element.id == e.id);
        if (contain.isNotEmpty) {
          element.favorite = true;
        } else {
          element.favorite = false;
        }
      });
      prefs.setString('mr30register',  jsonEncode(_mr30.rECORD));
      isLoading = false;
    } on Exception catch (e) {
      isLoading = false;
      _error = 'เกิดข้อผิดพลาด';
    }

    notifyListeners();
  }

  void getAllRegister() async {
    //print('register:');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String yearstring = prefs.getString('registeryear')!;
    REGISTERYEAR registeryear = REGISTERYEAR.fromJson(jsonDecode(yearstring));
    setLoading(true);
    try {
      final response = await _service.getAllRegisterList(
          '6302045098', registeryear.recordyear![0].year);
      _register = response;
      _listGroupYearSemester = groupListSortByValues(
          _register.record!, ['regisYear', 'regisSemester']);

      setLoading(false);
    } on Exception catch (e) {
      _error = 'เกิดข้อผิดพลาด';
      setLoading(false);
    }
  }

  void getAllRegisterByYear(String year) async {
    //print('year: $year');
    isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getAllRegisterList('6302045098', year);
      _register = response;
      _listGroupYearSemester = groupListSortByValues(
          _register.record!, ['regisYear', 'regisSemester']);

      // print(
      //     '_listGroupYearSemester: ${_listGroupYearSemester.entries.first.key} : ${_listGroupYearSemester.entries.first.value}');
    } on Exception catch (e) {
      isLoading = false;
      _error = 'เกิดข้อผิดพลาด';
    }

    isLoading = false;
    notifyListeners();
  }

  Map<String, List<String>> groupListSortByValues(
      List<REGISTERECORD> data, List<String> keys) {
    List<String> temp = [];
    var groups = LinkedHashMap<String, List<String>>();

    for (var element in data) {
      var key = keys.map((k) => _getValue(element, k)).join('/');

      if (!groups.containsKey(key)) {
        groups[key] = [];
      }

      temp = groups[key]!;

      temp.add('${element.courseNo!} (${element.credit!})');

      groups[key] = temp;
    }

    groups.forEach((key, value) {
      value.sort((a, b) => a.compareTo(b));
    });

    return groups;
  }

  dynamic _getValue(REGISTERECORD element, String key) {
    switch (key) {
      case 'regisYear':
        return element.regisYear;
      case 'regisSemester':
        return element.regisSemester;
      case 'courseNo':
        return element.courseNo;
      case 'credit':
        return element.credit;
      default:
        return null;
    }
  }

  void getAllRegisterYear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String profilestring = prefs.getString('profile')!;
    Profile profile = Profile.fromJson(jsonDecode(profilestring));
    //print(profile.studentCode);
    isLoading = true;
    notifyListeners();
    try {
      final response =
          await _service.getAllRegisterYear(profile.studentCode.toString());
      _registeryear = response;
    //  print(profile.studentCode.toString());
      await prefs.setString('registeryear', jsonEncode(_registeryear));
      isLoading = false;
    } on Exception catch (e) {
      isLoading = false;
      _error = 'เกิดข้อผิดพลาด';
    }
    isLoading = false;
    notifyListeners();
  }


  void getHaveTodayRegister() async{
    
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String mr30register = prefs.getString('mr30register')!;
//     MR30 listmr30register = jsonDecode(mr30register);
//     print('provider register mr30 ${listmr30register.rECORD!.length}');
//         notifyListeners();
  }
}
