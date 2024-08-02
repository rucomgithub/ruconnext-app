import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:th.ac.ru.uSmart/model/rotcs_extend.dart';
import 'package:th.ac.ru.uSmart/model/rotcs_register.dart';
import 'package:th.ac.ru.uSmart/services/diointercepter.dart';
import 'package:th.ac.ru.uSmart/store/profile.dart';
import '../model/profile.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RotcsService {
  final appUrl = dotenv.env['APP_URL'];
  final dioapi = DioIntercepter();

  Future<RotcsRegister> getRegisterAll() async {
    RotcsRegister registerdata = RotcsRegister.fromJson({});
    try {
      Profile profile = await ProfileStorage.getProfile();
      //profile.studentCode = '6505003472';
      var params = {"StudentCode": profile.studentCode};
      await dioapi.createIntercepter();
      var response = await dioapi.api.post(
        '$appUrl/rotcs/register',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {
        registerdata = RotcsRegister.fromJson(response.data);
      } else {
        throw ('Error Get Data Rotcs Register');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return registerdata;
  }

  Future<RotcsExtend> getExtendAll() async {
    RotcsExtend extenddata = RotcsExtend.fromJson({});
    try {
      Profile profile = await ProfileStorage.getProfile();
      //print('studentCode: ${profile.studentCode}');
      //profile.studentCode = '6054004467';
      var params = {"StudentCode": profile.studentCode};
      await dioapi.createIntercepter();
      var response = await dioapi.api.post(
        '$appUrl/rotcs/extend',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {
        //print('Response Get Data : ${response.data}');
        extenddata = RotcsExtend.fromJson(response.data);
      } else {
        throw ('Error Get Data Rotcs Extend');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return extenddata;
  }
}
