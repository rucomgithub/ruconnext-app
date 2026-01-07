import 'dart:convert';
import 'dart:io';
import 'package:th.ac.ru.uSmart/model/runews.dart';
import 'package:dio/dio.dart';
import '../exceptions/dioexception.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RunewsService {
  Dio dio = Dio();
  final runewsurl = dotenv.env['RUNEWS_URL'];
  Future<List<runews>> getAll() async {
    List<runews> runewsdata = [];
    try {
      var response = await dio.get(
        '$runewsurl/NewsRu/NewsJsonConnext',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        runewsdata = runews.decode(jsonEncode(response.data));
        // print('${jsonEncode(response.data)} Test Runews');
        // print(runewsdata[0].author.toString());
      } else {
        throw ('Error Get Data');
      }
    } on DioException catch (err) {
      final errorMessage = DioExceptionHandler.fromDioError(err).toString();
      throw (errorMessage);
    }

    return runewsdata;
  }
}
