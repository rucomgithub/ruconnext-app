import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:th.ac.ru.uSmart/store/profile.dart';
import '../exceptions/dioexception.dart';
import '../model/profile.dart';
import '../model/rutoken.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final usertest = dotenv.env['USERTEST'];

class AuthenService {
  final authurlgoogle = dotenv.env['APP_URL'];
  Future<Profile> getAuthenGoogle() async {
    final googleSingIn = GoogleSignIn();
    Profile profile;
    try {
      //print('signIn');
      GoogleSignInAccount? user = await googleSingIn.signIn();
      //print(user);
      GoogleSignInAuthentication usergoogle = await user!.authentication;
      //print(usergoogle.accessToken);
      // ignore: avoid_print
      //print('user: ${usergoogle.idToken}');

      String studentcode = user.email.substring(0, 10);

      var params = {"std_code": studentcode};
      var response = await Dio().post(
        '$authurlgoogle/google/authorization',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "authorization": "Bearer ${usergoogle.idToken}",
          },
        ),
        data: jsonEncode(params),
      );

      if (response.statusCode == 200) {
        Rutoken token = Rutoken.fromJson(response.data);
        // ignore: avoid_print
        //print('response ${response.data}');
        // print('rutoken : ${token.accessToken}');
        profile = Profile.fromJson({
          'displayName': user.displayName,
          'email': user.email,
          'studentCode': studentcode,
          'photoUrl': user.photoUrl,
          'googleToken': usergoogle.idToken,
          'accessToken': token.accessToken,
          'refreshToken': token.refreshToken,
          'isAuth': token.isAuth
        });
        // print(profile.email);
        return profile;
      } else {
        throw ('Error Authentication Ramkhamhaeng University.');
      }
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      //print('${err.response} ...');
      throw ('Error Authentication Ramkhamhaeng University: $errorMessage .');
    } catch (e) {
      // print('เกิดข้อผิดพลาดในการเชื่อมต่อ. $e');
      throw ('เกิดข้อผิดพลาดในการเชื่อมต่อ. $e');
    }
  }

  Future<Profile> getAuthenGoogleDev() async {
    Profile profile;
    try {
      String studentcode = "$usertest";
      var params = {"std_code": studentcode};
      var response = await Dio().post(
        '$authurlgoogle/google/authorization-test',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "authorization": "Bearer ",
          },
        ),
        data: jsonEncode(params),
      );

      if (response.statusCode == 200) {
        Rutoken token = Rutoken.fromJson(response.data);
        // print("-------------ru authen success-------------------\n");
        // print('response ${response.data}');
        // print('rutoken : ${token.accessToken}');
        profile = Profile.fromJson({
          'displayName': "$usertest",
          'email': "$usertest@rumail.ru.ac.th",
          'studentCode': studentcode,
          'photoUrl': '',
          'googleToken': '',
          'accessToken': token.accessToken,
          'refreshToken': token.refreshToken,
          'isAuth': token.isAuth
        });
        // print(profile.email);
        return profile;
      } else {
        throw ('Error Authentication Ramkhamhaeng University.');
      }
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      //print('Error Authentication Ramkhamhaeng University: $errorMessage .');
      throw ('Error Authentication Ramkhamhaeng University: $errorMessage .');
    } catch (e) {
      // print('เกิดข้อผิดพลาดในการเชื่อมต่อ. $e');
      throw ('เกิดข้อผิดพลาดในการเชื่อมต่อ. $e');
    }
  }
}
