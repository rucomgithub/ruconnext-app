import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:th.ac.ru.uSmart/store/profile.dart';
import 'package:th.ac.ru.uSmart/model/yearsemester.dart';
import 'package:th.ac.ru.uSmart/store/yearsemester.dart';
import 'package:th.ac.ru.uSmart/utils/custom_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../model/mr30_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/mr30year_model.dart';
import '../model/profile.dart';
import '../services/mr30service.dart';
// import '../utils/noti.dart';

class RUREGISMR30Provider extends ChangeNotifier {
  late BuildContext _context;

  set context(BuildContext context) {
    _context = context;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final _service = MR30Service();
  bool isLoading = false;
  String filterStr = '';

  YearSemester _yearsemester = YearSemester(year: "", semester: "");
  YearSemester get yearsemester => _yearsemester;
  String _erroryearsemester = '';
  String get erroryearsemester => _erroryearsemester;

  MR30YEAR _mr30year = MR30YEAR();
  MR30YEAR get mr30year => _mr30year;
  String _errormr30year = '';
  String get errormr30year => _errormr30year;

  MR30 _mr30 = MR30();
  MR30 get mr30 => _mr30;
  String _errormr30 = '';
  String get errormr30 => _errormr30;

  MR30 _mr30ruregis = MR30();
  MR30 get mr30ruregis => _mr30ruregis;
  String _errormr30ruregis = '';
  String get errormr30ruregis => _errormr30ruregis;

  MR30 _mr30filter = MR30();
  MR30 get mr30filter => _mr30filter;
  String _errormr30filter = '';
  String get errormr30filter => _errormr30filter;

  String _stringDup = '';
  String get stringDup => _stringDup;

  List<RECORD> _studylist = [];
  List<RECORD> get studylist => _studylist;
  String _errorstudylist = '';
  String get errorstudylist => _errorstudylist;

  List<RECORD> _mr30record = [];
  List<RECORD> get mr30record => _mr30record;
  String _errormr30record = '';
  String get errormr30record => _errormr30record;

  List<RECORD> _mr30ruregisrecord = [];
  List<RECORD> get mr30ruregisrecord => _mr30ruregisrecord;
  String _errormr30ruregisrecord = '';
  String get errormr30ruregisrecord => _errormr30ruregisrecord;

  List<RECORD> _havetoday = [];
  List<RECORD> get havetoday => _havetoday;
  String _errorhavetoday = '';
  String get errorhavetoday => _errorhavetoday;

  List<RECORD> _havetodayRegister = [];
  List<RECORD> get havetodayRegister => _havetodayRegister;
  String _errorhavetodayRegister = '';
  String get errorhavetodayRegister => _errorhavetodayRegister;

  List<RECORD> _havetodayNow = [];
  List<RECORD> get havetodayNow => _havetodayNow;
  String _errorhavetodayNow = '';
  String get errorhavetodayNow => _errorhavetodayNow;

  void getSchedule() async {
    //print('call getSchedule');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _errormr30record = '';
    isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getScheduleLatest();
      //print(response);
      MR30 schedule = response;
      _mr30.rECORD?.forEach((element) {
        var contain = _mr30record.where((e) => element.id == e.id);
        if (contain.isNotEmpty) {
          element.favorite = true;
        } else {
          element.favorite = false;
        }
      });
      prefs.setString('mr30register', jsonEncode(schedule.rECORD));
      isLoading = false;
    } catch (e) {
      // print(e.toString());
      isLoading = false;
      _errormr30record = e.toString();
    }

    notifyListeners();
  }

