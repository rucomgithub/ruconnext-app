import 'package:th.ac.ru.uSmart/model/checkregis_model.dart';
import 'package:th.ac.ru.uSmart/model/location_exam_model.dart';
import 'package:th.ac.ru.uSmart/model/ruregion_mr30_model.dart';
import 'package:th.ac.ru.uSmart/model/ruregis_fee_model.dart';
import 'package:th.ac.ru.uSmart/services/ruregis_service.dart';

import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/store/mr30App.dart';

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

  String filterStr = '';

  String examDup = '';
  String examLocation='';


  bool _isSuccessCalpay = true;
  bool get isSuccessCalpay => _isSuccessCalpay;


  bool _isCourseDup = true;
  bool get isCourseDup => _isCourseDup;

  bool _isCheckLocation = false;
  bool get isCheckLocation => _isCheckLocation;

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

  Future<void> fetchLocationExam() async {
    _isLoadingLocation = true;
    _error = '';
    try {
      final response =
          await _ruregisService.getLocationExam('6299499991', '1', '2567');
      _locationexam = response;
      print('location $_locationexam');
    } on Exception catch (e) {
      _isLoadingLocation = false;
      _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    }
    _isLoadingLocation = false;
    notifyListeners();
  }

  Future<void> getStatusGraduate(value) async {
    _isLoading = true;
    _error = '';
    _statusGrad = value;
    this.courseSame();
    notifyListeners();
  }

    Future<void> getLocationExam(value) async {
    _isLoading = true;
    _error = '';
    examLocation=value;

    if(examLocation==''){
      _isCheckLocation = false;
    }else{
      _isCheckLocation = true;
    }

    notifyListeners();
  }

    Future<void> checkButtonComfirm() async {
    if (_isCheckLocation && _isCourseDup){
      _statusButton = true;
    }else{
       _statusButton = false;
    }
    print(_statusButton);
    notifyListeners();
  }

  void courseSame() async {
    _isLoadingCourse = true;
    _error = '';
    _mr30Apprec = await MR30AppStorage.getMR30App();
    var tmprec = [];
    if (_mr30Apprec != null) {
      int cntCourse = 0;

      _mr30sameruregionrec = _mr30Apprec;
      _mr30Compareruregionrec = _mr30Apprec;

      for (var i = 0; i < this._mr30sameruregionrec.length; i++) {
        var tmpStr = 1;

        for (var p = 0; p < i; p++) {
          // isCourseDup = false;
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
          if (tmprec[i] > maxTmpRec) {
            maxTmpRec = tmprec[i];
          }
        }
        if (_statusGrad == false) {
          //เช็ค neargrad=0

          if (maxTmpRec > 1) {
            _isCourseDup = false; //ปุ่ม disabled
          } else {
            _isCourseDup = true;
          }
        } else if (_statusGrad == true && maxTmpRec > 4) {
          _isCourseDup = false; //ปุ่ม disabled
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
      _isSuccessCalpay = responseCheck.success!;
      print(_isSuccessCalpay);
    } on Exception catch (e) {
    } catch (e) {}

    _isLoadingFee = false;

    notifyListeners();
  }

}
