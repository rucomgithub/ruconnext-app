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

Future<void> getAuthenGoogleDev(context) async {
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

  Future<void> getAuthenGoogle(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoading = true;
    notifyListeners();

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
