import 'dart:collection';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../fitness_app/models/grade_list_data.dart';
import 'package:th.ac.ru.uSmart/model/mr30_catalog.dart';
import 'package:th.ac.ru.uSmart/services/studentservice.dart';
import '../model/grade_model.dart';
import '../model/profile.dart';
import '../services/gradeservice.dart';
import '../store/profile.dart';

class GradeProvider extends ChangeNotifier {
  final _service = GradeService();
  final _serviceStudent = StudentService();
  bool isLoading = false;
  var catalogs;

  late Map<String, Map<String, int>> _groupCourse = {};
  late Map<String, Map<String, int>> _groupYearSemester = {};
  late Map<String, Map<String, int>> _groupByCatalog = {};
  late Map<String, int> _summaryCreditPass = {};
  late List<GradeListData> _gradeYearSemester = [GradeListData()];
  late Map<String, List<String>> _gradeList = {};
  late Map<String, List<String>> _listGroupYearSemester = {};
  late Map<String, Map<String, int>> _groupGrade = {};

  late List<String> _grades = [];
  late List<int> _counts = [];
  late List<int> _ticks = [];

  late List<String> _gradesCatalog = [];
  late List<int> _countsCatalog = [];
  late List<int> _ticksCatalog = [];

  Map<String, Map<String, int>> get groupYearSemester => _groupYearSemester;

  Map<String, Map<String, int>> get groupByCatalog => _groupByCatalog;

  Map<String, Map<String, int>> get groupCourse => _groupCourse;

  Map<String, int> get summaryCreditPass => _summaryCreditPass;

  Map<String, Map<String, int>> get groupGrade => _groupGrade;

  Map<String, List<String>> get listGroupYearSemester => _listGroupYearSemester;

  List<GradeListData> get gradeYearSemester => _gradeYearSemester;

  Map<String, List<String>> get gradeList => _gradeList;

  List<String> get grades => _grades;
  List<int> get counts => _counts;
  List<int> get ticks => _ticks;

  List<String> get gradesCatalog => _gradesCatalog;
  List<int> get countsCatalog => _countsCatalog;
  List<int> get ticksCatalog => _ticksCatalog;

  List<Rec> _catalogsCombine = [];
  List<Rec> get catalogsCombine => _catalogsCombine;

  Grade _grade = Grade();
  Grade get grade => _grade;

  String _error = '';
  String get error => _error;

  List<RECORD> _graderecord = [];
  List<RECORD> get graderecord => _graderecord;

  Mr30Catalog _mr30catalog = Mr30Catalog();
  Mr30Catalog get mr30catalog => _mr30catalog;

  List<Rec> _mr30catalogrecord = [];
  List<Rec> get mr30catalogrecord => _mr30catalogrecord;

