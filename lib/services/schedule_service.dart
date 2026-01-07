import 'package:dio/dio.dart';
import '../model/schedule.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ScheduleService {
  final calendarurl = dotenv.env['CALENDAR_URL'];
  Future<List<Schedule>> getSchedules() async {
    //print('Call Service schedule');
    try {
      Response response = await Dio().get(
          '$calendarurl/CalendarCenter/ScheduleCenterFlutter');
      List<dynamic> data = response.data;
      // print(response.data);
      return data.map((json) => Schedule.fromJson(json)).toList();
    } catch (error) {
      throw error;
    }
  }
}
