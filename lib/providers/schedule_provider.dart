import 'package:flutter/foundation.dart';

import '../model/schedule.dart';
import '../services/schedule_service.dart';

class ScheduleProvider with ChangeNotifier {
  List<Schedule> _schedules = [];
  bool isLoading = false;
  ScheduleService _scheduleService = ScheduleService();

  List<Schedule> get schedules => _schedules;

  Future<void> fetchSchedules() async {
    isLoading = true;
    try {
      List<Schedule> schedules = await _scheduleService.getSchedules();
      _schedules = schedules;
      //print('data schedules $_schedules');
      isLoading = false;
    } catch (error) {
      //print(error);
      isLoading = false;
      notifyListeners();
    }
  }
}
