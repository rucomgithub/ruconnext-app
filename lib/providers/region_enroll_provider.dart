import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:th.ac.ru.uSmart/model/counter_region_model.dart';
import 'package:th.ac.ru.uSmart/model/enroll_region_model.dart';
import 'package:th.ac.ru.uSmart/model/genqr_region_model.dart';

import 'package:th.ac.ru.uSmart/model/save_enroll_model.dart';
import 'package:th.ac.ru.uSmart/services/ruregis_service.dart';

import '../model/ruregis_model.dart';
import '../store/counterAdminRegion.dart';
import '../store/profileApp.dart';

class RegionEnrollProvider extends ChangeNotifier {
  final _ruregisService = RuregisService();

  String _error = '';
  String get error => _error;
  String filterStr = '';
  bool isLoading = false;
  bool isCourseDup = false;
  String examDup = '';
  var examLocate = '';
  var nearGrad = '';
  var isGrad = false;
  int sumfee = 0;
  int sumIntCredit = 0;
  String msgSaveEnroll = '';

  String _msgSaveButtonQR = 'ยืนยันการรับ QR CODE';
  String get msgSaveButtonQR => _msgSaveButtonQR;

  String qrurl = 'REGIS';
  String duedate = '';
  int totalamount = 0;
  SaveEnroll _saveenroll = SaveEnroll();
  SaveEnroll get saveenroll => _saveenroll;

  Getenroll _enrollruregion = Getenroll();
  Getenroll get enrollruregion => _enrollruregion;

  bool _isLoadingConfirm = false;
  bool get isLoadingConfirm => _isLoadingConfirm;

  CounterRegion _counter = CounterRegion();
  CounterRegion get counter => _counter;

  Ruregis _profiles = Ruregis();
  Ruregis get profiles => _profiles;

  Genqr _genqrruregion = Genqr();
  Genqr get genqrruregion => _genqrruregion;

  List<Results> _genqrruregionrec = [];
  List<Results> get genqrruregionrec => _genqrruregionrec;

  List<ReceiptRegionalResults> _receiptRegionalResultsrec = [];
  List<ReceiptRegionalResults> get receiptRegionalResultsrec =>
      _receiptRegionalResultsrec;

  List<ReceiptRu24RegionalResults> _receiptRu24RegionalResultsrec = [];
  List<ReceiptRu24RegionalResults> get receiptRu24RegionalResultsrec =>
      _receiptRu24RegionalResultsrec;

  List<ReceiptDetailRegionalResults> _receiptDetailRegionalResultsrec = [];
  List<ReceiptDetailRegionalResults> get receiptDetailRegionalResultsrec =>
      _receiptDetailRegionalResultsrec;

