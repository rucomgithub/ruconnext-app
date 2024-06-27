import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/services/ruregis_service.dart';
import 'package:th.ac.ru.uSmart/store/ruregion_login.dart';
import '../services/authenservice.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/profile.dart';
import '../store/mr30.dart';
import '../store/profile.dart';

class AuthenProvider extends ChangeNotifier {
  final _googleSingIn = GoogleSignIn();
  final _ruregisService = RuregisService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Profile _loginres = Profile();
  Profile get loginres => _loginres;

Future<void> getAuthenRuRegionApp(context,username, password) async {
    _isLoading = true;
    notifyListeners();
    try {
      _isLoading = false;
      final response = await _ruregisService.postLogin(username, password);
      await RuregionLoginStorage.saveProfile(response);
      Get.offNamedUntil('/', (route) => true);
    } catch (e) {
      await _googleSingIn.signOut();
      _isLoading = false;
      var snackbar = SnackBar(content: Text('$e'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

    notifyListeners();
  }

  
// void doLogin(context, username, password) async {
//     _isLoading = true;
//     _error = '';

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     // final sres = prefs.getString('regionlogin')!;
//     notifyListeners();
//     try {
//       final response = await _ruregisService.postLogin(username, password);
//       _logindata = response;
//       _logindata.rec?.forEach((element) {
//         stdcode = element.username!;
//       });
//       // print(_logindata.tf);
//       if (_logindata.tf == true) {
//         await prefs.setString('regionlogin', jsonEncode(stdcode));
//         Get.offNamedUntil('/ruregionhome', (route) => true);
//         // Get.offNamedUntil('/', (route) => true);
//       } else {
//         var snackbar = SnackBar(content: Text('รหัสนศหรือรหัสผ่านไม่ถูกต้อง'));
//         ScaffoldMessenger.of(context).showSnackBar(snackbar);
//       }
//     } on Exception catch (e) {
//       var snackbar = SnackBar(content: Text('$e'));
//       ScaffoldMessenger.of(context).showSnackBar(snackbar);

//       _isLoading = false;
//       _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
//     }

//     //await _service.asyncName();

//     _isLoading = false;
//     notifyListeners();
//   }


    Future<void> logout() async {
    _loginres = new Profile();
    await ProfileStorage.removeProfile();
    await MR30Storage.removeMR30();
    await _googleSingIn.signOut();

    Get.offNamedUntil('/', (route) => true);
    notifyListeners();
  }

    Future<void> getProfile() async {
    _loginres = await ProfileStorage.getProfile();
    _isLoading = false;
    notifyListeners();
  }


}
