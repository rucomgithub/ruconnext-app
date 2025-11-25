import 'package:get/get.dart';
import 'package:th.ac.ru.uSmart/model/checkregis_model.dart';
import 'package:th.ac.ru.uSmart/model/location_exam_model.dart';
import 'package:th.ac.ru.uSmart/model/ruregion_mr30_model.dart';
import 'package:th.ac.ru.uSmart/model/ruregis_fee_model.dart';
import 'package:th.ac.ru.uSmart/model/save_enroll_model.dart';
import 'package:th.ac.ru.uSmart/services/ruregis_service.dart';
import 'package:th.ac.ru.uSmart/store/feeApp.dart';
import 'package:th.ac.ru.uSmart/store/mr30App.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RuregionCheckCartProvider extends ChangeNotifier {
  final _ruregisService = RuregisService();

  Locationexam _locationexam = Locationexam();
  Locationexam get locationexam => _locationexam;

  List<Results> _locationexamrec = [];
  List<Results> get locationexamrec => _locationexamrec;

  List<ResultsMr30> _mr30Apprec = [];
  List<ResultsMr30> get mr30Apprec => _mr30Apprec;

  String _error = '';
  String get error => _error;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingCourse = false;
  bool get isLoadingCourse => _isLoadingCourse;

  bool _isLoadingFee = false;
  bool get isLoadingFee => _isLoadingFee;

  bool _isLoadingLocation = false;
  bool get isLoadingLocation => _isLoadingLocation;

  bool _isLoadingConfirm = false;
  bool get isLoadingConfirm => _isLoadingConfirm;

  String _msgSaveButtonRegis = 'ยืนยันการลงทะเบียน';
  String get msgSaveButtonRegis => _msgSaveButtonRegis;

  String filterStr = '';

  String examDup = '';
  String examLocation = '';

  bool _isCheckCredit = true;
  bool get isCheckCredit => _isCheckCredit;

  bool _isSuccessCalpay = true;
  bool get isSuccessCalpay => _isSuccessCalpay;

  bool _isCourseDup = true;
  bool get isCourseDup => _isCourseDup;

  bool _isCheckLocation = false;
  bool get isCheckLocation => _isCheckLocation;

  bool _isCheckConfirm = false;
  bool get isCheckConfirm => _isCheckConfirm;

  bool _statusGrad = false;
  bool get statusGrad => _statusGrad;

  bool _statusButton = false;
  bool get statusButton => _statusButton;

  List<ResultsMr30> _mr30sameruregionrec = [];
  List<ResultsMr30> get mr30sameruregionrec => _mr30sameruregionrec;

  Summary_reg _summary = Summary_reg();
  Summary_reg get summary => _summary;

  List<ResultsMr30> _mr30Compareruregionrec = [];
  List<ResultsMr30> get mr30Compareruregionrec => _mr30Compareruregionrec;

  SaveEnroll _saveenroll = SaveEnroll();
  SaveEnroll get saveenroll => _saveenroll;

  String _msgcheckcredit = '';
  String get msgcheckcredit => _msgcheckcredit;

  String _msgDup = '';
  String get msgDup => _msgDup;

  // 🔹 โหลดค่าจาก SharedPreferences ตอนเริ่มต้น
 Future<void> loadSavedStatus() async {
  final prefs = await SharedPreferences.getInstance();
  
  _statusGrad = prefs.getBool('statusGrad') ?? false;
  _isCheckLocation = prefs.getBool('isCheckLocation') ?? false;
  examLocation = prefs.getString('examLocation') ?? '';

  // ✅ ถ้า examLocation เป็น null หรือว่าง ให้ _isCheckLocation = false
  if (examLocation.isEmpty) {
    _isCheckLocation = false;
  }

  print('หน้า provider $examLocation and $_isCheckLocation and $_statusGrad');
  notifyListeners();
}


  // 🔹 ดึงข้อมูลศูนย์สอบ
  Future<void> fetchLocationExam() async {
    _isLoadingLocation = true;
    _error = '';
    try {
      final response = await _ruregisService.getLocationExamApp();
      _locationexam = response;
    } catch (e) {
      _error = 'เกิดข้อผิดพลาดในการดึงข้อมูลศูนย์สอบ';
    }
    print('Fetchfromlocation $_locationexam');
    _isLoadingLocation = false;
    notifyListeners();
  }

  // 🔹 เปลี่ยนสถานะขอจบ + บันทึกไว้
  Future<void> getStatusGraduate(bool value) async {
    _isLoading = true;
    _statusGrad = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('statusGrad', value);
    _isLoading = false;
    this.courseSame();
    notifyListeners();
  }

  // 🔹 เปลี่ยนศูนย์สอบ + บันทึกไว้
  Future<void> getLocationExam(String value) async {
   
    _isLoading = true;
    examLocation = value;
    _isCheckLocation = value.isNotEmpty;
    print('เลือกศูนย์สอบ: $_isCheckLocation');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('examLocation', value);
    await prefs.setBool('isCheckLocation', _isCheckLocation);

    _isLoading = false;
    this.courseSame();
    notifyListeners();
  }
