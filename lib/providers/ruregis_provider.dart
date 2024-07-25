// import 'dart:convert';

// import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/model/counter_region_model.dart';
import 'package:th.ac.ru.uSmart/model/location_exam_model.dart';
import 'package:th.ac.ru.uSmart/model/message_region_model.dart';
import 'package:th.ac.ru.uSmart/model/region_login_model.dart';
import 'package:th.ac.ru.uSmart/model/ruregion_profile_model.dart';
import 'package:th.ac.ru.uSmart/model/ruregis_model.dart';
import 'package:th.ac.ru.uSmart/model/save_enroll_model.dart';

import 'package:th.ac.ru.uSmart/services/ruregis_service.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/store/counterAdminRegion.dart';
import 'package:th.ac.ru.uSmart/store/profileApp.dart';
import 'package:th.ac.ru.uSmart/store/ruregion_login.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// import '../exceptions/dioexception.dart';

class RuregisProvider extends ChangeNotifier {
  final _ruregisService = RuregisService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

    bool _isLoadingRuregisProfile = false;
  bool get isLoadingRuregisProfile => _isLoadingRuregisProfile;

  // List<Ruregis> _ruregis = [];
  String _error = '';
  String get error => _error;

  bool appClose = false;
  String appCloseMsg = '';

  String msgSaveEnroll = '';
  String msgNotiRegion = '';
  String semester = '';
  String year = '';
  String fiscalyear = '';
  String auth = '';
  String stdcode = '';

  bool ctrlMr30 = true;
  String ctrlMsgMr30 = '';

  bool ctrlQR = true;
  String ctrlMsgQR = '';

  bool ctrlReceipt = true;
  // List<Ruregis> get ruregis => _ruregis;

  CounterRegion _counter = CounterRegion();
  CounterRegion get counter => _counter;

  Ruregis _ruregis = Ruregis();
  Ruregis get ruregis => _ruregis;

  Ruregis _ruregisApp = Ruregis();
  Ruregis get ruregisApp => _ruregisApp;

  Ruregis _ruregionApp = Ruregis();
  Ruregis get ruregionApp => _ruregionApp;

  Loginregion _logindata = Loginregion();
  Loginregion get logindata => _logindata;

  CounterRegion _counterregion = CounterRegion();
  CounterRegion get counterregion => _counterregion;

    CounterRegion _counterregionApp = CounterRegion();
  CounterRegion get counterregionApp => _counterregionApp;

  MessageRegion _messageregion = MessageRegion();
  MessageRegion get messageregion => _messageregion;

  SaveEnroll _saveenroll = SaveEnroll();
  SaveEnroll get saveenroll => _saveenroll;

  Locationexam _locationexam = Locationexam();
  Locationexam get locationexam => _locationexam;

  Ruregionprofile _ruregion = Ruregionprofile();
  Ruregionprofile get ruregion => _ruregion;

  List<Results> _locationexamrec = [];
  List<Results> get locationexamrec => _locationexamrec;

  List<ResultsCounter> _counterregionRec = [];
  List<ResultsCounter> get counterregionRec => _counterregionRec;

  List<ResultsAppControl> _appctrlregionRec = [];
  List<ResultsAppControl> get appctrlregionRec => _appctrlregionRec;

