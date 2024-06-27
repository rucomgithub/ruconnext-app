import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/authenservice.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

Future<void> getAuthenRuRegionApp(context) async {
    _isLoading = true;
    notifyListeners();
    try {
      _isLoading = false;
      _profile = await _service.getAuthenGoogleDev();
      await ProfileStorage.saveProfile(_profile);
      Get.offNamedUntil('/', (route) => true);
    } catch (e) {
      await _googleSingIn.signOut();
      _isLoading = false;
      var snackbar = SnackBar(content: Text('$e'));
      //print('$e');
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
    _profile = new Profile();
    await ProfileStorage.removeProfile();
    await MR30Storage.removeMR30();
    await _googleSingIn.signOut();

    Get.offNamedUntil('/', (route) => true);
    notifyListeners();
  }

    Future<void> getProfile() async {
    _profile = await ProfileStorage.getProfile();
    _isLoading = false;
    notifyListeners();
  }


}
