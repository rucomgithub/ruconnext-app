import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:th.ac.ru.uSmart/model/scholarship.dart';
import 'package:th.ac.ru.uSmart/services/diointercepter.dart';
import 'package:th.ac.ru.uSmart/store/profile.dart';
import '../model/profile.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SchService {
  final appUrl = dotenv.env['APP_URL'];
  final dioapi = DioIntercepter();

  Future<Scholarship> getScholarShip() async {
    Scholarship schData = Scholarship.fromJson({});
    try {
      Profile profile = await ProfileStorage.getProfile();
      //print('studentCode: ${profile.studentCode}');
      //profile.studentCode = '5504500116';
      var params = {"std_code": profile.studentCode};
      await dioapi.createIntercepter();
      var response = await dioapi.api.post(
        '$appUrl/scholarship/getScholarShip',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {
        // print('Response Get Data : ${response.data}');
        schData = Scholarship.fromJson(response.data);
      } else {
        throw ('Error Get Data Rotcs Register');
      }
    } catch (err) {
      // print(err);
      throw (err);
    }

    return schData;
  }
}
