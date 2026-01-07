import 'package:flutter/foundation.dart';

import '../model/ondemand.dart';
import '../services/ondemandservice.dart';

class OndemandProvider with ChangeNotifier {
  final _service = OndemandService();
  bool isLoading = false;

  Ondemand _ondemand = Ondemand();
  Ondemand get ondemand => _ondemand;

  String _error = '';
  String get error => _error;

  int _countOndemand = 0;
  int get countOndemand => _countOndemand;

  Future<void> getOndemandList(String subject_id, semester, year) async {
    isLoading = true;
    _error = '';
    // _ondemand = Ondemand();
    _countOndemand = 0;
    // ondemand.rECORD!.detail = [];//***เอาออกหลังจากที่build แล้ว null
    notifyListeners();
    try {
      //print('provider' + subject_id + semester + year);
      final response = await _service.getOndemand(subject_id, semester, year);
      _ondemand = response;

      // Safe null checks without assertion operators
      if (response.rECORD == null ||
          response.rECORD!.detail == null ||
          response.rECORD!.detail!.isEmpty) {
        _countOndemand = 0;
      } else if (response.rECORD!.detail!.first.audioId == "") {
        //print(response);
        _countOndemand = 0;
      } else {
        _countOndemand = response.rECORD!.detail!.length;
      }
      // print('from provider ->${response.rECORD!.detail!.length}');
      isLoading = false;
    } on Exception catch (e) {
      _ondemand = Ondemand();
      isLoading = false;
      _error = 'เกิดข้อผิดพลาด $e';
     // print('from provider $_error');
    }
    notifyListeners();
  }

  // void getOndemandCount() {
  //   notifyListeners();
  //   _countOndemand = 0;
  //   _countOndemand = _ondemand.rECORD!.detail!.length;
  //   notifyListeners(); // Notify listeners to update the UI
  // }

  void clearData() {
    _ondemand = Ondemand();
    notifyListeners(); // Notify listeners to update the UI
  }
}
