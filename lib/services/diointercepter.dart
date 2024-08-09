import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/model/profile.dart';
import 'package:th.ac.ru.uSmart/model/rutoken.dart';
import 'package:th.ac.ru.uSmart/store/authen.dart';
import 'package:th.ac.ru.uSmart/store/profile.dart';

class DioIntercepter {
  final dio.Dio api = dio.Dio();
  final appUrl = dotenv.env['APP_URL'];

  createIntercepter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    api.options..connectTimeout = 10000;
    api.options..receiveTimeout = 10000;

    api.interceptors
        .add(dio.InterceptorsWrapper(onRequest: (options, handler) async {
      final accessToken = await AuthenStorage.getAccessToken();
      if (!options.path.contains('http')) {
        options.path = 'https://ruconnext.ru.ac.th' + options.path;
      }
      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer ${accessToken}';
      }

      return handler.next(options);
    }, onError: (dio.DioError error, handler) async {
      if ((error.response?.statusCode == 401 &&
          error.response?.data['message'] ==
              "Authorization falil because of timeout...")) {
        if (await prefs.containsKey('refreshToken')) {
          if (await refreshToken()) {
            return handler.resolve(await _retry(error.requestOptions));
          }
        }
      }

      return handler.next(error);
    }));
  }

  Future<dio.Response<dynamic>> _retry(
      dio.RequestOptions requestOptions) async {
    final options = dio.Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<bool> refreshToken() async {
    final refreshToken = await AuthenStorage.getRefreshToken();
    var params = {"Refresh_token": "${refreshToken}", "Std_code": "6299999991"};
    try {
      var response = await api.post('$appUrl/student/refresh-authentication',
          data: jsonEncode(params));

      if (response.statusCode == 200) {
        Rutoken ruToken = Rutoken.fromJson(response.data);
        await AuthenStorage.setAccessToken('${ruToken.accessToken}');
        await AuthenStorage.setRefreshToken('${ruToken.refreshToken}');
        return true;
      }
      return false;
    } on DioError catch (err) {
      print('DioError $err');
      AuthenStorage.clearTokens();
      return false;
    } catch (e) {
      //await ProfileStorage.removeProfile();
      print("refresh token is wrong >>>" + e.toString());
      print('object fail.........................................');
      throw Exception('Request error: 422 Unprocessable Entity');
    }
  }
}
