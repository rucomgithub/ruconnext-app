import 'package:dio/dio.dart';
import 'package:th.ac.ru.uSmart/model/checkregis_model.dart';
import 'package:th.ac.ru.uSmart/model/counter_region_model.dart';
import 'package:th.ac.ru.uSmart/model/enroll_region_model.dart';
import 'package:th.ac.ru.uSmart/model/genqr_region_model.dart';
import 'package:th.ac.ru.uSmart/model/location_exam_model.dart';
import 'package:th.ac.ru.uSmart/model/message_region_model.dart';
import 'package:th.ac.ru.uSmart/model/region_login_model.dart';
import 'package:th.ac.ru.uSmart/model/ruregion_mr30_model.dart';
import 'package:th.ac.ru.uSmart/model/save_enroll_model.dart';
import 'package:th.ac.ru.uSmart/store/profileApp.dart';
import 'package:th.ac.ru.uSmart/store/ruregionApp_login.dart';
import '../model/ruregis_model.dart';
import '../model/calpay_model.dart';
import '../model/ruregis_fee_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'diointercepter.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/model/mr30_catalog.dart';
import 'package:th.ac.ru.uSmart/model/student.dart';
import 'package:th.ac.ru.uSmart/services/diointercepter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/profile.dart';
import '../store/profile.dart';

class RuregisService {
  final dioapi = DioIntercepter();
  final ruregisurl = dotenv.env['RUREGIS_API'];
  final ruregionurl = dotenv.env['RUREGION_API'];
  final appUrl = dotenv.env['APP_URL_DEV'];
  var stdcode ;
  var semester;
  var year;

  