  void getYearSemesterLatest() async {
    isLoading = true;
    _erroryearsemester = '';

    try {
      var response = await _service.getYearSemesterLatest();
      _yearsemester = response;
      await YearSemtesterStorage.saveYearSemester(_yearsemester);
    } catch (e) {
      _erroryearsemester = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  void getAllMR30() async {
    print('get all');
    isLoading = true;
    _errormr30 = '';
    try {
      var response = await _service.getAllMR30();
      _mr30 = response;

      _mr30.rECORD?.forEach((element) {
        var contain = _mr30record.where((e) => element.id == e.id);
        if (contain.isNotEmpty) {
          element.favorite = true;
        } else {
          element.favorite = false;
        }
      });

      _mr30.rECORD = _mr30filter.rECORD = response.rECORD;
      filterMr30(filterStr);
      isLoading = false;
    } catch (e) {
      print(e);
      isLoading = false;
      _errormr30 = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  void getAllMR30RUREGIS() async {
    isLoading = true;
    _errormr30ruregis = '';
    try {
      var response = await _service.getAllMR30();
      _mr30ruregis = response;

      _mr30ruregis.rECORD?.forEach((element) {
        var contain = _mr30record.where((e) => element.id == e.id);
        if (contain.isNotEmpty) {
          element.favorite = true;
        } else {
          element.favorite = false;
        }
      });

      _mr30ruregis.rECORD = _mr30filter.rECORD = response.rECORD;
      filterMr30(filterStr);
      isLoading = false;
    } catch (e) {
      //print(e);
      isLoading = false;
      _errormr30ruregis = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  void getAllMR30List(String year, semester) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _errormr30 = '';
    isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getAllMR30List(year, semester);
      _mr30 = response;

      _mr30.rECORD?.forEach((element) {
        var contain = _mr30record.where((e) => element.id == e.id);
        if (contain.isNotEmpty) {
          element.favorite = true;
        } else {
          element.favorite = false;
        }
      });

      _mr30.rECORD = _mr30filter.rECORD = response.rECORD;

      filterMr30(filterStr);
      isLoading = false;
    } catch (e) {
      _errormr30 = e.toString();
      isLoading = false;
    }
    isLoading = false;
    notifyListeners();
  }

  void getAllMR30Year() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('mr30year') == null) {
      MR30YEAR year = MR30YEAR();
      await prefs.setString('mr30year', jsonEncode(year));
    }

    isLoading = true;
    _errormr30year = '';
    notifyListeners();

    try {
      final response = await _service.getAllMR30Year();
      _mr30year = response;
      await prefs.setString('mr30year', jsonEncode(_mr30year));
      isLoading = false;
    } on Exception catch (e) {
      isLoading = false;
      _errormr30year = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  void filterMr30(String filter) {
    filterStr = filter;
    _mr30filter.rECORD = _mr30.rECORD
        ?.where((RECORD m) =>
            m.courseNo!.toUpperCase().contains(filterStr.toUpperCase()))
        .toList();

    notifyListeners();
  }

  void addMR30(RECORD record) async {
    _stringDup = '';
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_mr30record.isNotEmpty) {
      //print('not null $_mr30record');
      final String mr30 = prefs.getString('mr30')!;
      _mr30record = RECORD.decode(mr30);
      var dup = _mr30record.where((RECORD r) => r.id!.contains(record.id!));
      if (dup.isNotEmpty) {
        _stringDup = 'เลือกซ้ำ';
        _mr30record.removeWhere((item) => item.id == record.id);
      } else {
        _stringDup = 'บันทึกแล้ว';
        _mr30record.add(record);
      }
    } else {
      _stringDup = 'บันทึกแล้ว';
      //_mr30record.add(record);
      _mr30record.add(record);
    }

    _mr30.rECORD?.forEach((element) {
      var contain = _mr30record.where((e) => element.id == e.id);
      if (contain.isNotEmpty) {
        element.favorite = true;
      } else {
        element.favorite = false;
      }
    });

    getHaveToday();

    getStudyList();

    await prefs.setString('mr30', jsonEncode(_mr30record));

    notifyListeners();
  }

  void addRuregisMR30(RECORD record) async {
    _stringDup = '';
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_mr30ruregisrecord.isNotEmpty) {
      print('not null $_mr30ruregisrecord');
      final String mr30 = prefs.getString('mr30ruregis')!;
      _mr30ruregisrecord = RECORD.decode(mr30);
      var dup =
          _mr30ruregisrecord.where((RECORD r) => r.id!.contains(record.id!));
      if (dup.isNotEmpty) {
        _stringDup = 'เลือกซ้ำ';
        _mr30ruregisrecord.removeWhere((item) => item.id == record.id);
      } else {
        _stringDup = 'บันทึกแล้ว';
        _mr30ruregisrecord.add(record);
      }
    } else {
      _stringDup = 'บันทึกแล้ว';
      //_mr30record.add(record);
      _mr30ruregisrecord.add(record);
    }

    _mr30ruregis.rECORD?.forEach((element) {
      var contain = _mr30ruregisrecord.where((e) => element.id == e.id);
      if (contain.isNotEmpty) {
        element.favorite = true;
      } else {
        element.favorite = false;
      }
    });

    getStudyList();
    await prefs.setString('mr30ruregis', jsonEncode(_mr30ruregisrecord));

    notifyListeners();
  }

  void getRecordMr30() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('mr30') == null) {
      List<RECORD> listrecord = [];
      await prefs.setString('mr30', jsonEncode(listrecord));
      notifyListeners();
    }

    final String? mr30 = prefs.getString('mr30');
    _mr30record = RECORD.decode(mr30!);
    notifyListeners();
  }

