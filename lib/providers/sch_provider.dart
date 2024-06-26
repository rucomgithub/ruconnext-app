import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/model/scholarship.dart';
import 'package:th.ac.ru.uSmart/services/schservice.dart';

import '../store/sch.dart';

class SchProvider extends ChangeNotifier {
  final SchService _service;

  SchProvider({required SchService service}) : _service = service;
  bool isLoading = false;

  Scholarship _scholarshipData = Scholarship();
  Scholarship get scholarshipData => _scholarshipData;

  String _schserror = '';
  String get scherror => _schserror;

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future<void> getScholarShip() async {
    //RotcsRegister rotcsregister = await RotcsRegisterStorage.getRegister();
    isLoading = true;

    try {
      final response = await _service.getScholarShip();
      print('save stoage.......');
      await SchStorage.saveSch(response);
      _loadScholarShipData();
      isLoading = false;
    } on Exception catch (e) {
      print('error');
      _schserror = 'เกิดข้อผิดพลาด ${e.toString()}';
    } catch (e) {
      print('error');
      _schserror = 'เกิดข้อผิดพลาด ${e.toString()}';
      _loadScholarShipData();
    }

    notifyListeners();
  }

  Future<void> _loadScholarShipData() async {
    _scholarshipData = await SchStorage.getSch();
    notifyListeners();
  }
}
