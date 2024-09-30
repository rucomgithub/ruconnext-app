import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:th.ac.ru.uSmart/master/models/master_student.dart';

import 'package:th.ac.ru.uSmart/services/diointercepter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../model/profile.dart';
import '../../store/profile.dart';

class MasterStudentService {
  final dioapi = DioIntercepter();
  final appUrl = dotenv.env['APP_URL'];

  Future<Uint8List> getImageProfile() async {
    Uint8List imageData = Uint8List(0);
    await dioapi.createIntercepter();
    try {
      print('$appUrl/student/photograduate');
      final response = await dioapi.api.get(
        '$appUrl/student/photograduate',
        options: Options(responseType: ResponseType.bytes),
      );
      if (response.statusCode == 200) {
        //print("Get image profile");
        imageData = response.data;
      } else {
        print("Error  statusCode not 200 image profile");
        throw ('Error statusCode not 200 image profile.');
      }
    } catch (err) {
      print("Error catch image profile. $err");
      throw (err);
    }

    return imageData;
  }

  Future<MasterStudent> getStudent() async {
    MasterStudent studentdata = MasterStudent.fromJson({});
    try {
      Profile profile = await ProfileStorage.getProfile();
      await dioapi.createIntercepter();
      print('token ' + '${profile.accessToken}');
      var response = await dioapi.api.get('$appUrl/master/student/profile',
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              "authorization": "Bearer ${profile.accessToken}",
            },
          ));
      if (response.statusCode == 200) {
        print('data ${response}');
        studentdata = MasterStudent.fromJson(response.data);
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      print(err);
      throw (err);
    }

    return studentdata;
  }
}
