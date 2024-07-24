import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/master/models/master_student.dart';
import 'package:th.ac.ru.uSmart/master/services/masterstudentservice.dart';

class MasterProvider extends ChangeNotifier {
  final _service = MasterStudentService();

  late BuildContext _context;
  set context(BuildContext context) {
    _context = context;
  }

  bool isLoading = false;

  String _error = '';
  String get error => _error;

  Uint8List _imageData = Uint8List(0);
  Uint8List get imageData => _imageData;

  MasterStudent _student = MasterStudent();
  MasterStudent get student => _student;

  Future<void> getImageProfile() async {
    isLoading = true;
    _error = '';

    try {
      _service.context = _context;
      final response = await _service.getImageProfile();
      //print(response);
      _imageData = response;
      isLoading = false;
    } catch (e) {
      isLoading = false;
      _error = e.toString();
    }
    notifyListeners();
  }

  Future<void> refreshData() async {
    await getImageProfile();
    await getStudent();
  }

  Future<void> getStudent() async {
    isLoading = true;
    _error = '';

    try {
      final response = await _service.getStudent();
      _student = response;
    } on Exception catch (e) {
      isLoading = false;
      _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    }

    //await _service.asyncName();

    isLoading = false;
    notifyListeners();
  }
}
