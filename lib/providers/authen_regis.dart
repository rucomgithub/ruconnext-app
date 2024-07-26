import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/model/counter_region_model.dart';
import 'package:th.ac.ru.uSmart/model/region_login_model.dart';
import 'package:th.ac.ru.uSmart/services/ruregis_service.dart';
import 'package:th.ac.ru.uSmart/store/counterAdminRegion.dart';
import 'package:th.ac.ru.uSmart/store/mr30App.dart';
import 'package:th.ac.ru.uSmart/store/ruregion_login.dart';
import '../services/authenservice.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/profile.dart';
import '../store/mr30.dart';
import '../store/profile.dart';

class AuthenRuRegionAppProvider extends ChangeNotifier {
  final _googleSingIn = GoogleSignIn();
  final _ruregisService = RuregisService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingLogin = false;
  bool get isLoadingLogin => _isLoadingLogin;

  Loginregion _loginres = Loginregion();
  Loginregion get loginres => _loginres;

  String _msgSaveButtonLogin = 'เข้าสู่ระบบ';
  String get msgSaveButtonLogin => _msgSaveButtonLogin;

  Future<void> getAuthenRuRegionApp(context, username, password) async {
    _isLoadingLogin = true;
    _msgSaveButtonLogin = 'กำลังโหลด...';
    notifyListeners();
    try {
      final response = await _ruregisService.postLogin(username, password);
      if (response.tf == true) {
        await RuregionLoginStorage.saveProfile(response);
        saveStatus();
        Get.offNamedUntil('/', (route) => true);
      } else {
        var snackbar = SnackBar(content: Text('รหัสนศหรือรหัสผ่านไม่ถูกต้อง'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      // await _googleSingIn.signOut();

      var snackbar = SnackBar(content: Text('$e'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
    _isLoadingLogin = false;
    _msgSaveButtonLogin = 'เข้าสู่ระบบ';
    notifyListeners();
  }

  Future<void> getCounterRegionApp() async {
    _isLoading = true;

    try {
      _isLoading = false;
      final response = await _ruregisService.getCounterAdminRegionApp();
      if (response.success == true) {
        await CounterRegionAppStorage.saveCounterRegionApp(response);
        //  saveStatus();
      } else {}
    } catch (e) {
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> saveStatus() async {
    _isLoading = true;
    print('saveStatus');
    try {
      _isLoading = false;
      final response = await _ruregisService.saveStatusApp();
      if (response.success == true) {
        print('${response.success}');
      } else {}
    } catch (e) {
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> logout() async {
    _loginres = new Loginregion();
    await RuregionLoginStorage.removeProfile();
    await MR30AppStorage.removeMR30App();
    Get.offNamedUntil('/', (route) => true);
    notifyListeners();
  }

  Future<void> getProfile() async {
    _loginres = await RuregionLoginStorage.getProfile();
    _isLoading = false;
    notifyListeners();
  }
}
