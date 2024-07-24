import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:th.ac.ru.uSmart/master/models/master_register.dart';
import 'package:th.ac.ru.uSmart/services/diointercepter.dart';
import 'package:th.ac.ru.uSmart/store/profile.dart';
import '../../model/mr30_model.dart';
import '../../model/profile.dart';
import '../../model/register_model.dart';
import '../../model/registeryear_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MasterRegisterService {
  final appUrl = dotenv.env['APP_URL_DEV'];
  final dioapi = DioIntercepter();

  Future<MasterRegister> getRegisterAll() async {
    MasterRegister registerdata = MasterRegister.fromJson({});
    try {
      Profile profile = await ProfileStorage.getProfile();
      print(profile);
      await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        '$appUrl/master/register/',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "authorization": "Bearer ${profile.accessToken}",
          },
        ),
      );
      if (response.statusCode == 200) {
        //print('Response Get Data : ${response.data}');
        registerdata = MasterRegister.fromJson(response.data);
        print(registerdata);
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      print(err);
      throw (err);
    }

    return registerdata;
  }

  Future<MR30> getScheduleLatest() async {
    MR30 registerdata = MR30.fromJson({});
    try {
      Profile profile = await ProfileStorage.getProfile();
      await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        '$appUrl/register/${profile.studentCode}/schedulelatest',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        // data: jsonEncode(params),
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

  Future<REGISTERYEAR> getAllRegisterYear(String studentcode) async {
    REGISTERYEAR registerdata = REGISTERYEAR.fromJson({});
    try {
      Profile profile = await ProfileStorage.getProfile();
      await dioapi.createIntercepter();
      var response =
          await dioapi.api.get('$appUrl/register/${profile.studentCode}/year',
              options: Options(
                headers: {
                  HttpHeaders.contentTypeHeader: "application/json",
                },
              ));
      if (response.statusCode == 200) {
        //print('data ${response}');
        registerdata = REGISTERYEAR.fromJson(response.data);
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return registerdata;
  }

  Future<String> asyncName() async {
    return "kim";
  }

  Future<Register> getAllRegisterList(String year) async {
    Register registerlist = Register.fromJson({});
    try {
      Profile profile = await ProfileStorage.getProfile();
      await dioapi.createIntercepter();
      var params = {"std_code": profile.studentCode, "year": year};

      var response2 = await dioapi.api.post(
        '$appUrl/register/',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(params),
      );
      if (response2.statusCode == 200) {
        registerlist = Register.fromJson(response2.data);
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return registerlist;
  }
}