  Future<void> getEnrollRegionProv(std, sem, year) async {
    isLoading = true;
    _error = '';
    notifyListeners();
    try {
      final response = await _ruregisService.getEnrollRegion(std, sem, year);
      _enrollruregion = response;

      if (_enrollruregion.receiptRu24RegionalResults != null) {
        _receiptRu24RegionalResultsrec =
            _enrollruregion.receiptRu24RegionalResults!;
      }
      double sumCredit = 0;
      int countElements = 0;
      _receiptRu24RegionalResultsrec.forEach((element) {
        sumCredit += element.cREDIT!;
        countElements++;
      });
      sumIntCredit = sumCredit.round();

      if (_enrollruregion.receiptRegionalResults != null) {
        _receiptRegionalResultsrec = _enrollruregion.receiptRegionalResults!;
      }
      _receiptRegionalResultsrec.forEach((element) {
        examLocate = element.eXAMLOCATION!;
      });

      _receiptRegionalResultsrec.forEach((element) {
        nearGrad = element.nEARGRADUATE ?? '0'; // Handling null safety
        if (nearGrad == '1') {
          isGrad = true;
        }
      });
      _receiptRegionalResultsrec.forEach((element) {
        sumfee = element.tOTALAMOUNT!; // Handling null safety
      });
    } on Exception {
      isLoading = false;
      _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getEnrollRegionProvApp() async {
    isLoading = true;
    _error = '';
    notifyListeners();
    try {
      final response = await _ruregisService.getEnrollRegionApp();
      _enrollruregion = response;

      if (_enrollruregion.receiptRu24RegionalResults != null) {
        _receiptRu24RegionalResultsrec =
            _enrollruregion.receiptRu24RegionalResults!;
      }
      double sumCredit = 0;
      int countElements = 0;
      _receiptRu24RegionalResultsrec.forEach((element) {
        sumCredit += element.cREDIT!;
        countElements++;
      });
      sumIntCredit = sumCredit.round();

      if (_enrollruregion.receiptRegionalResults != null) {
        _receiptRegionalResultsrec = _enrollruregion.receiptRegionalResults!;
      }
      _receiptRegionalResultsrec.forEach((element) {
        examLocate = element.eXAMLOCATION!;
      });

      _receiptRegionalResultsrec.forEach((element) {
        nearGrad = element.nEARGRADUATE ?? '0'; // Handling null safety
        if (nearGrad == '1') {
          isGrad = true;
        }
      });
      _receiptRegionalResultsrec.forEach((element) {
        sumfee = element.tOTALAMOUNT!; // Handling null safety
      });
    } on Exception {
      isLoading = false;
      _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> postQR(x) async {
    isLoading = true;

    print(x);
    try {
      final responseSave = await _ruregisService.postQR(x);
      _saveenroll = responseSave;
      if (_saveenroll.success == true) {
        Get.toNamed('/ruregionqrcode');
        msgSaveEnroll = _saveenroll.message.toString();
      } else {
        msgSaveEnroll = _saveenroll.message.toString();
        print(_saveenroll);
      }
    } on Exception {
    } catch (e) {}

    isLoading = false;

    notifyListeners();
  }

  Future<void> postQRApp() async {
    _isLoadingConfirm = true;
    _msgSaveButtonQR = 'กำลังโหลด...';
    notifyListeners();
    try {
      final responseSave = await _ruregisService.postQRApp();
      _saveenroll = responseSave;
      if (_saveenroll.success == true) {
        Get.toNamed('/ruregionAppQR');
        // msgSaveEnroll = _saveenroll.message.toString();
      } else {
        // msgSaveEnroll = _saveenroll.message.toString();
        print(_saveenroll);
      }
    } on Exception {
    } catch (e) {}

    _isLoadingConfirm = false;
    _msgSaveButtonQR = 'ยืนยันการรับ QR CODE';
    notifyListeners();
  }

  Future<void> getQR(stdcode, sem, year, tel) async {
    isLoading = true;

    try {
      final responseSave =
          await _ruregisService.getQRCODE(stdcode, sem, year, tel);
      _genqrruregion = responseSave;
      if (_genqrruregion.results != null) {
        _genqrruregionrec = _genqrruregion.results!;
      }
      _genqrruregionrec.forEach((element) {
        qrurl = element.qRURL!;
        duedate = element.dUEDATE!;
        totalamount = element.tOTALAMOUNT!;
      });
    } on Exception {
    } catch (e) {}

    isLoading = false;

    notifyListeners();
  }

  Future<void> getQRApp() async {
    isLoading = true;
    _profiles = await ProfileAppStorage.getProfileApp();
    _counter = await CounterRegionAppStorage.getCounterRegionApp();

    try {
      final responseSave = await _ruregisService.getQRCODEApp();
      _genqrruregion = responseSave;
      if (_genqrruregion.results != null) {
        _genqrruregionrec = _genqrruregion.results!;
      }
      _genqrruregionrec.forEach((element) {
        qrurl = element.qRURL!;
        duedate = element.dUEDATE!;
        totalamount = element.tOTALAMOUNT!;
      });
    } on Exception {
    } catch (e) {}

    isLoading = false;

    notifyListeners();
  }
}
