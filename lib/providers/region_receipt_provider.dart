import 'package:th.ac.ru.uSmart/model/enroll_region_model.dart';
import 'package:th.ac.ru.uSmart/model/save_enroll_model.dart';
import 'package:th.ac.ru.uSmart/services/ruregis_service.dart';

import 'package:flutter/material.dart';

class RuregionReceiptProvider extends ChangeNotifier {
  final _ruregisService = RuregisService();
  String _error = '';
  String get error => _error;

  bool isLoading = false;

  var examLocate = '';
  var nearGrad = '';
  var isGrad = false;
  int sumfee = 0;
  int sumIntCredit = 0;

  SaveEnroll _saveenroll = SaveEnroll();
  SaveEnroll get saveenroll => _saveenroll;

  Getenroll _enrollruregion = Getenroll();
  Getenroll get enrollruregion => _enrollruregion;

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
      final response =
          await _ruregisService.getEnrollRegion('6201432835', '1', '2567');
      _enrollruregion = response;
      print('enroll $_enrollruregion');
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
        } else if (nearGrad == '0') {
          isGrad = false;
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
}
