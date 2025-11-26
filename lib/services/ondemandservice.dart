import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' hide DioException;
import '../exceptions/dioexception.dart';
import '../model/ondemand.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OndemandService {
  final ondemandurl = dotenv.env['ONDEMAND_URL'];

  Future<Ondemand> getOndemand(String subject_id, semester, year) async {
    var convertSemester = "";
    if (semester == '3') {
      convertSemester = 's';
    } else {
      convertSemester = semester;
    }
    Ondemand ondemandList = Ondemand.fromJson({});
    try {
      var params = {
        "subject_id": subject_id,
        "semester": convertSemester,
        "year": year
      };
      // print('$ondemandurl/ondemand');
      // print('param->$params');
      var response2 = await Dio().post(
        '$ondemandurl/ondemand/',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(params),
      );
      // print(response2.data);
      if (response2.statusCode == 200) {
        // print(response2.data);
        ondemandList = Ondemand.fromJson(response2.data);
      } else {
        throw ('Error Get Data');
        // print('Error Get Data');
      }
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw (errorMessage);
      //กรณีไม่มีข้อมูลในระบบเลยจะคืนกลับมาใน error นี้
    }

    return ondemandList;
  }
}
