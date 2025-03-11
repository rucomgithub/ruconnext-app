import 'package:dio/dio.dart';
import 'package:th.ac.ru.uSmart/model/checkregis_model.dart';
import 'package:th.ac.ru.uSmart/model/counter_region_model.dart';
import 'package:th.ac.ru.uSmart/model/enroll_region_model.dart';
import 'package:th.ac.ru.uSmart/model/genqr_region_model.dart';
import 'package:th.ac.ru.uSmart/model/location_exam_model.dart';
import 'package:th.ac.ru.uSmart/model/message_region_model.dart';
import 'package:th.ac.ru.uSmart/model/region_login_model.dart';
import 'package:th.ac.ru.uSmart/model/ruregion_mr30_model.dart';
import 'package:th.ac.ru.uSmart/model/ruregion_profile_model.dart';
import 'package:th.ac.ru.uSmart/model/save_enroll_model.dart';
import 'package:th.ac.ru.uSmart/model/save_status.dart';
import 'package:th.ac.ru.uSmart/store/counterAdminRegion.dart';
import 'package:th.ac.ru.uSmart/store/feeApp.dart';
import 'package:th.ac.ru.uSmart/store/mr30App.dart';
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
  var stdcode;
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

  Future<Ruregionprofile> getProfileRegionApp(stdcode) async {
    Ruregionprofile ruregionprofiledata = Ruregionprofile.fromJson({});
    Loginregion profile = await RuregionAppLoginStorage.getProfile();
    try {
      await dioapi.createIntercepter();
      //   var response = await dioapi.api.get('$ruregisurl/profileApp.jsp?STUDENTID=6601602904',
      var response = await dioapi.api.get(
        '$ruregionurl/region_student_profile/${profile.rec![0].username}',
      );
      if (response.statusCode == 200) {
        print('datas ${response.data}');

        ruregionprofiledata = Ruregionprofile.fromJson(response.data);
        print('data ${ruregionprofiledata}');
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      print(err);
      throw (err);
    }

    return ruregionprofiledata;
  }

  Future<Summary_reg> postCalPayRegionApp() async {
    Summary_reg registerdata = Summary_reg.fromJson({});
    Ruregis profileApp = await ProfileAppStorage.getProfileApp();
    List<ResultsMr30> mr30App = await MR30AppStorage.getMR30App();
    CounterRegion counter = await CounterRegionAppStorage.getCounterRegionApp();
    int totalCredits = 0;

    for (var item in mr30App) {
      totalCredits += item.cREDIT!; // assuming item.credit is an int
    }
    List<Map<String, dynamic>> resultArray = mr30App.map((element) {
  return {
    'COURSENO': element.cOURSENO,
    'CREDIT': element.cREDIT,
  };
}).toList();
    print(totalCredits);
    print(resultArray);
    try {
      var params = {
        "STD_CODE": profileApp.sTDCODE,
        "STUDY_SEMESTER": counter.resultsCounter![0].sTUDYSEMESTER,
        "STUDY_YEAR": counter.resultsCounter![0].sTUDYYEAR,
        "FACULTY_NO": profileApp.fACULTYNO,
        "MAJOR_NO": profileApp.mAJORNO,
        "CAMPUS_NO": profileApp.cAMPUSNO,
        "CURR_NO": profileApp.cURRNO,
        "TOTAL_CREDIT": totalCredits.toString(),
        "NUM_COURSE": mr30App.length.toString(),
        "GRADUATE_STATUS": profileApp.gRADUATESTATUS,
        "STD_STATUS_CURRENT": profileApp.sTDSTATUSCURRENT,
        "ARR_COURSE" :resultArray
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
      print(err);
      throw (err);
    }

    return registerdata;
  }

  Future<Ruregis> getProfileRuregionApp(stdcode) async {
    print('get profile');
    Ruregis ruregisdata = Ruregis.fromJson({});
    Loginregion profile = await RuregionAppLoginStorage.getProfile();

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

  Future<CounterRegion> getCounterAdminRegionApp() async {
    CounterRegion counterregiondata = CounterRegion.fromJson({});
    Loginregion profile = await RuregionAppLoginStorage.getProfile();

    try {
      await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        '$ruregionurl/region_system_control/${profile.rec![0].username}',
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


Future<SaveStatus> saveStatusApp() async {
    CounterRegion counterregiondata = CounterRegion.fromJson({});
    Loginregion profile = await RuregionAppLoginStorage.getProfile();
    SaveStatus savestatus = SaveStatus.fromJson({});

    try {
      await dioapi.createIntercepter();
      var responsecounter = await dioapi.api.get(
        '$ruregionurl/region_system_control/${profile.rec![0].username}',
      );
      if (responsecounter.statusCode == 200) {
        //print('data ${response.data}');

        counterregiondata = CounterRegion.fromJson(responsecounter.data);
          await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        '$ruregionurl/region_save_status/${profile.rec![0].username}/${counterregiondata.resultsCounter![0].sTUDYSEMESTER}/${counterregiondata.resultsCounter![0].sTUDYYEAR}',
      );
      if (response.statusCode == 200) {
        //print('data ${response.data}');

        savestatus = SaveStatus.fromJson(response.data);
      } else {
        throw ('Error Get Data');
      }
    
     
      }
    } catch (err) {
      //print(err);
      throw (err);
    }

    return savestatus;
  }

  // Future<SaveStatus> saveStatusApp2() async {
  //   SaveStatus savestatus = SaveStatus.fromJson({});
  //   Loginregion profile = await RuregionAppLoginStorage.getProfile();
  //   CounterRegion counter = await CounterRegionAppStorage.getCounterRegionApp();

  //   try {
  //     await dioapi.createIntercepter();
  //     var response = await dioapi.api.get(
  //       '$ruregionurl/region_save_status/${profile.rec![0].username}/${counter.resultsCounter![0].sTUDYSEMESTER}/${counter.resultsCounter![0].sTUDYYEAR}',
  //     );
  //     if (response.statusCode == 200) {
  //       //print('data ${response.data}');

  //       savestatus = SaveStatus.fromJson(response.data);
  //       //print('data ${counterregiondata}');
  //     } else {
  //       throw ('Error Get Data');
  //     }
  //   } catch (err) {
  //     //print(err);
  //     throw (err);
  //   }

  //   return savestatus;
  // }

  Future<Getenroll> getEnrollRegion(stdcode, sem, year) async {
    Getenroll ruregisdata = Getenroll.fromJson({});
    Loginregion profile = await RuregionAppLoginStorage.getProfile();
    CounterRegion counter = await CounterRegionAppStorage.getCounterRegionApp();

    try {
      await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        '$ruregionurl/region_get_enroll_results/${profile.rec![0].username}/${counter.resultsCounter![0].sTUDYSEMESTER}/${counter.resultsCounter![0].sTUDYYEAR}',
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

   Future<Getenroll> getEnrollRegionApp() async {
    Getenroll ruregisdata = Getenroll.fromJson({});
    Loginregion profile = await RuregionAppLoginStorage.getProfile();
    CounterRegion counter = await CounterRegionAppStorage.getCounterRegionApp();

    try {
      await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        '$ruregionurl/region_get_enroll_results/${profile.rec![0].username}/${counter.resultsCounter![0].sTUDYSEMESTER}/${counter.resultsCounter![0].sTUDYYEAR}',
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

  Future<MessageRegion> getMessageRegion(stdcode, sem, year) async {
    MessageRegion messageregiondata = MessageRegion.fromJson({});
    CounterRegion counter = await CounterRegionAppStorage.getCounterRegionApp();
    print(counter.resultsCounter![0].sTUDYYEAR);
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

  Future<Genqr> getQRCODE(stdcode, sem, year, tel) async {
    Genqr genqrregiondata = Genqr.fromJson({});
    CounterRegion counter = await CounterRegionAppStorage.getCounterRegionApp();
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

  Future<Genqr> getQRCODEApp() async {
    Genqr genqrregiondata = Genqr.fromJson({});
    Ruregis profiles = await ProfileAppStorage.getProfileApp();
    CounterRegion counter = await CounterRegionAppStorage.getCounterRegionApp();
    try {
      await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        '$ruregionurl/region_get_qr_payment/${profiles.sTDCODE}/${counter.resultsCounter![0].sTUDYSEMESTER}/${counter.resultsCounter![0].sTUDYYEAR}/${profiles.mOBILETELEPHONE}',
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

   Future<SaveEnroll> postQRApp() async {
    SaveEnroll enrolldata = SaveEnroll.fromJson({});
    Ruregis profiles = await ProfileAppStorage.getProfileApp();
    CounterRegion counter = await CounterRegionAppStorage.getCounterRegionApp();

      var params = {
      "STD_CODE": profiles.sTDCODE,
      "STUDY_SEMESTER": '${counter.resultsCounter![0].sTUDYSEMESTER}',
      "STUDY_YEAR": '${counter.resultsCounter![0].sTUDYYEAR}',
      "TELEPHONE_NO": profiles.mOBILETELEPHONE
    };

    try {
      await dioapi.createIntercepter();
      var response = await dioapi.api.post(
        '$ruregionurl/region_generate_qr',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(params),
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

  Future<SaveEnroll> postEnrollApp(gradstatus, examlocation) async {
    SaveEnroll enrolldata = SaveEnroll.fromJson({});
    Loginregion profile = await RuregionAppLoginStorage.getProfile();
    List<ResultsMr30> mr30App = await MR30AppStorage.getMR30App();
    Summary_reg fee = await FeeRuregionAppStorage.getFeeregionApp();
    CounterRegion counter = await CounterRegionAppStorage.getCounterRegionApp();
    Ruregis profiles = await ProfileAppStorage.getProfileApp();

    if (gradstatus == true) {
      gradstatus = 1;
    } else if (gradstatus == false) {
      gradstatus = 0;
    }

    Map<String, dynamic> jsonCourse = {
      "STD_CODE": "",
      "COURSE_NO": "",
      "CREDIT": ""
    };
    var arrCourse = [];
    mr30App.forEach((element) => {
          jsonCourse = {
            "STD_CODE": profile.rec![0].username,
            "COURSE_NO": element.cOURSENO,
            "CREDIT": (element.cREDIT.toString())
          },
          arrCourse.add(jsonCourse)
        });

    Map<String, dynamic> jsonFee = {
      "FEE_NO": "",
      "FEE_NAME": "",
      "FEE_AMOUNT": "",
      "FEE_TYPE": ""
    };
    var arrFee = [];
    fee.results!.forEach((element) => {
          jsonFee = {
            "FEE_NO": element.fEENO,
            "FEE_NAME": element.fEENAME,
            "FEE_AMOUNT": element.fEEAMOUNT,
            "FEE_TYPE": null
          },
          arrFee.add(jsonFee)
        });

    var params = {
      "STD_CODE": profile.rec![0].username,
      "FISCAL_YEAR": "${counter.resultsCounter![0].fISCALYEAR}",
      "STUDY_YEAR": "${counter.resultsCounter![0].sTUDYYEAR}",
      "STUDY_SEMESTER": "${counter.resultsCounter![0].sTUDYSEMESTER}",
      "TOTAL_AMOUNT": "${fee.sumTotal}",
      "NEAR_GRADUATE": "$gradstatus",
      "TELEPHONE_NO": "${profiles.mOBILETELEPHONE}",
      "STD_STATUS_CURRENT": "${profiles.sTDSTATUSCURRENT}",
      "REGIONAL_EXAM_NO": "$examlocation",
      "ENROLL_DATA": arrCourse,
      "FEE_DETAIL": arrFee
    };
    print('data  ${params}');
    try {
      await dioapi.createIntercepter();
      var response = await dioapi.api.post(
        '$ruregionurl/region_save_enroll',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(params),
      );
      print('Response Get Data Summary : ${response}');
      if (response.statusCode == 200) {
        print('Response Get Data Summary : ${response.statusCode}');
        enrolldata = SaveEnroll.fromJson(response.data);
      } else {
        throw ('Error Get Data cal ');
      }
    } catch (err) {
      print(err);
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

  Future<Summary_reg> postCalPayRegion(
      profile, sumcredit, numcourse, semester, year,resultArray) async {
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
        "GRADUATE_STATUS": profile.gRADUATESTATUS,
        "STD_STATUS_CURRENT": profile.sTDSTATUSCURRENT,
        "ARR_COURSE" :resultArray
    
      };
      print('============================$params');
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

  Future<Locationexam> getLocationExam(stdcode, semester, year) async {
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

    Future<Locationexam> getLocationExamApp() async {
    Locationexam locationexamdata = Locationexam.fromJson({});
    Loginregion profile = await RuregionAppLoginStorage.getProfile();
    CounterRegion counter = await CounterRegionAppStorage.getCounterRegionApp();
    try {
      await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        '$ruregionurl/region_exam_location/${profile.rec![0].username}/${counter.resultsCounter![0].sTUDYSEMESTER}/${counter.resultsCounter![0].sTUDYYEAR}',
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

  Future<MR30RUREGION> getMR30RUREGION(stdcode, sem, year) async {
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
  } //**************************************/

  Future<MR30RUREGION> getMR30RUREGIS(stdcode, sem, year) async {
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

    Future<MR30RUREGION> getMR30RUREGIONAPP() async {
    MR30RUREGION ruregionmr30data = MR30RUREGION.fromJson({});
    Loginregion profile = await RuregionAppLoginStorage.getProfile();
    CounterRegion counter = await CounterRegionAppStorage.getCounterRegionApp();

    try {
      await dioapi.createIntercepter();
      var response = await dioapi.api.get(
        // '$ruregionurl/region_course/$stdcode/$sem/$year',
        '$ruregionurl/region_course/${profile.rec![0].username}/${counter.resultsCounter![0].sTUDYSEMESTER}/${counter.resultsCounter![0].sTUDYYEAR}',
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
