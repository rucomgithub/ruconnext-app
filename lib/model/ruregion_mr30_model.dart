import 'dart:convert';

class MR30RUREGION {
  bool? success;
  String? message;
  bool? rEGISSTATUS;
  List<ResultsMr30>? results;

  MR30RUREGION({this.success, this.message, this.results});

  MR30RUREGION.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    rEGISSTATUS = json['REGIS_STATUS'];
    if (json['results'] != null) {
      results = <ResultsMr30>[];
      json['results'].forEach((v) {
        results!.add(new ResultsMr30.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
     data['REGIS_STATUS'] = this.rEGISSTATUS;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultsMr30 {
  String? rEGISYEAR;
  String? rEGISSEMESTER;
  String? cAMPUSNO;
  String? sTDTYPE;
  String? cOURSENO;
  int? cREDIT;
  int? sECTIONNO;
  String? eXAMDATE;
  String? eXAMPERIOD;
  String? eXAMDATESHOT;
  String? cOURSENAME;
  String? cOURSEDUP;

  ResultsMr30(
      {this.rEGISYEAR,
      this.rEGISSEMESTER,
      this.cAMPUSNO,
      this.sTDTYPE,
      this.cOURSENO,
      this.cREDIT,
      this.sECTIONNO,
      this.eXAMDATE,
      this.eXAMPERIOD,
      this.eXAMDATESHOT,
      this.cOURSENAME,
      this.cOURSEDUP});

  ResultsMr30.fromJson(Map<String, dynamic> json) {
    rEGISYEAR = json['REGIS_YEAR'];
    rEGISSEMESTER = json['REGIS_SEMESTER'];
    cAMPUSNO = json['CAMPUS_NO'];
    sTDTYPE = json['STD_TYPE'];
    cOURSENO = json['COURSE_NO'];
    cREDIT = json['CREDIT'];
    sECTIONNO = json['SECTION_NO'];
    eXAMDATE = json['EXAM_DATE'];
    eXAMPERIOD = json['EXAM_PERIOD'];
    eXAMDATESHOT = json['EXAM_DATE_SHOT'];
    cOURSENAME = json['COURSE_NAME'];
    cOURSEDUP = json['COURSE_DUP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['REGIS_YEAR'] = this.rEGISYEAR;
    data['REGIS_SEMESTER'] = this.rEGISSEMESTER;
    data['CAMPUS_NO'] = this.cAMPUSNO;
    data['STD_TYPE'] = this.sTDTYPE;
    data['COURSE_NO'] = this.cOURSENO;
    data['CREDIT'] = this.cREDIT;
    data['SECTION_NO'] = this.sECTIONNO;
    data['EXAM_DATE'] = this.eXAMDATE;
    data['EXAM_PERIOD'] = this.eXAMPERIOD;
    data['EXAM_DATE_SHOT'] = this.eXAMDATESHOT;
    data['COURSE_NAME'] = this.cOURSENAME;
    data['COURSE_DUP'] = this.cOURSEDUP;
    return data;
  }


  static List<ResultsMr30> decode(String mr30ruregion) =>
      (json.decode(mr30ruregion) as List<dynamic>)
          .map<ResultsMr30>((item) => ResultsMr30.fromJson(item))
          .toList();
}
