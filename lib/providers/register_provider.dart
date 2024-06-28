import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/model/coursetype.dart';
import 'package:th.ac.ru.uSmart/store/profile.dart';
import 'package:th.ac.ru.uSmart/store/registeryear.dart';
import '../model/profile.dart';
import '../model/register_model.dart';
import '../model/registeryear_model.dart';
import '../services/registerservice.dart';
import '../model/mr30_model.dart';

class RegisterProvider extends ChangeNotifier {
  final RegisterService _service;

  RegisterProvider({required RegisterService service}) : _service = service;

  bool isLoading = false;

  Map<String, List<String>> _listGroupYearSemester = {};
  Map<String, List<String>> get listGroupYearSemester => _listGroupYearSemester;

  Map<String, List<REGISTERECORDVIEW>> _listGroupCourse = {};
  Map<String, List<REGISTERECORDVIEW>> get listGroupCourse => _listGroupCourse;

  Map<String, List<CourseType>> _listMr30Catalog = {};
  Map<String, List<CourseType>> get listMr30Catalog => _listMr30Catalog;

  Map<String, Percentage> _listMr30CatalogPercentage = {};
  Map<String, Percentage> get listMr30CatalogPercentage =>
      _listMr30CatalogPercentage;

  REGISTERYEAR _registeryear = REGISTERYEAR();
  REGISTERYEAR get registeryear => _registeryear;

  MR30 _mr30 = MR30();
  MR30 get mr30 => _mr30;

  List<RECORD> _mr30record = [];
  List<RECORD> get mr30record => _mr30record;

  Register _register = Register();
  Register get register => _register;

  Register _registerall = Register();
  Register get registerall => _registerall;

  Mr30Catalog _mr30catalog = Mr30Catalog();
  Mr30Catalog get mr30catalog => _mr30catalog;

  String _error = '';
  String get error => _error;

  List<REGISTERECORD> _registerrecord = [];
  List<REGISTERECORD> get registerrecord => _registerrecord;

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future<void> getAllRegister() async {
    final REGISTERYEAR registeryear =
        await RegisterYearStorage.getRegisterYear();
    isLoading = true;

    if (registeryear.recordyear != null) {
      try {
        final response = await _service
            .getAllRegisterList(registeryear.recordyear![0].year.toString());
        await _service.getCourseType();
        _register = response;
        if (_register.stdCode != null) {
          _listGroupYearSemester = groupListSortByValues(
              _register.record!, ['regisYear', 'regisSemester']);
          _listGroupCourse = groupListSortByCourse(
              _register.record!, ['regisYear', 'regisSemester']);
        }

        isLoading = false;
      } on Exception catch (e) {
        _error = 'เกิดข้อผิดพลาด ${e.toString()}';
      }
    }

    notifyListeners();
  }

  Future<void> getRegisterAll() async {
    isLoading = true;
    _error = '';

    if (registeryear.recordyear != null) {
      try {
        final response = await _service.getAllRegisterList("");
        _registerall = response;
        isLoading = false;
      } on Exception catch (e) {
        _error = 'เกิดข้อผิดพลาด';
      }
    }

    notifyListeners();
  }

  Future<void> getAllRegisterByYear(String year) async {
    isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await _service.getAllRegisterList(year);
      _register = response;
      if (_register.stdCode != null) {
        _listGroupYearSemester = groupListSortByValues(
            _register.record!, ['regisYear', 'regisSemester']);
        _listGroupCourse = groupListSortByCourse(
            _register.record!, ['regisYear', 'regisSemester']);
      }
      isLoading = false;
    } on Exception catch (e) {
      _error = 'เกิดข้อผิดพลาด';
    }

