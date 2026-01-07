class Ruregionprofile {
  bool? success;
  String? message;
  String? cHKCERTNO;
  String? sTDSTATUSCURRENT;
  String? pENALNO;
  String? nAMETHAI;
  String? sTDSTATUSDESCTHAI;
  String? fACULTYNAMETHAI;
  String? mAJORNAMETHAI;
  String? mAJORNO;
  String? eNROLLYEAR;
  String? fACULTYNO;
  String? eNROLLSEMESTER;
  String? cERTLOCK;
  String? cURRNO;
  String? lIBRARYLOCK;
  bool? gRADUATESTATUS;
  String? mOBILETELEPHONE;
  String? eRRMSG;
  bool? rEGISSTATUS;

  Ruregionprofile(
      {this.success,
      this.message,
      this.cHKCERTNO,
      this.sTDSTATUSCURRENT,
      this.pENALNO,
      this.nAMETHAI,
      this.sTDSTATUSDESCTHAI,
      this.fACULTYNAMETHAI,
      this.mAJORNAMETHAI,
      this.mAJORNO,
      this.eNROLLYEAR,
      this.fACULTYNO,
      this.eNROLLSEMESTER,
      this.cERTLOCK,
      this.cURRNO,
      this.lIBRARYLOCK,
      this.gRADUATESTATUS,
      this.mOBILETELEPHONE,
      this.eRRMSG,
      this.rEGISSTATUS});

  Ruregionprofile.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    cHKCERTNO = json['CHK_CERT_NO'];
    sTDSTATUSCURRENT = json['STD_STATUS_CURRENT'];
    pENALNO = json['PENAL_NO'];
    nAMETHAI = json['NAME_THAI'];
    sTDSTATUSDESCTHAI = json['STD_STATUS_DESC_THAI'];
    fACULTYNAMETHAI = json['FACULTY_NAME_THAI'];
    mAJORNAMETHAI = json['MAJOR_NAME_THAI'];
    mAJORNO = json['MAJOR_NO'];
    eNROLLYEAR = json['ENROLL_YEAR'];
    fACULTYNO = json['FACULTY_NO'];
    eNROLLSEMESTER = json['ENROLL_SEMESTER'];
    cERTLOCK = json['CERT_LOCK'];
    cURRNO = json['CURR_NO'];
    lIBRARYLOCK = json['LIBRARY_LOCK'];
    gRADUATESTATUS = json['GRADUATE_STATUS'];
    mOBILETELEPHONE = json['MOBILE_TELEPHONE'];
    eRRMSG = json['ERR_MSG'];
    rEGISSTATUS = json['REGIS_STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['CHK_CERT_NO'] = this.cHKCERTNO;
    data['STD_STATUS_CURRENT'] = this.sTDSTATUSCURRENT;
    data['PENAL_NO'] = this.pENALNO;
    data['NAME_THAI'] = this.nAMETHAI;
    data['STD_STATUS_DESC_THAI'] = this.sTDSTATUSDESCTHAI;
    data['FACULTY_NAME_THAI'] = this.fACULTYNAMETHAI;
    data['MAJOR_NAME_THAI'] = this.mAJORNAMETHAI;
    data['MAJOR_NO'] = this.mAJORNO;
    data['ENROLL_YEAR'] = this.eNROLLYEAR;
    data['FACULTY_NO'] = this.fACULTYNO;
    data['ENROLL_SEMESTER'] = this.eNROLLSEMESTER;
    data['CERT_LOCK'] = this.cERTLOCK;
    data['CURR_NO'] = this.cURRNO;
    data['LIBRARY_LOCK'] = this.lIBRARYLOCK;
    data['GRADUATE_STATUS'] = this.gRADUATESTATUS;
    data['MOBILE_TELEPHONE'] = this.mOBILETELEPHONE;
    data['ERR_MSG'] = this.eRRMSG;
    data['REGIS_STATUS'] = this.rEGISSTATUS;
    return data;
  }
}
