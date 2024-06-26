import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/model/insurance.dart';
import 'package:th.ac.ru.uSmart/services/insuranceservice.dart';
import 'package:th.ac.ru.uSmart/store/insurance.dart';

class InsuranceProvider extends ChangeNotifier {
  final InsuranceService _service;

  InsuranceProvider({required InsuranceService service}) : _service = service;
  bool isLoading = false;

  Insurance _insurance = Insurance();
  Insurance get insurance => _insurance;

  String _insuranceerror = '';
  String get insuranceerror => _insuranceerror;

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future<void> getInsuracneAll() async {
    //insuranceRegister insuranceregister = await insuranceRegisterStorage.getRegister();
    isLoading = true;

    try {
      final response = await _service.getInsuranceAll();
      //print('save stoage insurance ...');
      await InsuranceStorage.save(response);
      _insuranceerror = '';
      isLoading = false;
    } on Exception catch (e) {
      //print('error');
      _insuranceerror =
          'เกิดข้อผิดพลาด: โปรดเชื่อมต่อ Internet. ${e.toString()}';
    } catch (e) {
      //print('error internal');
      _insuranceerror =
          'เกิดข้อผิดพลาด::: โปรดเชื่อมต่อ Internet. ${e.toString()}';
    }

    _loadInsuranceData();
  }

  Future<void> _loadInsuranceData() async {
    _insurance = await InsuranceStorage.get();

    notifyListeners();
  }
}