  void getAllGrade() async {
    Profile profile = await ProfileStorage.getProfile();
    isLoading = true;
    notifyListeners();

    if (profile.studentCode != null) {
      try {
        final response = await _service.getAllGrade(profile);

        _grade = response;

        _graderecord = response.record!;

        _summaryCreditPass = sumCreditPass(_grade.record!);

        _groupCourse = groupByMultiKey(_grade.record!, ['courseNo']);

        _groupCourse = sortByValues(_groupCourse, 'DESC');

        _groupYearSemester =
            groupByMultiKey(_grade.record!, ['regisYear', 'regisSemester']);

        _groupYearSemester = sortByKeys(_groupYearSemester, 'DESC');

        _listGroupYearSemester = groupListSortByValues(
            _grade.record!, ['regisYear', 'regisSemester']);

        _gradeList = groupListSortByKeys(_grade.record!, ['grade']);

        _gradeYearSemester = groupMealsList(_groupYearSemester);

        _groupGrade = groupByMultiKey(_grade.record!, ['grade']);

        _groupGrade = sortByKeys(_groupGrade, '');

        

        final res = await _serviceStudent.getMr30Catalog();
        _mr30catalog = res;
        _mr30catalogrecord = res.rec!;
        // _catalogsCombine =   _mr30catalogrecord.where((e) =>  _graderecord.any((record)=> record.courseNo == e.cOURSENO)).toList();
        _catalogsCombine = _mr30catalogrecord
            .where((e) =>
                _graderecord.any((record) => record.courseNo == e.cOURSENO && record.grade != "F" && record.grade != "F*"))
            .map((e) {
          // Find the matching grade from _graderecord
          var matchedGrade = _graderecord
              .firstWhere((record) => record.courseNo == e.cOURSENO && record.grade != "F" && record.grade != "F*")
              .grade;
          // Return a new Rec object with the grade set
          return Rec(
              cName: e.cName,
              cOURSENO: e.cOURSENO,
              type: e.type,
              typeNo: e.typeNo,
              grade: matchedGrade ??
                  e.grade // If no matching grade is found, keep the original grade
              );
        }).toList();
        summary(response.record!,_groupByCatalog);
      } on Exception catch (e) {
        _error = '$e : เกิดข้อผิดพลาด';
      }
    }
    // print(_catalogsCombine);
    _groupByCatalog = groupByCatalogs(_catalogsCombine);
    summaryGradeCatalog(_groupByCatalog);
    
    // print('${_groupByCatalog}');
    isLoading = false;
    notifyListeners();
  }

  void calCatalogGrade() async {}

  void getMr30Catalog() async {
    // isLoading = true;
    // _error = '';
    //    print('-----------------------------------grade-----------------------------------${_graderecord}');
    // notifyListeners();
    // try {

    //   final response = await _serviceStudent.getMr30Catalog();
    //   _mr30catalog = response  ;
    //   _mr30catalogrecord = response.rec!;
    //         print('-----------------------------------provider catalog-----------------------------------${_mr30catalogrecord} ');

    //         _catalogsCombine = _mr30catalogrecord.where((e) =>  _graderecord.any((record)=> record.courseNo == e.cOURSENO)).toList();
    //        print('-----------------------------------print catalog-----------------------------------${_catalogsCombine}');
    //     //  for (int i = 0; i < _graderecord.length; i++) {
    //     //     var contain = _mr30catalogrecord.where((e) => _graderecord[i].courseNo == e.cOURSENO).toList();
    //     //     print(contain);
    //     // }
    // } on Exception catch (e) {
    //   isLoading = false;
    //   _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    // }

    // //await _service.asyncName();

    // isLoading = false;
    // notifyListeners();
  }
  Map<String, int> sumCreditPass(List<RECORD> data) {
    Map<String, int> summary = {'PASS': 0, 'NOT_PASS': 0, 'ALL': 0};
    int pass = 0;
    int notPass = 0;

    if (data.isNotEmpty) {
      for (var element in data) {
        if (element.grade != "F" && element.grade != "F*") {
          pass += int.parse(element.credit!);
        } else {
          notPass += int.parse(element.credit!);
        }
      }
    }

    summary = {'PASS': pass, 'NOT_PASS': notPass, 'ALL': pass + notPass};
    return summary;
  }

  LinkedHashMap<String, Map<String, int>> sortByKeys(
      Map<String, Map<String, int>> groups, String sort) {
    var sortedGroups = groups.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    if (sort == "DESC")
      sortedGroups = groups.entries.toList()
        ..sort((a, b) => b.key.compareTo(a.key));

    LinkedHashMap<String, Map<String, int>> sortedMap =
        LinkedHashMap.fromEntries(sortedGroups);

    return sortedMap;
  }

  LinkedHashMap<String, Map<String, int>> sortByValues(
      Map<String, Map<String, int>> groups, String sort) {
    var sortedGroups = groups.entries.toList();

    sortedGroups.sort((a, b) =>
        a.value['credit_sum']!.toInt() - b.value['credit_sum']!.toInt());

    if (sort == "DESC")
      sortedGroups.sort((a, b) =>
          b.value['credit_sum']!.toInt() - a.value['credit_sum']!.toInt());

    LinkedHashMap<String, Map<String, int>> sortedMap =
        LinkedHashMap.fromEntries(sortedGroups);

    return sortedMap;
  }

