import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:th.ac.ru.uSmart/services/diointercepter.dart';
import 'package:th.ac.ru.uSmart/model/yearsemester.dart';
import '../model/mr30_model.dart';
import '../model/mr30year_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/profile.dart';
import '../store/profile.dart';
 
class MR30Service { 
  final mr30url = dotenv.env['APP_URL_DEV'];
  final dioapi = DioIntercepter();

  Future<YearSemester> getYearSemesterLatest() async {

    YearSemester yearSemester = YearSemester(year: "", semester: "");
    try {
      var response = await dioapi.api.get(
        '$mr30url/register/yearsemesterlates',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        print(response.data);
        yearSemester = YearSemester.fromJson(response.data);
      } else {
        throw ('Error Get Year Semester.');
      }
    } catch (err) {
      // print('err getYearSemesterLatest >>>>>>>>>>>: $err');
      throw (err);
    }

    return yearSemester;
  }
  
  Future<MR30> getScheduleLatest() async {
    MR30 registerdata = MR30.fromJson({});
    try {
      var params = {"year": '', "semester": ''};
      Profile profile = await ProfileStorage.getProfile();
      await dioapi.createIntercepter();
      var response = await dioapi.api.post(
        '$mr30url/register/${profile.studentCode}/schedulelatest',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {
        registerdata = MR30.fromJson(response.data);
        // print('mr30 register ${response.data}');
      } else {
        // print('mr30 register Error Get Data');
        throw ('Error Get Data');
      }
    } catch (err) {
      // print(err);
      // print('err getScheduleLatest >>>>>>>>>>>: $err');
      throw (err);
    }

    return registerdata;
  }

  Future<MR30> getAllMR30() async {
    MR30YEAR mr30data = MR30YEAR.fromJson({});
    MR30 mr30list = MR30.fromJson({});
    try {
      var params = {};

      var response1 = await Dio().post(
        '$mr30url/mr30/year',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(params),
      );
      if (response1.statusCode == 200) {
        //print('data ${response1.data}');
        mr30data = MR30YEAR.fromJson(response1.data);
        String year = mr30data.recordyear![0].courseYear!;
        String semester = mr30data.recordyear![0].courseSemester!;
        try {
          var params = {"course_year": year, "course_semester": semester};

          var response2 = await Dio().post(
            '$mr30url/mr30/data',
            options: Options(
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
              },
            ),
            data: jsonEncode(params),
          );
          if (response2.statusCode == 200) {
            mr30list = MR30.fromJson(response2.data);
          } else {
            throw ('Error Get Data');
          }
        } catch (err) {
          //print(err);
          throw (err);
        }
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return mr30list;
  }

  Future<MR30> getAllMR30List(String year, semester) async {
    MR30 mr30list = MR30.fromJson({});
    try {
      var params = {"course_year": year, "course_semester": semester};

      var response2 = await Dio().post(
        '$mr30url/mr30/data',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(params),
      );
      if (response2.statusCode == 200) {
        mr30list = MR30.fromJson(response2.data);
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return mr30list;
  }

  Future<MR30YEAR> getAllMR30Year() async {
    MR30YEAR mr30data = MR30YEAR.fromJson({});
    try {
      var params = {"course_year": '', "course_semester": ""};

      var response = await Dio().post(
        '$mr30url/mr30/year',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {
        //print('data ${response.data}');
        mr30data = MR30YEAR.fromJson(response.data);
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return mr30data;
  }
}
