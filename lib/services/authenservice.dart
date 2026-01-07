import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../exceptions/dioexception.dart';
import '../model/profile.dart';
import '../model/rutoken.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final usertest = dotenv.env['USERTEST'];

class AuthenService {
  final authurlgoogle = dotenv.env['APP_URL'];

  // Initialize GoogleSignIn singleton once
  static bool _isInitialized = false;

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await GoogleSignIn.instance.initialize();
      _isInitialized = true;
    }
  }

  Future<Profile> getAuthenGoogle() async {
    Profile profile;
    StreamSubscription<GoogleSignInAuthenticationEvent>? subscription;
    Completer<GoogleSignInAccount?> completer =
        Completer<GoogleSignInAccount?>();

    try {
      // Ensure GoogleSignIn is initialized
      await _ensureInitialized();

      // Listen for authentication events
      subscription = GoogleSignIn.instance.authenticationEvents.listen(
        (GoogleSignInAuthenticationEvent event) {
          if (event is GoogleSignInAuthenticationEventSignIn) {
            if (!completer.isCompleted) {
              completer.complete(event.user);
            }
          }
        },
        onError: (error) {
          if (!completer.isCompleted) {
            completer.completeError(error);
          }
        },
      );

      // Trigger authentication
      if (GoogleSignIn.instance.supportsAuthenticate()) {
        await GoogleSignIn.instance.authenticate();
      } else {
        throw ('Google Sign-In authentication not supported on this platform');
      }

      // Wait for authentication event
      GoogleSignInAccount? user = await completer.future.timeout(
        Duration(seconds: 60),
        onTimeout: () => throw ('Authentication timeout'),
      );

      if (user == null) {
        throw ('Authentication cancelled or failed');
      }

      // Get ID token
      GoogleSignInAuthentication usergoogle = await user.authentication;
      print(authurlgoogle);
      print(usergoogle.idToken);

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
        return profile;
      } else {
        throw ('Error Authentication Ramkhamhaeng University.');
      }
    } on DioException catch (err) {
      final errorMessage = DioExceptionHandler.fromDioError(err).toString();
      throw ('Error Authentication Ramkhamhaeng University: $errorMessage .');
    } catch (e) {
      throw ('เกิดข้อผิดพลาดในการเชื่อมต่อ. $e');
    } finally {
      // Clean up subscription
      await subscription?.cancel();
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
        return profile;
      } else {
        throw ('Error Authentication Ramkhamhaeng University.');
      }
    } on DioException catch (err) {
      final errorMessage = DioExceptionHandler.fromDioError(err).toString();
      throw ('Error Authentication Ramkhamhaeng University: $errorMessage .');
    } catch (e) {
      throw ('เกิดข้อผิดพลาดในการเชื่อมต่อ. $e');
    }
  }

  // Sign out method using v7.x API
  Future<void> signOut() async {
    try {
      await _ensureInitialized();
      await GoogleSignIn.instance.signOut();
    } catch (e) {
      throw ('Error signing out: $e');
    }
  }
}
