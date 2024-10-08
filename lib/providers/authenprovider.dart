import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/store/authen.dart';
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

  Future<void> setProfile(Profile profile) async {
    _profile = profile;
    notifyListeners();
  }

  Future<void> getAuthenGoogleDev(context, String std_code) async {
    print('getAuthenGoogleDev');
    _isLoading = true;

    try {
      _isLoading = false;
      _profile = await _service.getAuthenGoogleDev(std_code);
      await ProfileStorage.saveProfile(_profile);
      await AuthenStorage.setAccessToken('${_profile.accessToken}');
      await AuthenStorage.setRefreshToken('${_profile.refreshToken}');

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
      _isLoading = false;
      _profile = await _service.getAuthenGoogle();
      await ProfileStorage.saveProfile(_profile);
      await AuthenStorage.setAccessToken('${_profile.accessToken}');
      await AuthenStorage.setRefreshToken('${_profile.refreshToken}');

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

  Future<void> logout() async {
    _profile = new Profile(studentCode: "");
    _role = '';
    await ProfileStorage.removeProfile();
    await MR30Storage.removeMR30();
    await RotcsExtendStorage.removeExtend();
    await RotcsRegisterStorage.removeRegister();
    await SchStorage.removeSch();

    await AuthenStorage.clearTokens();
    await _googleSingIn.signOut();

    //Get.offNamed('/login');
    notifyListeners();
  }

  Future<void> getProfile() async {
    print('getProfile');
    _profile = await ProfileStorage.getProfile();
    _isLoading = true;

    final accessToken = await AuthenStorage.getAccessToken();
    final refreshToken = await AuthenStorage.getRefreshToken();
    if (accessToken == null && refreshToken == null) {
      print('logout');
      await this.logout();
    } else {
      _profile.accessToken = accessToken;
      _profile.refreshToken = refreshToken;
      //print('accessToken $accessToken');
      //print('refreshToken :$refreshToken');
    }

    try {
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(accessToken.toString());
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
