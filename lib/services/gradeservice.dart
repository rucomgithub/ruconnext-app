import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:th.ac.ru.uSmart/services/diointercepter.dart';
import '../model/grade_model.dart';
import '../model/profile.dart';

class GradeService {
  final appUrl = dotenv.env['APP_URL'];
  final dioapi = DioIntercepter();
  String? profile;
  Profile p = Profile();
  Future<Grade> getAllGrade(Profile profile) async {
    await dioapi.createIntercepter();
    Grade gradedata = Grade.fromJson({});
    try {
      var params = {"year": '', "std_code": ""};

      var response = await dioapi.api.post(
        '$appUrl/grade/${profile.studentCode}',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {
        gradedata = Grade.fromJson(response.data);
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
