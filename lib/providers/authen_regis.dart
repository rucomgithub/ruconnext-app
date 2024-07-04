import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/model/region_login_model.dart';
import 'package:th.ac.ru.uSmart/services/ruregis_service.dart';
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

  Loginregion _loginres = Loginregion();
  Loginregion get loginres => _loginres;

  Future<void> getAuthenRuRegionApp(context, username, password) async {
    _isLoading = true;
    notifyListeners();
    try {
      _isLoading = false;
      final response = await _ruregisService.postLogin(username, password);
      if (response.tf == true) {
        await RuregionLoginStorage.saveProfile(response);
        Get.offNamedUntil('/', (route) => true);
      } else {
        var snackbar = SnackBar(content: Text('รหัสนศหรือรหัสผ่านไม่ถูกต้อง'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      // await _googleSingIn.signOut();
      _isLoading = false;
      var snackbar = SnackBar(content: Text('$e'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

    notifyListeners();
  }

  Future<void> logout() async {
    _loginres = new Loginregion();
    await RuregionLoginStorage.removeProfile();

    Get.offNamedUntil('/', (route) => true);
    notifyListeners();
  }

  Future<void> getProfile() async {
    _loginres = await RuregionLoginStorage.getProfile();
    _isLoading = false;
    notifyListeners();
  }
}