// // 🔹 เปลี่ยนศูนย์สอบ + บันทึกไว้ (บันทึกเฉพาะเมื่อค่ามีการเปลี่ยนแปลง)
// Future<void> getLocationExam(String value) async {
//   _isLoading = true;
//   final prefs = await SharedPreferences.getInstance();

//   // ดึงค่าปัจจุบันจาก SharedPreferences
//   final currentExamLocation = prefs.getString('examLocation');
//   final currentIsCheckLocation = prefs.getBool('isCheckLocation');

//   // ตรวจว่าค่าที่เลือกใหม่แตกต่างจากของเดิมหรือไม่
//   if (currentExamLocation != value || currentIsCheckLocation != (value.isNotEmpty)) {
//     examLocation = value;
//     _isCheckLocation = value.isNotEmpty;
//     print('เลือกศูนย์สอบใหม่: $examLocation ($_isCheckLocation)');

//     await prefs.setString('examLocation', value);
//     await prefs.setBool('isCheckLocation', _isCheckLocation);
//   } else {
//     print('ค่าเดิมยังเหมือนเดิม ไม่ต้อง set ใหม่');
//     examLocation = currentExamLocation ?? '';
//     _isCheckLocation = currentIsCheckLocation ?? false;
//   }

//   _isLoading = false;
//   this.courseSame();
//   notifyListeners();
// }

  // 🔹 ตรวจปุ่มยืนยัน
  Future<void> checkButtonComfirm() async {
    if (_isCheckLocation && _isCourseDup) {
      _statusButton = true;
    } else {
      _statusButton = false;
    }
    notifyListeners();
  }

  void courseSame() async {
    _isLoadingCourse = true;
    _error = '';
    _msgDup = '';
    _mr30Apprec = await MR30AppStorage.getMR30App();
    var tmprec = [];

    if (_mr30Apprec.isNotEmpty) {
      int cntCourse = 0;
      _mr30sameruregionrec = _mr30Apprec;
      _mr30Compareruregionrec = _mr30Apprec;

      for (var i = 0; i < _mr30sameruregionrec.length; i++) {
        var tmpStr = 1;
        for (var p = 0; p < i; p++) {
          if (_mr30sameruregionrec[i].eXAMDATESHOT ==
              _mr30sameruregionrec[p].eXAMDATESHOT) {
            cntCourse++;
            tmpStr++;
            _mr30sameruregionrec[p].cOURSEDUP = '*';
            _mr30sameruregionrec[i].cOURSEDUP = '*';
          }
        }

        tmprec.addAll({tmpStr});
        var maxTmpRec = tmprec[0];
        for (var i = 1; i < tmprec.length; i++) {
          if (tmprec[i] > maxTmpRec) maxTmpRec = tmprec[i];
        }

        if (_statusGrad == false) {
          if (maxTmpRec > 1) {
            _isCourseDup = false;
            _msgDup = 'มีวิชาสอบซ้ำซ้อน กรุณาเลือกวิชาใหม่หรือขอจบ';
          } else {
            _isCourseDup = true;
          }
        } else if (_statusGrad == true && maxTmpRec > 4) {
          _isCourseDup = false;
          _msgDup = 'มีวิชาสอบซ้ำซ้อน กรุณาเลือกวิชาใหม่หรือขอจบ';
        } else {
          _isCourseDup = true;
        }
      }
    }

    _isLoadingCourse = false;
    notifyListeners();
  }

  Future<void> getCalPayRegionApp() async {
    _isLoadingFee = true;
    try {
      final responseCheck = await _ruregisService.postCalPayRegionApp();
      _summary = responseCheck;
      _isSuccessCalpay = responseCheck.success ?? false;
      await FeeRuregionAppStorage.saveFeeRegionApp(responseCheck);
      this.courseSame();
    } catch (e) {}
    _isLoadingFee = false;
    notifyListeners();
  }

  Future<void> postEnrollApp() async {
    _isLoadingConfirm = true;
    _msgSaveButtonRegis = 'กำลังโหลด...';
    notifyListeners();
    try {
      final responseSave =
          await _ruregisService.postEnrollApp(_statusGrad, examLocation);
      _saveenroll = responseSave;
      if (_saveenroll.success == true) {
        Get.toNamed('/ruregionAppreceipt');
      }
    } catch (e) {}
    _isLoadingConfirm = false;
    _msgSaveButtonRegis = 'ยืนยันการลงทะเบียน';
    notifyListeners();
  }
}