  void getRuregisRecordMr30() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('mr30ruregis') == null) {
      List<RECORD> listrecord = [];
      await prefs.setString('mr30ruregis', jsonEncode(listrecord));
      notifyListeners();
    }

    final String? mr30 = prefs.getString('mr30ruregis');
    _mr30ruregisrecord = RECORD.decode(mr30!);
    notifyListeners();
  }

  Future<List<RECORD>> getListFromPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<RECORD> list = [];
    final stringValue = prefs.getString(key);
    //print('$key : ${prefs.getString('mr30')}');
    if (stringValue != null) {
      return RECORD.decode(stringValue);
    }

    return list;
  }

  void getStudyList() async {
    List<RECORD> listmr30 = await getListFromPreferences('mr30');

    _studylist = listmr30;

    Profile profile = await ProfileStorage.getProfile();
    if (profile.accessToken != null || profile.accessToken != "") {
      List<RECORD> listmr30register =
          await getListFromPreferences('mr30register');

      listmr30.forEach((element) => element.register = false);
      listmr30register.forEach((element) => element.register = true);
      _studylist.addAll(listmr30register);
    }

    notifyListeners();
  }

  void getRuregisStudyList() async {
    List<RECORD> listmr30 = await getListFromPreferences('mr30ruregis');

    _studylist = listmr30;

    Profile profile = await ProfileStorage.getProfile();
    if (profile.accessToken != null || profile.accessToken != "") {
      List<RECORD> listmr30register =
          await getListFromPreferences('mr30register');

      listmr30.forEach((element) => element.register = false);
      listmr30register.forEach((element) => element.register = true);
      _studylist.addAll(listmr30register);
    }

    notifyListeners();
  }

  String dayNormal() {
    final dayNow = DateFormat.E().format(DateTime.now());
    var day = "";

    switch (dayNow) {
      case 'Mon': // mon{}
        day = "M";
        break;
      case 'Tue': // tue
        day = "TU";
        break;
      case "Wed": // wed
        day = "W";
        break;
      case "Thu": // thir
        day = "TH";
        break;
      case "Fri": // fri
        day = "F";
        break;
      case "Sat": // sat
        day = "S";
        break;
      case "Sun": // sun
        day = "SU";
        break;
      default:
        day = "";
    }
    return day;
  }

  String daySummer() {
    final dayNow = DateFormat.E().format(DateTime.now());
    String day = "";

    switch (dayNow) {
      case 'Mon': // mon{}
        day = "MWF";
        break;
      case 'Tue': // tue
        day = "TTS";
        break;
      case "Wed": // wed
        day = "MWF";
        break;
      case "Thu": // thir
        day = "TTS";
        break;
      case "Fri": // fri
        day = "MWF";
        break;
      case "Sat": // sat
        day = "TTS";
        break;
      case "Sun": // sun
        day = "SU";
        break;
      default:
        day = "";
    }
    return day;
  }

  void getHaveTodayList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mr30 = prefs.getString('mr30');

    YearSemester yearSemester = await YearSemtesterStorage.getYearSemester();

    List<RECORD> listrecord = [];
    if (mr30 != "null") {
      listrecord = RECORD.decode(mr30!);
      String dayName = dayNormal() + '|' + daySummer();
      _havetoday = filterList(
          listrecord, dayName, yearSemester.year, yearSemester.semester);
      _havetoday.forEach((element) => element.register = false);
    }

    final mr30register = prefs.getString('mr30register');
    List<RECORD> listmr30register = [];
    if (mr30register != "null") {
      listmr30register = RECORD.decode(mr30register!);
      String dayName = dayNormal() + '|' + daySummer();
      _havetodayRegister = filterList(
          listmr30register, dayName, yearSemester.year, yearSemester.semester);
      _havetodayRegister.forEach((element) => element.register = true);
    }

    _havetoday.addAll(_havetodayRegister);
    _havetoday.sort((a, b) {
      int compareResult =
          b.register.toString().compareTo(a.register.toString());
      if (compareResult != 0) {
        return compareResult;
      } else {
        return a.timePeriod.toString().compareTo(b.timePeriod.toString());
      }
    });
    notifyListeners();
  }

  void getHaveToday() async {
    //print('getHaveToday');
    initializeDateFormatting('th_TH', null);

    YearSemester yearSemester = await YearSemtesterStorage.getYearSemester();

    List<RECORD> listmr30 = await getListFromPreferences('mr30');
    List<RECORD> listmr30register =
        await getListFromPreferences('mr30register');

    String dayName = dayNormal() + '|' + daySummer();

    _havetoday =
        filterList(listmr30, dayName, yearSemester.year, yearSemester.semester);
    _havetoday.forEach((element) => element.register = false);

    _havetodayRegister = filterList(
        listmr30register, dayName, yearSemester.year, yearSemester.semester);
    _havetodayRegister.forEach((element) => element.register = true);
    _havetoday.addAll(_havetodayRegister);

    String checktime = "0:10";
    List<RECORD> noti = _havetoday
        .where((RECORD r) => checkTimeStudy(r.timePeriod.toString(), checktime))
        .toList();

    // if (noti.isNotEmpty) {
    //   String courseNos = noti.map((record) => record.courseNo).join(', ');
    //   //Noti.showTodayNotification(
    //       title: 'notification',
    //       body: 'อีก $checktime จะเริ่มเรียนวิชา $courseNos',
    //       fln: flutterLocalNotificationsPlugin);
    // }

    _havetoday.sort((a, b) {
      int compareResult =
          b.register.toString().compareTo(a.register.toString());
      if (compareResult != 0) {
        return compareResult;
      } else {
        return a.timePeriod.toString().compareTo(b.timePeriod.toString());
      }
    });

    notifyListeners();
  }

  List<RECORD> filterList(
      List<RECORD> records, String dayName, year, semester) {
    return records
        .where((RECORD r) =>
            (r.courseYear.toString().contains(year.toString()) &&
                r.courseSemester.toString().contains(semester.toString())) &&
            (r.dayNameS.toString().contains(dayNormal()) ||
                r.dayNameS.toString().contains(daySummer())))
        .toList();
  }

  bool checkTimeStudy(String timePeriod, checktime) {
    //print('notitimestudy ${timePeriod.toString()}');
    bool containsDash = timePeriod.contains("-");
    if (containsDash == false) {
      return false;
    }
    final period = timePeriod.split('-');
    var format = DateFormat("HH:mm");
    var timenow = DateFormat(DateFormat.HOUR24_MINUTE).format(DateTime.now());
    int timeCurrent = int.parse(timenow.replaceAll(":", ""));
    int timeStart = int.parse(period[0]);
    String strStarttime = "";
    String strtime = "";

    if (timeCurrent < timeStart) {
      strStarttime =
          '${(period[0]).toString().substring(0, 2)}:${(period[0]).toString().substring(2, 4)}';
      strtime = format
          .parse(strStarttime)
          .difference(format.parse(timenow))
          .toString()
          .substring(0, 4);
      if (strtime.toString().contains(checktime)) {
        return true;
      }
    }

    return false;
  }

  void clearMR30Pref(courseid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _mr30record.removeWhere((item) => item.id == courseid);
    await prefs.setString('mr30', jsonEncode(_mr30record));
    notifyListeners();
  }

  void clearAllMR30Pref() async {
    _stringDup = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mr30', jsonEncode([]));
    _mr30record = [];
    //print(_mr30record.length);
    _mr30.rECORD?.forEach((element) {
      var contain = _mr30record.where((e) => element.id == e.id);
      if (contain.isNotEmpty) {
        element.favorite = true;
      } else {
        element.favorite = false;
      }
    });
    notifyListeners();
  }

  void filterTimeCourseStudy() async {
    initializeDateFormatting('th_TH', null);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<RECORD> listmr30 = [];
    final mr30 = prefs.getString('mr30');
    if (mr30 != null) {
      listmr30 = RECORD.decode(mr30);
    } else {
      listmr30 = [];
    }
    // String mr30 = prefs.getString('mr30') ?? '';
    // List<RECORD> listmr30 = RECORD.decode(mr30);
    List<RECORD> listmr30register = [];
    final mr30register = prefs.getString('mr30register');
    if (mr30register != null) {
      listmr30register = RECORD.decode(mr30register);
      //print('mr30register: $mr30register\n');
    } else {
      listmr30register = [];
    }

    final day1 = DateFormat.E().format(DateTime.now());
    var firstDayOfWeek = "";
    var DayOfWeek = "";

    switch (day1) {
      case 'Mon': // mon{}
        firstDayOfWeek = "M";
        DayOfWeek = "MWF";
        break;
      case 'Tue': // tue
        firstDayOfWeek = "TU";
        DayOfWeek = "TTS";
        break;
      case "Wed": // wed
        firstDayOfWeek = "W";
        DayOfWeek = "MWF";
        break;
      case "Thu": // thir
        firstDayOfWeek = "TH";
        DayOfWeek = "TTS";
        break;
      case "Fri": // fri
        firstDayOfWeek = "F";
        DayOfWeek = "MWF";
        break;
      case "Sat": // sat
        firstDayOfWeek = "S";
        DayOfWeek = "TTS";
        break;
      case "Sun": // sun
        firstDayOfWeek = "SU";
        break;
      default:
        firstDayOfWeek = "";
    }

    _havetodayNow = listmr30
        .where((RECORD r) =>
            !StringTimeStudy(r.timePeriod.toString())
                .contains('หมดเวลาเรียน') &&
            (r.dayNameS!.toString().contains(firstDayOfWeek) ||
                r.dayNameS!.toString().contains(DayOfWeek)))
        .toList();

    _havetodayNow.forEach((element) {
      element.register = false;
    });
    _havetodayRegister = listmr30register
        .where((RECORD r) =>
            !StringTimeStudy(r.timePeriod.toString())
                .contains('หมดเวลาเรียน') &&
            (r.dayNameS!.toString().contains(firstDayOfWeek) ||
                r.dayNameS!.toString().contains(DayOfWeek)))
        .toList();
    _havetodayRegister.forEach((element) {
      element.register = true;
    });

    _havetodayNow.addAll(_havetodayRegister);
    _havetodayNow.sort((a, b) {
      int compareResult =
          b.register.toString().compareTo(a.register.toString());
      if (compareResult != 0) {
        return compareResult; // sort by name ascending
      } else {
        return a.timePeriod
            .toString()
            .compareTo(b.timePeriod.toString()); // sort by age descending
      }
    });
    // print('filter ${_havetodayNow.length}');
    notifyListeners();
  }
}
