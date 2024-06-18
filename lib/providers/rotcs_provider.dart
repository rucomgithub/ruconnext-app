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
      print('save stoage rotcs register ...');
      await RotcsRegisterStorage.saveRegister(response);
      isLoading = false;
    } on Exception catch (e) {
      _rotcserror = 'เกิดข้อผิดพลาด ${e.toString()}';
      print('error $_rotcserror');
    } catch (e) {
      _rotcserror = 'เกิดข้อผิดพลาด ${e.toString()}';
      print('error $_rotcserror');
    }

    _loadRegisterData();
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
      isLoading = false;
    } on Exception catch (e) {
      _rotcserror = 'เกิดข้อผิดพลาด ${e.toString()}';
      print('error $_rotcserror');
    } catch (e) {
      _rotcserror = 'เกิดข้อผิดพลาด ${e.toString()}';
      print('error $_rotcserror');
    }

    _loadExtendData();
  }

  Future<void> _loadExtendData() async {
    _rotcsextend = await RotcsExtendStorage.getExtend();
    notifyListeners();
  }
}