  Map<String, Map<String, int>> groupByMultiKey(
      List<RECORD> data, List<String> keys) {
    int temp = 0;
    int count = 0;
    var groups = LinkedHashMap<String, Map<String, int>>();

    if (data.isNotEmpty) {
      for (var element in data) {
        var key = keys.map((k) => _getValue(element, k)).join('/');

        if (!groups.containsKey(key)) {
          groups[key] = {'credit_sum': 0, 'count': 0};
        }

        temp = groups[key]!['credit_sum']!;
        count = groups[key]!['count']!;

        temp += int.parse(element.credit!);
        count += 1;

        groups[key]!['credit_sum'] = temp;
        groups[key]!['count'] = count;
      }
    }

    return groups;
  }

  Map<String, Map<String, int>> groupByCatalogs(List<Rec> data) {
    Map<String, int> gradeValues = {
      'F': 0,
      'F*': 0,
      'D': 1,
      'D+': 1,
      'C': 2,
      'C+': 2,
      'B': 3,
      'B+': 3,
      'A': 4
    };
    int temp = 0;
    int count = 0;
    var groups = LinkedHashMap<String, Map<String, int>>();

    if (data.isNotEmpty) {
      for (var element in data) {
        var key = element.typeNo.toString();

        if (!groups.containsKey(key)) {
          groups[key] = {'sum': 0, 'count': 0};
        }

        temp = groups[key]!['sum']!;
        count = groups[key]!['count']!;

        temp += gradeValues[element.grade.toString()]!;
        count += 1;

        groups[key]!['sum'] = temp;
        groups[key]!['count'] = count;
      }
    }

    return groups;
  }

  Map<String, List<String>> groupListSortByValues(
      List<RECORD> data, List<String> keys) {
    List<String> temp = [];
    var groups = LinkedHashMap<String, List<String>>();

    for (var element in data) {
      var key = keys.map((k) => _getValue(element, k)).join('/');

      if (!groups.containsKey(key)) {
        groups[key] = [];
      }

      temp = groups[key]!;

      temp.add('${element.courseNo!}, ${element.grade!}, ${element.credit}');

      groups[key] = temp;
    }

    groups.forEach((key, value) {
      value.sort((a, b) => a.compareTo(b));
    });

    return groups;
  }

  Map<String, List<String>> groupListSortByKeys(
      List<RECORD> data, List<String> keys) {
    List<String> temp = [];
    var groups = LinkedHashMap<String, List<String>>();

    for (var element in data) {
      var key = keys.map((k) => _getValue(element, k)).join('');

      if (!groups.containsKey(key)) {
        groups[key] = [];
      }

      temp = groups[key]!;

      temp.add('${element.courseNo!}, ${element.grade!}, ${element.credit!}');

      groups[key] = temp;
    }

    groups.forEach((key, value) {
      value.sort((a, b) => a.compareTo(b));
    });
    var sortedMap = LinkedHashMap<String, List<String>>.fromEntries(
        groups.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));

    sortedMap.forEach((key, value) {
      value.sort((a, b) => a.compareTo(b));
    });

