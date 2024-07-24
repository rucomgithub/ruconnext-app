import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/master/models/master_register.dart';
import 'package:th.ac.ru.uSmart/master/services/masterregisterservice.dart';
import 'package:th.ac.ru.uSmart/model/profile.dart';
import 'package:th.ac.ru.uSmart/store/profile.dart';
import 'package:th.ac.ru.uSmart/store/registeryear.dart';
import '../../model/registeryear_model.dart';

class MasterRegisterProvider extends ChangeNotifier {
  final MasterRegisterService _service;

  MasterRegisterProvider({required MasterRegisterService service})
      : _service = service;

  bool isLoading = false;

  Map<String, List<REGISTERECORDVIEW>> _listGroupYearSemester = {};
  Map<String, List<REGISTERECORDVIEW>> get listGroupYearSemester =>
      _listGroupYearSemester;

  REGISTERYEAR _registeryear = REGISTERYEAR();
  REGISTERYEAR get registeryear => _registeryear;

  MasterRegister _register = MasterRegister();
  MasterRegister get register => _register;

  String _error = '';
  String get error => _error;

  List<REGISTERECORD> _registerrecord = [];
  List<REGISTERECORD> get registerrecord => _registerrecord;

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future<void> getAllRegister() async {
    isLoading = true;
    //notifyListeners();

    try {
      final response = await _service.getRegisterAll();
      _register = response;
      if (_register.stdCode != null) {
        _listGroupYearSemester =
            groupListSortCourse(_register.record!, ['semester', 'year']);
      }

      isLoading = false;
    } on Exception catch (e) {
      isLoading = false;
      _error = 'เกิดข้อผิดพลาด ${e.toString()}';
    }

    isLoading = false;
    notifyListeners();
  }

  void getAllRegisterYear() async {
    Profile profile = await ProfileStorage.getProfile();
    isLoading = true;
    notifyListeners();
    if (profile.studentCode != null) {
      try {
        final response =
            await _service.getAllRegisterYear(profile.studentCode.toString());
        _registeryear = response;
        await RegisterYearStorage.saveRegisterYear(_registeryear);
        isLoading = false;
      } on Exception catch (e) {
        isLoading = false;
        _error = 'เกิดข้อผิดพลาด';
      }
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

  Map<String, List<REGISTERECORDVIEW>> groupListSortCourse(
      List<REGISTERECORD> data, List<String> keys) {
    List<REGISTERECORDVIEW> temp = [];
    var groups = LinkedHashMap<String, List<REGISTERECORDVIEW>>();

    String startColor = '#FA7D82';
    String endColor = '#FFB295';
    String imagePath = 'assets/fitness_app/breakfast.png';

    data.asMap().forEach((index, element) {
      var key = keys.map((k) => _getValue(element, k)).join('/');

      if (!groups.containsKey(key)) {
        groups[key] = [];
      }

      temp = groups[key]!;

      int currentNumber = (index % 4) + 1;
      switch (currentNumber) {
        case 1:
          {
            imagePath = 'assets/fitness_app/breakfast.png';
            startColor = '#e6c543';
            endColor = '#e6c543';
          }
          break;
        case 2:
          {
            imagePath = 'assets/fitness_app/lunch.png';
            startColor = '#19196b';
            endColor = '#19196b';
          }
          break;
        case 3:
          {
            imagePath = 'assets/fitness_app/snack.png';
            startColor = '#e6c543';
            endColor = '#e6c543';
          }
          break;
        case 4:
          {
            imagePath = 'assets/fitness_app/dinner.png';
            startColor = '#19196b';
            endColor = '#19196b';
          }
          break;
      }

      temp.add(REGISTERECORDVIEW(
        year: element.year,
        semester: element.semester,
        stdCode: element.stdCode,
        courseNo: element.courseNo,
        credit: element.credit,
        startColor: startColor,
        endColor: endColor,
        imagePath: imagePath,
      ));

      groups[key] = temp;
    });

    groups.forEach((key, value) {
      value.sort(
          (a, b) => a.courseNo.toString().compareTo(b.courseNo.toString()));
    });

    return groups;
  }

  dynamic _getValue(REGISTERECORD element, String key) {
    switch (key) {
      case 'year':
        return element.year;
      case 'semester':
        return element.semester;
      case 'stdCode':
        return element.stdCode;
      case 'courseNo':
        return element.courseNo;
      case 'credit':
        return element.credit;
      default:
        return null;
    }
  }
}
