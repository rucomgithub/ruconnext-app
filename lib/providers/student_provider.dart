import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/model/mr30_catalog.dart';
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
    //print("call getImageProfile");
    _isLoading = true;
    try {
      _service.context = _context;
      final response = await _service.getImageProfile();
      //print(response);
      _imageData = response;
      // var snackbar = SnackBar(content: Text('Load image success.'));
      // ScaffoldMessenger.of(_context).showSnackBar(snackbar);
    } catch (e) {
      //print("Error $e");

      // var snackbar = SnackBar(content: Text('Error: Load Image Profile. ${e.toString()}'));
      // ScaffoldMessenger.of(_context).showSnackBar(snackbar);
      _error = e.toString();
      // notifyListeners();
    }
    _isLoading = false;
    //notifyListeners();
  }

  Future<void> refreshData() async {
    //print("call refreshData");
    await getImageProfile();
    await getStudent();
  }

  Future<void> getStudent() async {
    _isLoading = true;
    _error = '';

    // notifyListeners();
    try {
      final response = await _service.getStudent();
      _student = response;
    } on Exception catch (e) {
      _isLoading = false;
      _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    }

    //await _service.asyncName();

    _isLoading = false;
    notifyListeners();
  }
}
