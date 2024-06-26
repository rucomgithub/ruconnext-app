import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:th.ac.ru.uSmart/model/insurance.dart';
import 'package:th.ac.ru.uSmart/services/diointercepter.dart';
import 'package:th.ac.ru.uSmart/store/profile.dart';
import '../model/profile.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class InsuranceService {
  final appUrl = dotenv.env['APP_URL'];
  final dioapi = DioIntercepter();

  Future<Insurance> getInsuranceAll() async {
    Insurance registerdata = Insurance.fromJson({});
    try {
      Profile profile = await ProfileStorage.getProfile();
      //print('studentCode: ${profile.studentCode}');
      //profile.studentCode = '6401628414';
      var params = {"StudentCode": profile.studentCode};
      await dioapi.createIntercepter();
      var response = await dioapi.api.post(
        '$appUrl/insurance/',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {
        //print('Response Get Data : ${response.data}');
        registerdata = Insurance.fromJson(response.data);
      } else {
        throw ('Error Get Data Insurance');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return registerdata;
  }
}