  void doLogin(context, username, password) async {
    _isLoading = true;
    _error = '';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final sres = prefs.getString('regionlogin')!;
    notifyListeners();
    try {
      final response = await _ruregisService.postLogin(username, password);
      _logindata = response;
      _logindata.rec?.forEach((element) {
        stdcode = element.username!;
      });
      // print(_logindata.tf);
      if (_logindata.tf == true) {
        await prefs.setString('regionlogin', jsonEncode(stdcode));
        Get.offNamedUntil('/ruregionhome', (route) => true);
        // Get.offNamedUntil('/', (route) => true);
      } else {
        var snackbar = SnackBar(content: Text('รหัสนศหรือรหัสผ่านไม่ถูกต้อง'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } on Exception catch (e) {
      var snackbar = SnackBar(content: Text('$e'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);

      _isLoading = false;
      _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    }

    //await _service.asyncName();

    _isLoading = false;
    notifyListeners();
  }

  void doLoginRegionApp(context, username, password) async {
    _isLoading = true;
    _error = '';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final sres = prefs.getString('regionlogin')!;
    notifyListeners();
    try {
      final response = await _ruregisService.postLogin(username, password);
      _logindata = response;
      _logindata.rec?.forEach((element) {
        stdcode = element.username!;
      });
      // print(_logindata.tf);
      if (_logindata.tf == true) {
        await prefs.setString('regionApplogin', jsonEncode(stdcode));
        Get.offNamedUntil('/ruregionApphome', (route) => true);
        // Get.offNamedUntil('/', (route) => true);
      } else {
        var snackbar = SnackBar(content: Text('รหัสนศหรือรหัสผ่านไม่ถูกต้อง'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } on Exception catch (e) {
      var snackbar = SnackBar(content: Text('$e'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);

      _isLoading = false;
      _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    }

    //await _service.asyncName();

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> tryLogin() async {
    final preferences = await SharedPreferences.getInstance();

    // chehck onboad from local storage
    var displayedOnboard = preferences.getBool('showOnboard') ?? false;
    if (!displayedOnboard) {
      // directly return false, when onboard never displayed
      return false;
    }

    return false;
  }

  Future<void> fetchProfileRuregis() async {
    _isLoading = true;
    _error = '';
    var stdpref = '';
      RuregionLoginStorage.getProfile();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //  await prefs.setString('regionlogin', 'notoken');
  //   bool displayedOnboard = prefs.getBool('regionlogin') ?? false;
  //  //  bool? isDarkMode = prefs.getBool('regionlogin');
    stdpref = prefs.getString('regionlogin')!;
    stdpref = stdpref.replaceAll('"', '');
    auth = stdpref;
  // // print(isDarkMode);
    if (stdpref != null) {
      stdcode = stdpref;
    }
    notifyListeners();
    
    try {
      final response = await _ruregisService.getProfileRuregion(stdcode);
      _ruregis = response;
    } on Exception catch (e) {
      _isLoading = false;
      _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    }

    //await _service.asyncName();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchProfileAppRuregis() async {
     _isLoadingRuregisProfile = true;
    _error = '';
       print('res fetch');
  
    try {
      final response = await _ruregisService.getProfileRuregis(stdcode);
      _ruregisApp = response;
      print('res fetch');
      _isLoadingRuregisProfile = false;
    } on Exception catch (e) {
      _isLoadingRuregisProfile = false;
      _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    }

    notifyListeners();
  }

    Future<void> fetchProfileAppRuregion() async {
     _isLoadingRuregisProfile = true;
    _error = '';
       print('res fetch1');
  
    try {
      final response = await _ruregisService.getProfileRuregionApp(stdcode);
      _ruregionApp = response;
        await ProfileAppStorage.saveProfileApp(response);
      print('res fetch2 $_ruregionApp');
      _isLoadingRuregisProfile = false;
    } on Exception catch (e) {
      _isLoadingRuregisProfile = false;
      _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    }

    notifyListeners();
  }

  Future<void> fetchLocationExam() async {
    _isLoading = true;
    _error = '';
    try {
      final response =
          await _ruregisService.getLocationExam(stdcode, semester, year);
      _locationexam = response;
    } on Exception catch (e) {
      _isLoading = false;
      _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    }

    //await _service.asyncName();

    _isLoading = false;
    notifyListeners();
  }
  Future<void> getCounterRegionApp() async {
    _isLoading = true;
   notifyListeners();
   print('enter couter');
    try {
      _isLoading = false;
      final response = await _ruregisService.getCounterAdminRegionApp();
      if (response.success == true) {
       _counterregionApp = response;
      } 
    } catch (e) {

      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> fetchCounterRegion() async {
    _isLoading = true;
    _error = '';

    notifyListeners();
    try {
      final response = await _ruregisService.getCounterAdmin(stdcode);
      _counterregion = response;
    } on Exception catch (e) {
      _isLoading = false;
      _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    }
    _counterregion.resultsAppControl?.forEach((element) {
      if (element.aPIID == "6") {
        ctrlMr30 = element.aPISTATUS!;
        ctrlMsgMr30 = element.aPIDES!;
        // print(ctrlMsgMr30);
      }
    });
    _counterregion.resultsAppControl?.forEach((element) {
      if (element.aPIID == "3") {
        appClose = element.aPISTATUS!;
        appCloseMsg = element.aPIDES!;
        // print(appClose);
      }
    });
    _counterregion.resultsAppControl?.forEach((element) {
      if (element.aPIID == "4") {
        print('------------------------${element.aPISTATUS!}');
        ctrlQR = element.aPISTATUS!;
        ctrlMsgQR = element.aPIDES!;
        print('------------------------$ctrlQR');
      }
    });

    _counterregion.resultsCounter?.forEach((element) {
      semester = element.sTUDYSEMESTER!;
      year = element.sTUDYYEAR!;
      fiscalyear = element.fISCALYEAR!;
    });
    //await _service.asyncName();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMessageRegion() async {
    _isLoading = true;
    _error = '';

    notifyListeners();
    try {
      final response =
          await _ruregisService.getMessageRegion(stdcode, semester, year);
      _messageregion = response;
      msgNotiRegion = (_messageregion.messageNoti).toString();
    } on Exception catch (e) {
      _isLoading = false;
      _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    }
    // print('message $_messageregion');
    //await _service.asyncName();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> postEnroll(x) async {
    _isLoading = true;
    // print(x);
    try {
      final responseSave = await _ruregisService.postEnroll(x);
      _saveenroll = responseSave;
      if (_saveenroll.success == true) {
        Get.toNamed('/ruregisconfirm');
        msgSaveEnroll = _saveenroll.message.toString();
      } else {
        msgSaveEnroll = _saveenroll.message.toString();
        // print(_saveenroll);
      }
    } on Exception catch (e) {
    } catch (e) {}

    _isLoading = false;

    notifyListeners();
  }

}
