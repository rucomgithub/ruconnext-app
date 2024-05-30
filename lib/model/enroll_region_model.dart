class Getenroll {
  bool? success;
  String? message;
  bool? rEGISSTATUS;
  List<ReceiptRegionalResults>? receiptRegionalResults;
  List<ReceiptRu24RegionalResults>? receiptRu24RegionalResults;
  List<ReceiptDetailRegionalResults>? receiptDetailRegionalResults;

  Getenroll(
      {this.success,
      this.message,
      this.rEGISSTATUS,
      this.receiptRegionalResults,
      this.receiptRu24RegionalResults,
      this.receiptDetailRegionalResults});

  Getenroll.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    rEGISSTATUS = json['REGIS_STATUS'];
    if (json['receipt_regional_results'] != null) {
      receiptRegionalResults = <ReceiptRegionalResults>[];
      json['receipt_regional_results'].forEach((v) {
        receiptRegionalResults!.add(new ReceiptRegionalResults.fromJson(v));
      });
    }
    if (json['receipt_ru24_regional_results'] != null) {
      receiptRu24RegionalResults = <ReceiptRu24RegionalResults>[];
      json['receipt_ru24_regional_results'].forEach((v) {
        receiptRu24RegionalResults!
            .add(new ReceiptRu24RegionalResults.fromJson(v));
      });
    }
    if (json['receipt_detail_regional_results'] != null) {
      receiptDetailRegionalResults = <ReceiptDetailRegionalResults>[];
      json['receipt_detail_regional_results'].forEach((v) {
        receiptDetailRegionalResults!
            .add(new ReceiptDetailRegionalResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['REGIS_STATUS'] = this.rEGISSTATUS;
    if (this.receiptRegionalResults != null) {
      data['receipt_regional_results'] =
          this.receiptRegionalResults!.map((v) => v.toJson()).toList();
    }
    if (this.receiptRu24RegionalResults != null) {
      data['receipt_ru24_regional_results'] =
          this.receiptRu24RegionalResults!.map((v) => v.toJson()).toList();
    }
    if (this.receiptDetailRegionalResults != null) {
      data['receipt_detail_regional_results'] =
          this.receiptDetailRegionalResults!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReceiptRegionalResults {
  String? rECEIPTYEAR;
  String? rECEIPTSEMESTER;
  String? sTDCODE;
  String? rECEIPTDATE;
  String? rECEIPTTIME;
  String? cOUNTERRECEIPTNO;
  int? tOTALAMOUNT;
  int? rEGIONALNO;
  String? nEARGRADUATE;
  int? rEGISGROUPNO;
  String? eXAMLOCATION;
  String? uPDATEDATE;

  ReceiptRegionalResults(
      {this.rECEIPTYEAR,
      this.rECEIPTSEMESTER,
      this.sTDCODE,
      this.rECEIPTDATE,
      this.rECEIPTTIME,
      this.cOUNTERRECEIPTNO,
      this.tOTALAMOUNT,
      this.rEGIONALNO,
      this.nEARGRADUATE,
      this.rEGISGROUPNO,
      this.eXAMLOCATION,
      this.uPDATEDATE});

  ReceiptRegionalResults.fromJson(Map<String, dynamic> json) {
    rECEIPTYEAR = json['RECEIPT_YEAR'];
    rECEIPTSEMESTER = json['RECEIPT_SEMESTER'];
    sTDCODE = json['STD_CODE'];
    rECEIPTDATE = json['RECEIPT_DATE'];
    rECEIPTTIME = json['RECEIPT_TIME'];
    cOUNTERRECEIPTNO = json['COUNTER_RECEIPT_NO'];
    tOTALAMOUNT = json['TOTAL_AMOUNT'];
    rEGIONALNO = json['REGIONAL_NO'];
    nEARGRADUATE = json['NEAR_GRADUATE'];
    rEGISGROUPNO = json['REGIS_GROUP_NO'];
    eXAMLOCATION = json['EXAM_LOCATION'];
    uPDATEDATE = json['UPDATE_DATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RECEIPT_YEAR'] = this.rECEIPTYEAR;
    data['RECEIPT_SEMESTER'] = this.rECEIPTSEMESTER;
    data['STD_CODE'] = this.sTDCODE;
    data['RECEIPT_DATE'] = this.rECEIPTDATE;
    data['RECEIPT_TIME'] = this.rECEIPTTIME;
    data['COUNTER_RECEIPT_NO'] = this.cOUNTERRECEIPTNO;
    data['TOTAL_AMOUNT'] = this.tOTALAMOUNT;
    data['REGIONAL_NO'] = this.rEGIONALNO;
    data['NEAR_GRADUATE'] = this.nEARGRADUATE;
    data['REGIS_GROUP_NO'] = this.rEGISGROUPNO;
    data['EXAM_LOCATION'] = this.eXAMLOCATION;
    data['UPDATE_DATE'] = this.uPDATEDATE;
    return data;
  }
}

class ReceiptRu24RegionalResults {
  String? yEAR;
  String? sEMESTER;
  String? sTDCODE;
  String? cOURSENO;
  int? cREDIT;
  int? rEGISGROUPNO;
  String? eXAMDATE;
  String? eXAMPERIOD;
  String? dUPEXAM;
  String? eXAMDATEPERIOD;

  ReceiptRu24RegionalResults(
      {this.yEAR,
      this.sEMESTER,
      this.sTDCODE,
      this.cOURSENO,
      this.cREDIT,
      this.rEGISGROUPNO,
      this.eXAMDATE,
      this.eXAMPERIOD,
      this.dUPEXAM,
      this.eXAMDATEPERIOD});

  ReceiptRu24RegionalResults.fromJson(Map<String, dynamic> json) {
    yEAR = json['YEAR'];
    sEMESTER = json['SEMESTER'];
    sTDCODE = json['STD_CODE'];
    cOURSENO = json['COURSE_NO'];
    cREDIT = json['CREDIT'];
    rEGISGROUPNO = json['REGIS_GROUP_NO'];
    eXAMDATE = json['EXAM_DATE'];
    eXAMPERIOD = json['EXAM_PERIOD'];
    dUPEXAM = json['DUP_EXAM'];
    eXAMDATEPERIOD = json['EXAM_DATE_PERIOD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['YEAR'] = this.yEAR;
    data['SEMESTER'] = this.sEMESTER;
    data['STD_CODE'] = this.sTDCODE;
    data['COURSE_NO'] = this.cOURSENO;
    data['CREDIT'] = this.cREDIT;
    data['REGIS_GROUP_NO'] = this.rEGISGROUPNO;
    data['EXAM_DATE'] = this.eXAMDATE;
    data['EXAM_PERIOD'] = this.eXAMPERIOD;
    data['DUP_EXAM'] = this.dUPEXAM;
    data['EXAM_DATE_PERIOD'] = this.eXAMDATEPERIOD;
    return data;
  }
}

class ReceiptDetailRegionalResults {
  String? rECEIPTYEAR;
  String? rECEIPTSEMESTER;
  String? sTDCODE;
  String? fISCALYEAR;
  String? cOUNTERNO;
  String? rECEIPTNO;
  int? fEENO;
  String? fEENAME;
  int? fEEAMOUNT;
  String? uPDATEDATE;

  ReceiptDetailRegionalResults(
      {this.rECEIPTYEAR,
      this.rECEIPTSEMESTER,
      this.sTDCODE,
      this.fISCALYEAR,
      this.cOUNTERNO,
      this.rECEIPTNO,
      this.fEENO,
      this.fEENAME,
      this.fEEAMOUNT,
      this.uPDATEDATE});

  ReceiptDetailRegionalResults.fromJson(Map<String, dynamic> json) {
    rECEIPTYEAR = json['RECEIPT_YEAR'];
    rECEIPTSEMESTER = json['RECEIPT_SEMESTER'];
    sTDCODE = json['STD_CODE'];
    fISCALYEAR = json['FISCAL_YEAR'];
    cOUNTERNO = json['COUNTER_NO'];
    rECEIPTNO = json['RECEIPT_NO'];
    fEENO = json['FEE_NO'];
    fEENAME = json['FEE_NAME'];
    fEEAMOUNT = json['FEE_AMOUNT'];
    uPDATEDATE = json['UPDATE_DATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RECEIPT_YEAR'] = this.rECEIPTYEAR;
    data['RECEIPT_SEMESTER'] = this.rECEIPTSEMESTER;
    data['STD_CODE'] = this.sTDCODE;
    data['FISCAL_YEAR'] = this.fISCALYEAR;
    data['COUNTER_NO'] = this.cOUNTERNO;
    data['RECEIPT_NO'] = this.rECEIPTNO;
    data['FEE_NO'] = this.fEENO;
    data['FEE_NAME'] = this.fEENAME;
    data['FEE_AMOUNT'] = this.fEEAMOUNT;
    data['UPDATE_DATE'] = this.uPDATEDATE;
    return data;
  }
}
