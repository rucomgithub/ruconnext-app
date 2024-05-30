import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/model/rotcs_extend.dart';
import 'package:th.ac.ru.uSmart/model/rotcs_register.dart';
import 'package:th.ac.ru.uSmart/services/rotcsservice.dart';
import 'package:th.ac.ru.uSmart/store/rotcsextend.dart';
import 'package:th.ac.ru.uSmart/store/rotcsregister.dart';

class RotcsProvider extends ChangeNotifier {
  final RotcsService _service;

  RotcsProvider({required RotcsService service}) : _service = service;
  bool isLoading = false;

  RotcsRegister _rotcsregister = RotcsRegister();
  RotcsRegister get rotcsregister => _rotcsregister;

  RotcsExtend _rotcsextend = RotcsExtend();
  RotcsExtend get rotcsextend => _rotcsextend;

  String _rotcserror = '';
  String get rotcserror => _rotcserror;

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future<void> getAllRegister() async {
    //RotcsRegister rotcsregister = await RotcsRegisterStorage.getRegister();
    isLoading = true;

    try {
      final response = await _service.getRegisterAll();
      print('save stoage.......');
      await RotcsRegisterStorage.saveRegister(response);
      _loadRegisterData();
    } on Exception catch (e) {
      print('error');
      _rotcserror = 'เกิดข้อผิดพลาด ${e.toString()}';
    } catch (e) {
      print('error');
      _rotcserror = 'เกิดข้อผิดพลาด ${e.toString()}';
      _loadRegisterData();
    }

    isLoading = false;

    notifyListeners();
  }

  Future<void> _loadRegisterData() async {
    _rotcsregister = await RotcsRegisterStorage.getRegister();
    notifyListeners();
  }

  Future<void> getAllExtend() async {
    //RotcsRegister rotcsregister = await RotcsRegisterStorage.getRegister();
    isLoading = true;

    try {
      final response = await _service.getExtendAll();
      print('save stoage.......');
      await RotcsExtendStorage.saveExtend(response);
      _loadExtendData();
    } on Exception catch (e) {
      print('error');
      _rotcserror = 'เกิดข้อผิดพลาด ${e.toString()}';
    } catch (e) {
      print('error');
      _rotcserror = 'เกิดข้อผิดพลาด ${e.toString()}';
      _loadExtendData();
    }

    isLoading = false;

    notifyListeners();
  }

  Future<void> _loadExtendData() async {
    _rotcsextend = await RotcsExtendStorage.getExtend();
    notifyListeners();
  }
}