    return sortedMap;
  }

  List<GradeListData> groupMealsList(Map<String, Map<String, int>> data) {
    List<GradeListData> tabIconsList = <GradeListData>[];
    int i = 0;
    String startColor = '#FA7D82';
    String endColor = '#FFB295';
    String imagePath = 'assets/fitness_app/breakfast.png';

    for (var entry in data.entries) {
      switch (i) {
        case 0:
          {
            imagePath = 'assets/fitness_app/breakfast.png';
            startColor = '#FA7D82';
            endColor = '#FFB295';
          }
          break;
        case 1:
          {
            imagePath = 'assets/fitness_app/lunch.png';
            startColor = '#738AE6';
            endColor = '#5C5EDD';
          }
          break;
        case 2:
          {
            imagePath = 'assets/fitness_app/snack.png';
            startColor = '#FE95B6';
            endColor = '#FF5287';
          }
          break;
        case 3:
          {
            imagePath = 'assets/fitness_app/dinner.png';
            startColor = '#6F72CA';
            endColor = '#1E1466';
          }
          break;
        case 4:
          {
            imagePath = 'assets/fitness_app/breakfast.png';
            startColor = '#FA7D82';
            endColor = '#FFB295';
            i = 0;
          }
      }

      tabIconsList.add(GradeListData(
        imagePath: imagePath,
        yearSemester: entry.key,
        creditsum: data[entry.key]!['credit_sum']!,
        grades: _listGroupYearSemester[entry.key],
        startColor: startColor,
        endColor: endColor,
      ));
      i++;
    }

    return tabIconsList;
  }

  dynamic _getValue(RECORD element, String key) {
    switch (key) {
      case 'regisYear':
        return element.regisYear;
      case 'regisSemester':
        return element.regisSemester;
      case 'courseNo':
        return element.courseNo;
      case 'credit':
        return element.credit;
      case 'grade':
        return element.grade;
      default:
        return null;
    }
  }

  void summaryGradeCatalog(Map<String, Map<String, int>> data) {
    final gradeCat = List.filled(9, 0);
    List<String> gradesCat = [
      "ศิลปะ",
      "ภาษา",
      "ตรรกศาสตร์",
      "ร่างกาย",
      "ดนตรี",
      "มนุษย์สัมพันธ์",
      "ความเข้าใจตน",
      "ธรรมชาติ",
      "ทั่วไป"
    ];
    
  data.forEach((key, value) {
    var _list = value.values.toList();
    var keyCat = int.parse(key)-1;
     gradeCat[keyCat] = _list[0];
    print('$key,${_list[0]},${gradeCat}');
   });

  }

  void summary(List<RECORD> data,Map<String, Map<String, int>> dataCat) {
    Map<String, int> gradeCounts = {};
    Map<String, int> creditSumByGrade = {};
  final gradeCat = List.filled(9, 1);

    for (RECORD record in data) {
      String grade = record.grade!;
      int credit = int.parse(record.credit!);

      // Count the occurrences of each "grade"
      gradeCounts.update(grade, (value) => value + 1, ifAbsent: () => 1);

      // Sum the "credit" for each "grade"
      creditSumByGrade.update(grade, (value) => value + credit,
          ifAbsent: () => credit);
    }

    List<String> grades = gradeCounts.keys.toList();
    List<int> counts = gradeCounts.values.toList();

    

    List<String> gradesCat = [
      "ศิลปะ",
      "ภาษา",
      "ตรรกศาสตร์",
      "ร่างกาย",
      "ดนตรี",
      "มนุษย์สัมพันธ์",
      "ความเข้าใจตน",
      "ธรรมชาติ",
      "ทั่วไป"
    ];
     dataCat.forEach((key, value) {
    var _list = value.values.toList();
    var keyCat = int.parse(key)-1;
     gradeCat[keyCat] = _list[0];
    // print('$key,${_list[0]},${gradeCat}');
   });
    List<int> countsCat = gradeCat;


    _counts = counts;
    _grades = grades;
    _ticks = ticksArray(counts);

    _gradesCatalog = gradesCat;
    _countsCatalog = countsCat;
     _ticksCatalog = ticksArray(countsCat);
  }

  List<int> ticksArray(List<int> data) {
    int maxValue = data.reduce((max, value) => value > max ? value : max);

    List<int> values = List.generate(maxValue, (index) => index + 1);

    int minValue = values.reduce((min, value) => value < min ? value : min);

    int middleValue = values[values.length ~/ 2];

    int valueBetweenMinAndMiddle = (minValue + middleValue) ~/ 2;
    int valueBetweenMiddleAndMax = (middleValue + maxValue) ~/ 2;

    List<int> result = [
      minValue,
      valueBetweenMinAndMiddle,
      middleValue,
      valueBetweenMiddleAndMax,
      maxValue
    ];

    return result;
  }
}
