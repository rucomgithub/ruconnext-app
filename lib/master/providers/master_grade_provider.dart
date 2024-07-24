import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/master/models/master_grade.dart';
import 'package:th.ac.ru.uSmart/master/models/master_grade_list_data.dart';
import 'package:th.ac.ru.uSmart/master/services/mastergradeservice.dart';
import '../../model/profile.dart';
import '../../store/profile.dart';

class MasterGradeProvider extends ChangeNotifier {
  final _service = MasterGradeService();
  bool isLoading = false;

  late Map<String, Map<String, int>> _groupCourse = {};
  late Map<String, Map<String, int>> _groupYearSemester = {};
  late Map<String, int> _summaryCreditPass = {};
  late List<MasterGradeListData> _gradeYearSemester = [MasterGradeListData()];
  late Map<String, List<String>> _gradeList = {};
  late Map<String, List<String>> _gradeListPass = {};
  late Map<String, List<String>> _listGroupYearSemester = {};
  late Map<String, Map<String, int>> _groupGrade = {};

  late List<String> _grades = [];
  late List<int> _counts = [];
  late List<int> _ticks = [];

  Map<String, Map<String, int>> get groupYearSemester => _groupYearSemester;

  Map<String, Map<String, int>> get groupCourse => _groupCourse;

  Map<String, int> get summaryCreditPass => _summaryCreditPass;

  Map<String, Map<String, int>> get groupGrade => _groupGrade;

  Map<String, List<String>> get listGroupYearSemester => _listGroupYearSemester;

  List<MasterGradeListData> get gradeYearSemester => _gradeYearSemester;

  Map<String, List<String>> get gradeList => _gradeList;

  Map<String, List<String>> get gradeListPass => _gradeListPass;

  List<String> get grades => _grades;
  List<int> get counts => _counts;
  List<int> get ticks => _ticks;

  MasterGrade _grade = MasterGrade();
  MasterGrade get grade => _grade;

  String _error = '';
  String get error => _error;

  List<GRADEDATA> _graderecord = [];
  List<GRADEDATA> get graderecord => _graderecord;

  void getAllGrade() async {
    Profile profile = await ProfileStorage.getProfile();
    isLoading = true;
    notifyListeners();

    if (profile.studentCode != null) {
      try {
        final response = await _service.getAllGrade(profile);

        _grade = response;

        //print(_grade.gradedata!.length);

        _summaryCreditPass = sumCreditPass(_grade.gradedata!);

        _groupCourse = groupByMultiKey(_grade.gradedata!, ['courseNo']);

        _groupCourse = sortByValues(_groupCourse, 'DESC');

        _groupYearSemester =
            groupByMultiKey(_grade.gradedata!, ['year', 'semester']);

        _groupYearSemester = sortByKeys(_groupYearSemester, 'DESC');

        _listGroupYearSemester =
            groupListSortByValues(_grade.gradedata!, ['year', 'semester']);

        _gradeList = groupListSortByKeys(_grade.gradedata!, ['grade']);

        //_gradeListPass = groupPassListSortByKeys(_grade.gradedata!, ['grade']);

        _gradeYearSemester = groupMealsList(_groupYearSemester);

        _groupGrade = groupByMultiKey(_grade.gradedata!, ['grade']);

        _groupGrade = sortByKeys(_groupGrade, '');

        summary(response.gradedata!);
      } on Exception catch (e) {
        _error = 'เกิดข้อผิดพลาด';
      }
    }

    isLoading = false;
    notifyListeners();
  }

  Map<String, List<String>> groupPassListSortByKeys(
      List<GRADEDATA> data, List<String> keys) {
    List<GRADEDATA> temp = [];
    var groups = LinkedHashMap<String, List<GRADEDATA>>();

    var datas = data;

    for (var element in datas) {
      if (!element.grade.toString().contains("F")) {
        var key = keys.map((k) => _getValue(element, k)).join('');

        if (!groups.containsKey(key)) {
          groups[key] = [];
        }

        temp = groups[key]!;

        temp.add(element);

        groups[key] = temp;
      }
    }

    groups.forEach((key, value) {
      value.sort((a, b) => a.courseNo!.compareTo(b.courseNo!));
    });

    // var sortedMap = LinkedHashMap<String, List<String>>.fromEntries(
    //     groups.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));

    // sortedMap.forEach((key, value) {
    //   value.sort((a, b) => a.compareTo(b));
    // });

    return Map.from(groups);
  }

