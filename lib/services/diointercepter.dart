import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:th.ac.ru.uSmart/model/profile.dart';
import 'package:th.ac.ru.uSmart/model/rutoken.dart';
import 'package:th.ac.ru.uSmart/store/profile.dart';

class DioIntercepter {
  final Dio api = Dio();
  String? accessToken;
  final appUrl = dotenv.env['APP_URL'];
  createIntercepter() async {
    Profile profile = await ProfileStorage.getProfile();
    accessToken = profile.accessToken;
    api.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (!options.path.contains('http')) {
        options.path = 'http://ruconnext.ru.ac.th' + options.path;
      }

      options.headers['Authorization'] = 'Bearer $accessToken';
      return handler.next(options);
    }, onError: (DioError error, handler) async {
      if ((error.response?.statusCode == 401)) {
        Profile profile = await ProfileStorage.getProfile();
        if (profile.refreshToken != null) {
          if (await refreshToken()) {
            Profile profile = await ProfileStorage.getProfile();
            error.requestOptions.headers['Authorization'] =
                'Bearer ${profile.accessToken}';
            //print("uri ${error.requestOptions.uri}");
            return handler.resolve(await _retry(error.requestOptions));
          }
        }
      }

      return handler.next(error);
    }));
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<bool> refreshToken() async {
    Profile profile = await ProfileStorage.getProfile();
    var params = {
      "Refresh_token": "${profile.refreshToken}",
      "Std_code": "${profile.studentCode}"
    };
    try {
      var response = await Dio().post('$appUrl/student/refresh-authentication',
          data: jsonEncode(params));

      if (response.statusCode == 200) {
        Rutoken ruToken = Rutoken.fromJson(response.data);
        profile.accessToken = ruToken.accessToken;
        profile.refreshToken = ruToken.refreshToken;
        profile.isAuth = ruToken.isAuth;

        accessToken = ruToken.accessToken;
        await ProfileStorage.saveProfile(profile);
        return true;
      }
      // refresh token is wrong
      //print("refresh token is wrong");
      ProfileStorage.removeProfile();
      return false;
    } catch (e) {
      //print("refresh token is wrong >>>" + e.toString());
      ProfileStorage.removeProfile();
      throw Exception('Request error: 422 Unprocessable Entity');
    }
  }
}
