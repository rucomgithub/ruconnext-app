import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:th.ac.ru.uSmart/master/models/master_grade.dart';
import 'package:th.ac.ru.uSmart/services/diointercepter.dart';
import '../../model/profile.dart';

class MasterGradeService {
  final appUrl = dotenv.env['APP_URL'];
  final dioapi = DioIntercepter();
  String? profile;
  Profile p = Profile();
  Future<MasterGrade> getAllGrade(Profile profile) async {
    await dioapi.createIntercepter();
    MasterGrade gradedata = MasterGrade.fromJson({});
    try {
      var params = {"year": '', "std_code": ""};
      //print('$appUrl/master/grade/' + "Bearer ${profile.accessToken}");
      var response = await dioapi.api.get(
        '$appUrl/master/grade/',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "authorization": "Bearer ${profile.accessToken}",
          },
        ),
      );
      if (response.statusCode == 200) {
        //print(response);
        gradedata = MasterGrade.fromJson(response.data);
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return gradedata;
  }
}