  Map<String, int> sumCreditPass(List<GRADEDATA> data) {
    Map<String, int> summary = {'PASS': 0, 'NOT_PASS': 0, 'ALL': 0};
    int pass = 0;
    int notPass = 0;

    if (data.isNotEmpty) {
      for (var element in data) {
        if (element.grade != "S" && element.grade != "S*") {
          pass += element.credit!;
        } else {
          notPass += element.credit!;
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
      List<GRADEDATA> data, List<String> keys) {
    int temp = 0;
    int count = 0;
    var groups = LinkedHashMap<String, Map<String, int>>();

    if (data.isNotEmpty) {
      for (var element in data) {
        //print(element);
        var key = keys.map((k) => _getValue(element, k)).join('/');

        if (!groups.containsKey(key)) {
          groups[key] = {'credit_sum': 0, 'count': 0};
        }

        temp = groups[key]!['credit_sum']!;
        count = groups[key]!['count']!;

        if (element.grade != "S" && element.grade != "S*") {
          temp += element.credit!;
        }

        count += 1;

        // temp += element.credit!;
        // count += 1;

        groups[key]!['credit_sum'] = temp;
        groups[key]!['count'] = count;
      }
    }

    return groups;
  }

  Map<String, List<String>> groupListSortByValues(
      List<GRADEDATA> data, List<String> keys) {
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
      List<GRADEDATA> data, List<String> keys) {
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

  List<MasterGradeListData> groupMealsList(Map<String, Map<String, int>> data) {
    List<MasterGradeListData> tabIconsList = <MasterGradeListData>[];
    int i = 0;
    String startColor = '#19196b';
    String endColor = '#19196b';
    String imagePath = 'assets/fitness_app/breakfast.png';

    for (var entry in data.entries) {
      switch (i) {
        case 0:
          {
            imagePath = 'assets/fitness_app/breakfast.png';
            startColor = '#19196b';
            endColor = '#19196b';
          }
          break;
        case 1:
          {
            imagePath = 'assets/fitness_app/lunch.png';
            startColor = '#e6c543';
            endColor = '#e6c543';
          }
          break;
        case 2:
          {
            imagePath = 'assets/fitness_app/snack.png';
            startColor = '#19196b';
            endColor = '#19196b';
          }
          break;
        case 3:
          {
            imagePath = 'assets/fitness_app/dinner.png';
            startColor = '#e6c543';
            endColor = '#e6c543';
          }
          break;
        case 4:
          {
            imagePath = 'assets/fitness_app/breakfast.png';
            startColor = '#19196b';
            endColor = '#19196b';
            i = 0;
          }
      }

      tabIconsList.add(MasterGradeListData(
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

  dynamic _getValue(GRADEDATA element, String key) {
    switch (key) {
      case 'year':
        return element.year;
      case 'semester':
        return element.semester;
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

  void summary(List<GRADEDATA> data) {
    Map<String, int> gradeCounts = {};
    Map<String, int> creditSumByGrade = {};

    for (GRADEDATA record in data) {
      String grade = record.grade!;
      int credit = record.credit!;

      // Count the occurrences of each "grade"
      gradeCounts.update(grade, (value) => value + 1, ifAbsent: () => 1);

      // Sum the "credit" for each "grade"
      creditSumByGrade.update(grade, (value) => value + credit,
          ifAbsent: () => credit);
    }

    List<String> grades = gradeCounts.keys.toList();
    List<int> counts = gradeCounts.values.toList();

    _counts = counts;
    _grades = grades;
    _ticks = ticksArray(counts);
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
