import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/store/rotcsextend.dart';
import 'package:th.ac.ru.uSmart/store/rotcsregister.dart';
import 'package:th.ac.ru.uSmart/store/sch.dart';
import '../services/authenservice.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../model/profile.dart';
import '../store/mr30.dart';
import '../store/profile.dart';

class AuthenProvider extends ChangeNotifier {
  final _service = AuthenService();
  final _googleSingIn = GoogleSignIn();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Profile _profile = Profile();
  Profile get profile => _profile;

  String _role = "-";
  String get role => _role;

  String _roletext = "-";
  String get roletext => _roletext;

  Future<void> getAuthenGoogleDev(context, String std_code) async {
    print('getAuthenGoogleDev');
    _isLoading = true;

    try {
      _isLoading = false;
      _profile = await _service.getAuthenGoogleDev(std_code);
      await ProfileStorage.saveProfile(_profile);

      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(_profile.accessToken.toString());
      // Now you can use your decoded token
      _role = decodedToken["role"];

      Get.offNamedUntil('/', (route) => true);
    } catch (e) {
      await _googleSingIn.signOut();
      _isLoading = false;
      var snackbar = SnackBar(content: Text('$e'));
      print('$e');
      _role = '';
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

    notifyListeners();
  }

  Future<void> getAuthenGoogle(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoading = true;

    try {
      _isLoading = true;
      //print("-------------login success-------------------");
      _profile = await _service.getAuthenGoogle();
      //print('-------------profile success------------------- ${_profile}');
      await prefs.setString('profile', jsonEncode(_profile));
      Get.offNamedUntil('/', (route) => true);
    } catch (e) {
      _isLoading = false;
      var snackbar = SnackBar(content: Text('Error: $e'));
      //print('${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      await _googleSingIn.disconnect();
    }

    notifyListeners();
  }

  Future<void> logout() async {
    _profile = new Profile(studentCode: "");
    _role = '';
    await ProfileStorage.removeProfile();
    await MR30Storage.removeMR30();
    await RotcsExtendStorage.removeExtend();
    await RotcsRegisterStorage.removeRegister();
    await SchStorage.removeSch();
    await _googleSingIn.signOut();

    Get.offNamedUntil('/', (route) => true);
    notifyListeners();
  }

  Future<void> getProfile() async {
    _profile = await ProfileStorage.getProfile();
    _isLoading = true;

    await Future<dynamic>.delayed(const Duration(seconds: 1));
    _profile = await ProfileStorage.getProfile();
    print('Profile');
    try {
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(_profile.accessToken.toString());
      // Now you can use your decoded token
      _role = decodedToken["role"];
      switch (_role) {
        case "Bachelor":
          _roletext = "ปริญญาตรี";
          break;
        case "Master":
          _roletext = "ปริญญาโท";
          break;
        case "Doctor":
          _roletext = "ปริญญาเอก";
          break;
        default:
          _roletext = "";
      }
    } catch (e) {
      print('Error decoding JWT: $e');
      _role = '';
      _roletext = "";
    }

    _isLoading = false;

    notifyListeners();
  }
}