    notifyListeners();
  }

  Future<void> getAllMr30Catalog() async {
    isLoading = true;

    try {
      final response = await _service.getCourseType();
      _mr30catalog = response;
      //print(_register);
      _listMr30Catalog =
          groupListByCourseType(_mr30catalog.coursetype!, ['typeno', 'type']);
      if (_register.year != null) {
        _listMr30CatalogPercentage = orderListByCourseTypeTest();
      }

      isLoading = false;
    } on Exception catch (e) {
      _error = 'เกิดข้อผิดพลาด ${e.toString()}';
    }

    notifyListeners();
  }

  Map<String, Percentage> orderListByCourseType() {
    var groupCount = Map<String, int>();

    _listMr30Catalog.forEach((key, value) {
      groupCount[key] = 0;
    });

    _registerall.record!.forEach((REGISTERECORD register) {
      _listMr30Catalog.forEach((key, listCourseType) {
        listCourseType.forEach((coursetype) {
          if (coursetype.courseno == register.courseNo) {
            groupCount[key] = groupCount[key]! + 1;
          }
        });
      });
    });

    Map<String, int> sortedMapDesc =
        sortMapByValue(groupCount, descending: true);

    var temp = Map<String, Percentage>();

    sortedMapDesc.entries.forEach((element) {
      temp[element.key] = Percentage(
          counter: element.value,
          percent: 0,
          listregister: [],
          listcoursetype: _listMr30Catalog[element.key]!);
    });

    Map<String, Percentage> percentageMap = calculatePercentageMatch(
        temp, sortedMapDesc.entries.elementAt(0).value.toInt());

    return percentageMap;
  }

  Map<String, Percentage> orderListByCourseTypeTest() {
    var groupCount = Map<String, Percentage>();

    _listMr30Catalog.forEach((key, value) {
      groupCount[key] = Percentage(
          counter: 0, percent: 0.0, listregister: [], listcoursetype: []);
    });

    _registerall.record!.forEach((REGISTERECORD register) {
      _listMr30Catalog.forEach((key, listCourseType) {
        listCourseType.forEach((coursetype) {
          if (coursetype.courseno == register.courseNo) {
            groupCount[key]!.counter = groupCount[key]!.counter + 1;
            groupCount[key]!.listregister.add(register.courseNo.toString());
          }
        });
      });
    });

    Map<String, Percentage> sortedMapDesc =
        sortMapByCountCourse(groupCount, descending: true);

    var temp = Map<String, Percentage>();

    sortedMapDesc.entries.forEach((element) {
      temp[element.key] = Percentage(
          counter: element.value.counter,
          percent: 0.0,
          listregister: element.value.listregister,
          listcoursetype: _listMr30Catalog[element.key]!);
    });

    Map<String, Percentage> percentageMap = calculatePercentageMatch(
        temp, sortedMapDesc.entries.elementAt(0).value.counter.toInt());

    return percentageMap;
  }

  List<CourseType> sortCourses(
      List<CourseType> courses, List<String> courseOrder) {
    courses.sort((a, b) {
      int indexA = courseOrder.indexOf(a.courseno.toString());
      int indexB = courseOrder.indexOf(b.courseno.toString());

      // Handle cases where the course name is not found in the order list
      if (indexA == -1) indexA = courseOrder.length;
      if (indexB == -1) indexB = courseOrder.length;

      return indexA.compareTo(indexB);
    });

    return courses;
  }

  Map<String, Percentage> sortMapByCountCourse(Map<String, Percentage> map,
      {bool descending = false}) {
    var sortedEntries = map.entries.toList()
      ..sort((a, b) => descending
          ? b.value.counter.compareTo(a.value.counter)
          : a.value.counter.compareTo(b.value.counter));

    return Map.fromEntries(sortedEntries);
  }

  Map<String, int> sortMapByValue(Map<String, int> map,
      {bool descending = false}) {
    var sortedEntries = map.entries.toList()
      ..sort((a, b) =>
          descending ? b.value.compareTo(a.value) : a.value.compareTo(b.value));

    return Map.fromEntries(sortedEntries);
  }

  Map<String, Percentage> calculatePercentageMatch(
      Map<String, Percentage> dataList, int targetValue) {
    Map<String, Percentage> result = {};

    dataList.forEach((key, v) {
      double percent = (v.counter / targetValue) * 95;
      List<CourseType> listSort = sortCourses(v.listcoursetype, v.listregister);

      listSort.forEach((course) {
        if (containsCourse(v.listregister, course.courseno.toString())) {
          course.imagePath = 'check';
          course.startColor = '#738AE6';
          course.endColor = '#5C5EDD';
          course.check = true;
          //startColor = '#6F72CA';
          //endColor = '#1E1466';
        } else {
          course.imagePath = 'assets/fitness_app/lunch.png';
          course.startColor = '#738AE6';
          course.endColor = '#FFB295';
          course.check = false;
          //startColor = '#738AE6';
          //endColor = '#5C5EDD';
        }
      });

      result[key] = Percentage(
          counter: v.counter,
          percent: percent,
          listregister: v.listregister,
          listcoursetype: listSort);
    });

    return result;
  }

  bool containsCourse(List<String> courses, String targetCourse) {
    // Convert both the courses and targetCourse to lowercase for case-insensitive comparison
    String lowercaseTargetCourse = targetCourse.toLowerCase();
    return courses
        .any((course) => course.toLowerCase() == lowercaseTargetCourse);
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + '...';
    }
  }

  Map<String, List<CourseType>> groupListByCourseType(
      List<CourseType> data, List<String> keys) {
    List<CourseType> temp = [];
    var groups = LinkedHashMap<String, List<CourseType>>();

    data.asMap().forEach((index, element) {
      var key = keys.map((k) => _getValueCourseType(element, k)).join('.');

      if (!groups.containsKey(key)) {
        groups[key] = [];
      }

      temp = groups[key]!;

      temp.add(CourseType(
          cname: truncateText(element.cname.toString(), 50),
          courseno: element.courseno,
          type: element.type,
          typeno: element.typeno));

      groups[key] = temp;
    });

    return groups;
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

  dynamic _getValueCourseType(CourseType element, String key) {
    switch (key) {
      case 'cname':
        return element.cname;
      case 'courseno':
        return element.courseno;
      case 'type':
        String type = element.type.toString();
        if (element.type == "ไม่สามารถจัดกลุ่มได้") {
          type = "General";
        }
        return type;
      case 'typeno':
        return element.typeno;
      default:
        return null;
    }
  }

  Map<String, List<REGISTERECORDVIEW>> groupListSortByCourse(
      List<REGISTERECORD> data, List<String> keys) {
    List<REGISTERECORDVIEW> temp = [];
    var groups = LinkedHashMap<String, List<REGISTERECORDVIEW>>();
    String startColor = '#738AE6';
    String endColor = '#5C5EDD';
    String imagePath = 'assets/fitness_app/breakfast.png';

    data.asMap().forEach((index, element) {
      var key = keys.map((k) => _getValue(element, k)).join('/');

      if (!groups.containsKey(key)) {
        groups[key] = [];
      }

      temp = groups[key]!;

      // int currentNumber = (index % 4) + 1;
      // switch (currentNumber) {
      //   case 1:
      //     {
      //       imagePath = 'assets/fitness_app/breakfast.png';
      //       //startColor = '#FA7D82';
      //       //endColor = '#FFB295';
      //     }
      //     break;
      //   case 2:
      //     {
      //       imagePath = 'assets/fitness_app/lunch.png';
      //       //startColor = '#738AE6';
      //       //endColor = '#5C5EDD';
      //     }
      //     break;
      //   case 3:
      //     {
      //       imagePath = 'assets/fitness_app/snack.png';
      //       //startColor = '#FE95B6';
      //       //endColor = '#FF5287';
      //     }
      //     break;
      //   case 4:
      //     {
      //       imagePath = 'assets/fitness_app/dinner.png';
      //       //startColor = '#6F72CA';
      //       //endColor = '#1E1466';
      //     }
      //     break;
      // }

      temp.add(REGISTERECORDVIEW(
        regisYear: element.regisYear,
        regisSemester: element.regisSemester,
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
    Profile profile = await ProfileStorage.getProfile();
    isLoading = true;
    if (profile.studentCode != null) {
      try {
        final response =
            await _service.getAllRegisterYear(profile.studentCode.toString());
        _registeryear = response;
        await RegisterYearStorage.saveRegisterYear(_registeryear);
        isLoading = false;
      } on Exception catch (e) {
        _error = 'เกิดข้อผิดพลาด';
      }
    }

    notifyListeners();
  }
}
