import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/model/mr30_catalog.dart';
import 'package:th.ac.ru.uSmart/model/student.dart';
import 'package:th.ac.ru.uSmart/services/diointercepter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/profile.dart';
import '../store/profile.dart';

class StudentService {
  final dioapi = DioIntercepter();
  final appUrl = dotenv.env['APP_URL_DEV'];
  final appUrlProd = dotenv.env['APP_URL'];
  final urlMr30Catalog = dotenv.env['MR30_CAT'];
  
  late BuildContext _context;

  set context(BuildContext context) {
    _context = context;
  }

  Future<Uint8List> getImageProfile() async {
    Uint8List imageData = Uint8List(0);
    await dioapi.createIntercepter();
    try {
      final response = await dioapi.api.get(
        '$appUrl/student/photoprofile',
        options: Options(responseType: ResponseType.bytes),
      );
      if (response.statusCode == 200) {
        //print("Get image profile");
        imageData = response.data;
      } else {
        //print("Error Get image profile");
        throw ('Error Get image profile.');
      }
    } catch (err) {
      //print("Error Get image profile. $err");

      throw (err);
    }
    return imageData;
  }

  Future<Student> getStudent() async {
    Student studentdata = Student.fromJson({});
    try {
      Profile profile = await ProfileStorage.getProfile();
      await dioapi.createIntercepter();
      var response =
           await dioapi.api.get('$appUrlProd/student/profile/${profile.studentCode}',
                  // await dioapi.api.get('$appUrl/student/profile',
              options: Options(
                headers: {
                  HttpHeaders.contentTypeHeader: "application/json",
                },
              ));
      if (response.statusCode == 200) {
        //print('data ${response}');
        studentdata = Student.fromJson(response.data);
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return studentdata;
  }

    Future<Mr30Catalog> getMr30Catalog() async {
    Mr30Catalog mr30catalogdata = Mr30Catalog.fromJson({});
    try {
      await dioapi.createIntercepter();
      var response =
          await dioapi.api.get('$urlMr30Catalog/mr30_catalog.json',
              options: Options(
                headers: {
                  HttpHeaders.contentTypeHeader: "application/json",
                },
              ));
      if (response.statusCode == 200) {
        //print('data ${response}');
        // List<dynamic>  mr30catalogdata = response.data;   
               mr30catalogdata = Mr30Catalog.fromJson(response.data); 
        // print('--------------------${mr30catalogdata}--------------------');
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return mr30catalogdata;
  }
  // Future<List<dynamic>> fetchMr30Catalog() async {
  //   try {
  //       await dioapi.createIntercepter();
  //     final response = await dioapi.api.get('$urlMr30Catalog/mr30_catalog.json');

  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = response.data;
  //       return data;
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (error) {
  //     throw Exception('Failed to load data: $error');
  //   }
  // }
}
