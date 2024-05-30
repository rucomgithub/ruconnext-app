import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/services/diointercepter.dart';
import '../model/mr30_model.dart';
import '../model/profile.dart';
import '../model/register_model.dart';
import '../model/registeryear_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RegisterService { 
  final regisurl = dotenv.env['APP_URL_DEV'];
  final dioapi = DioIntercepter();
  String? profile ;
  Profile p = Profile();
  
  Future<Register> getAllregister() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profile = prefs.getString('profile');
    p = Profile.fromJson(json.decode(profile!));

    Register registerdata = Register.fromJson({});
    try {
      var params = {"year": '2565', "std_code": "${p.studentCode}"};
      await dioapi.createIntercepter();
      var response = await dioapi.api.post(
        '$regisurl/grade/${p.studentCode}',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {
        registerdata = Register.fromJson(response.data);
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return registerdata;
  }

  Future<MR30> getAllregisterLatest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profile = prefs.getString('profile');
    p = Profile.fromJson(json.decode(profile!));
    //print("studentcode: $p");
    MR30 registerdata = MR30.fromJson({});
    try {
     // var params = {"year": '2565', "semester": '2'};
      await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        '$regisurl/register/${p.studentCode}/schedulelatest',
       
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        //data: jsonEncode(params),
      );
      if (response.statusCode == 200) {
        registerdata = MR30.fromJson(response.data);
       // print('mr30 register ${registerdata}');
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return registerdata;
  }

  Future<REGISTERYEAR> getAllRegisterYear(String studentcode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profile = prefs.getString('profile');
    p = Profile.fromJson(json.decode(profile!));
    
    REGISTERYEAR registerdata = REGISTERYEAR.fromJson({});
    try {
      await dioapi.createIntercepter();
      var response =
          await dioapi.api.get('$regisurl/register/${p.studentCode}/year',
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

  Future<Register> getAllRegisterList(String std_code, year) async {
    Register registerlist = Register.fromJson({});
    try {
      var params = {"std_code": std_code, "year": year};
      await dioapi.createIntercepter();
      var response2 = await dioapi.api.post(
        '$regisurl/register/',
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
