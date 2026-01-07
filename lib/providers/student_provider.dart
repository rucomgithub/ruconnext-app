import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/model/student.dart';
import 'package:th.ac.ru.uSmart/services/studentservice.dart';

class StudentProvider extends ChangeNotifier {
  final _service = StudentService();

  late BuildContext _context;
  set context(BuildContext context) {
    _context = context;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;

  Uint8List _imageData = Uint8List(0);
  Uint8List get imageData => _imageData;

  Student _student = Student();
  Student get student => _student;

  Future<void> getImageProfile() async {
    print('🔄 StudentProvider: Starting getImageProfile()');
    _isLoading = true;
    notifyListeners(); // แจ้งว่าเริ่มโหลดแล้ว

    try {
      _service.context = _context;
      final response = await _service.getImageProfile();
      _imageData = response;
      print('✅ StudentProvider: Image loaded successfully');
    } catch (e) {
      print('❌ StudentProvider Image Error: $e');
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return;
    }

    _isLoading = false;
    notifyListeners(); // แจ้งว่าโหลดเสร็จแล้ว
  }

  Future<void> refreshData() async {
    //print("call refreshData");
    await getImageProfile();
    await getStudent();
  }

  Future<void> getStudent() async {
    print('🔄 StudentProvider: Starting getStudent()');
    _isLoading = true;
    _error = '';
    notifyListeners(); // แจ้งว่าเริ่มโหลดแล้ว

    try {
      final response = await _service.getStudent();
      _student = response;
      print('✅ StudentProvider: Student data loaded - ${_student.namethai}');
    } catch (e) {
      print('❌ StudentProvider Error: $e');
      _isLoading = false;

      // จัดการ error ที่เป็น Exception object
      if (e is Exception) {
        _error = e.toString().replaceAll('Exception: ', '');
      } else {
        _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา: ${e.toString()}';
      }

      notifyListeners();
      return;
    }

    _isLoading = false;
    notifyListeners(); // แจ้งว่าโหลดเสร็จแล้ว
  }
}