  Future<Ruregis> getProfileRuregion(stdcode) async {
    Ruregis ruregisdata = Ruregis.fromJson({});
    try {
      await dioapi.createIntercepter();
      //   var response = await dioapi.api.get('$ruregisurl/profileApp.jsp?STUDENTID=6601602904',
      var response = await dioapi.api.get(
        '$ruregionurl/region_student_profile/$stdcode',
      );
      if (response.statusCode == 200) {
        //print('data ${response.data}');

        ruregisdata = Ruregis.fromJson(response.data);
        //print('data ${ruregisdata}');
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return ruregisdata;
  }

  Future<Ruregis> getProfileRuregis(stdcode) async {
    Ruregis ruregisdata = Ruregis.fromJson({});
    try {
      await dioapi.createIntercepter();
      //   var response = await dioapi.api.get('$ruregisurl/profileApp.jsp?STUDENTID=6601602904',
      var response = await dioapi.api.get(
        '$ruregionurl/region_student_profile/6299499991',
      );
      if (response.statusCode == 200) {
        print('datas ${response.data}');

        ruregisdata = Ruregis.fromJson(response.data);
        print('data ${ruregisdata}');
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      print(err);
      throw (err);
    }

    return ruregisdata;
  }

  Future<Summary_reg> postCalPayRegionApp(profile,sumcredit,numcourse,semester,year) async {
    Summary_reg registerdata = Summary_reg.fromJson({});
    Ruregis profileApp = await ProfileAppStorage.getProfileApp();
    try {
      var params = {
    "STD_CODE": profileApp.sTDCODE,
    "STUDY_SEMESTER": semester,
    "STUDY_YEAR": year, 
    "FACULTY_NO": profileApp.fACULTYNO,
    "MAJOR_NO": profileApp.mAJORNO, 
    "CAMPUS_NO": profileApp.cAMPUSNO, 
    "CURR_NO": profileApp.cURRNO, 
    "TOTAL_CREDIT": '11', 
    "NUM_COURSE": '4', 
    "GRADUATE_STATUS":  profileApp.gRADUATESTATUS, 
    "STD_STATUS_CURRENT": profileApp.sTDSTATUSCURRENT
    
    };
    //print('============================$params');
      await dioapi.createIntercepter();
      var response = await dioapi.api.post(
        '$ruregionurl/region_calculate_payment',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {
     //print('Response Get Data Summary : ${registerdata}');
        registerdata = Summary_reg.fromJson(response.data);
           
      } else {
        throw ('Error Get Data cal ');
      }
    } catch (err) {
      ////print(err);
      throw (err);
    }

    return registerdata;
  }
    Future<Ruregis> getProfileRuregionApp(stdcode) async {
      print('get profile');
    Ruregis ruregisdata = Ruregis.fromJson({});
    Loginregion profile = await RuregionAppLoginStorage.getProfile();
    print('data  ${profile.rec![0].username}');
    try {
      await dioapi.createIntercepter();
      //   var response = await dioapi.api.get('$ruregisurl/profileApp.jsp?STUDENTID=6601602904',
      var response = await dioapi.api.get(
        '$ruregionurl/region_student_profile/${profile.rec![0].username}',
      );
      if (response.statusCode == 200) {
        print('datas ${response.data}');

        ruregisdata = Ruregis.fromJson(response.data);
        print('data ${ruregisdata}');
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      print(err);
      throw (err);
    }

    return ruregisdata;
  }

    Future<Getenroll> getEnrollRegion(stdcode,sem,year) async {
    Getenroll ruregisdata = Getenroll.fromJson({});
    try {
      await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        '$ruregionurl/region_get_enroll_results/$stdcode/$sem/$year',
      );
      if (response.statusCode == 200) {
        //print('data ${response.data}');

        ruregisdata = Getenroll.fromJson(response.data);
        //print('data ${ruregisdata}');
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return ruregisdata;
  }

  Future<CounterRegion> getCounterAdmin(stdcode) async {
    CounterRegion counterregiondata = CounterRegion.fromJson({});
    try {
      await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        '$ruregionurl/region_system_control/$stdcode',
      );
      if (response.statusCode == 200) {
        //print('data ${response.data}');

        counterregiondata = CounterRegion.fromJson(response.data);
        //print('data ${counterregiondata}');
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return counterregiondata;
  }

  Future<MessageRegion> getMessageRegion(stdcode,sem,year) async {
    MessageRegion messageregiondata = MessageRegion.fromJson({});
    try {
      await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        '$ruregionurl/region_get_noti_message/$stdcode/$sem/$year',
      );
      if (response.statusCode == 200) {
        //print('data ${response.data}');

        messageregiondata = MessageRegion.fromJson(response.data);
        //print('data ${messageregiondata}');
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return messageregiondata;
  }

    Future<Genqr> getQRCODE(stdcode,sem,year,tel) async {
    Genqr genqrregiondata = Genqr.fromJson({});
    try {
      await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        '$ruregionurl/region_get_qr_payment/$stdcode/$sem/$year/$tel',
      );
      if (response.statusCode == 200) {
        //print('data ${response.data}');

        genqrregiondata = Genqr.fromJson(response.data);
        //print('data ${genqrregiondata}');
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return genqrregiondata;
  }

  Future<SaveEnroll> postQR(x) async {
    SaveEnroll enrolldata = SaveEnroll.fromJson({});

    try {
     
      await dioapi.createIntercepter();
      var response = await dioapi.api.post(
        '$ruregionurl/region_generate_qr',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(x),
      );
      if (response.statusCode == 200) {
     //print('Response Get Data Summary : ${enrolldata}');
        enrolldata = SaveEnroll.fromJson(response.data);
           
      } else {
        throw ('Error Get Data cal ');
      }
    } catch (err) {
      ////print(err);
      throw (err);
    }

    return enrolldata;
  }
 Future<SaveEnroll> postEnroll(x) async {
    SaveEnroll enrolldata = SaveEnroll.fromJson({});
    print(x);
    try {
     
      await dioapi.createIntercepter();
      var response = await dioapi.api.post(
        '$ruregionurl/region_save_enroll',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(x),
      );
      if (response.statusCode == 200) {
     //print('Response Get Data Summary : ${enrolldata}');
        enrolldata = SaveEnroll.fromJson(response.data);
           
      } else {
        throw ('Error Get Data cal ');
      }
    } catch (err) {
      ////print(err);
      throw (err);
    }

    return enrolldata;
  }

Future<Loginregion> postLogin(String username, String password) async {
    Loginregion logindata = Loginregion.fromJson({});
  //print('${username} ${password}');

  try {
    // Create FormData object
    FormData formData = FormData.fromMap({
      'username': username,
      'password': password,
    });

    await dioapi.createIntercepter();
    var response = await dioapi.api.post(
      'http://beta-e-service.ru.ac.th:88/api_loginReginal/login.php',
      data: formData,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
        },
      ),
    );

    if (response.statusCode == 200) {
       logindata = Loginregion.fromJson(response.data);
   
      // //print(res);

    
    } else {
      throw ('Error Get Data cal ');
    }
  } catch (err) {
    throw (err);
  }
  return logindata;

}

  Future<Summary_reg> postCalPayRegion(profile,sumcredit,numcourse,semester,year) async {
    Summary_reg registerdata = Summary_reg.fromJson({});

    try {
      var params = {
    "STD_CODE": profile.sTDCODE,
    "STUDY_SEMESTER": semester,
    "STUDY_YEAR": year, 
    "FACULTY_NO": profile.fACULTYNO,
    "MAJOR_NO": profile.mAJORNO, 
    "CAMPUS_NO": profile.cAMPUSNO, 
    "CURR_NO": profile.cURRNO, 
    "TOTAL_CREDIT": sumcredit.toString(), 
    "NUM_COURSE": numcourse.toString(), 
    "GRADUATE_STATUS":  profile.gRADUATESTATUS, 
    "STD_STATUS_CURRENT": profile.sTDSTATUSCURRENT
    
    };
    //print('============================$params');
      await dioapi.createIntercepter();
      var response = await dioapi.api.post(
        '$ruregionurl/region_calculate_payment',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {
     //print('Response Get Data Summary : ${registerdata}');
        registerdata = Summary_reg.fromJson(response.data);
           
      } else {
        throw ('Error Get Data cal ');
      }
    } catch (err) {
      ////print(err);
      throw (err);
    }

    return registerdata;
  }

  Future<Ruregisfee> getFeeRuregis() async {
    Ruregisfee ruregisfeedata = Ruregisfee.fromJson({});
    try {
      await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        '$ruregionurl/mregis/feejson.jsp?STUDENTID',
      );
      if (response.statusCode == 200) {
        ////print('dataFee ${response.data}');

        ruregisfeedata = Ruregisfee.fromJson(response.data);
        ////print('dataFee ${ruregisfeedata}');
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return ruregisfeedata;
  }

  Future<Locationexam> getLocationExam(stdcode,semester,year) async {
    Locationexam locationexamdata = Locationexam.fromJson({});
    try {
      await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        '$ruregionurl/region_exam_location/$stdcode/$semester/$year',
      );
      if (response.statusCode == 200) {
        //print('data location ${response.data}');

        locationexamdata = Locationexam.fromJson(response.data);
        //print('locationexamdata ${locationexamdata}');
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return locationexamdata;
  }

  Future<MR30RUREGION> getMR30RUREGION(stdcode,sem,year) async {
    MR30RUREGION ruregionmr30data = MR30RUREGION.fromJson({});
    try {
      await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        '$ruregionurl/region_course/$stdcode/$sem/$year',
      );
      if (response.statusCode == 200) {
        // //print('data mr30  ${response.data}');

        ruregionmr30data = MR30RUREGION.fromJson(response.data);
        // //print('data mr30  ${ruregionmr30data}');
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return ruregionmr30data;
  }//**************************************/
 Future<MR30RUREGION> getMR30RUREGIS(stdcode,sem,year) async {
    MR30RUREGION ruregionmr30data = MR30RUREGION.fromJson({});
    print('x');
    try {
      await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        // '$ruregionurl/region_course/$stdcode/$sem/$year',
        '$ruregionurl/region_course/6299499992/1/2567',
      );
      if (response.statusCode == 200) {
        print('data mr30  ${response.data}');

        ruregionmr30data = MR30RUREGION.fromJson(response.data);
        // //print('data mr30  ${ruregionmr30data}');
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
     throw ('Error Get Data');
    }

    return ruregionmr30data;
  }
  Future<Ruregis> checkCreditRuregis() async {
    Ruregis ruregisdata = Ruregis.fromJson({});
    try {
      await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        '$ruregisurl/chk_credit.jsp?STUDENTID',
      );
      if (response.statusCode == 200) {
        // //print('data ${response.data}');

        ruregisdata = Ruregis.fromJson(response.data);
        // //print('data ${ruregisdata}');
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return ruregisdata;
  }
}
