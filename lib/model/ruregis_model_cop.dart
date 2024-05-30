class Ruregis {
  String? mAJORNAMETHAI;
  String? cHKCERTNO;
  String? cAMPUSNO;
  String? sTDTYPE;
  String? errString;
  String? mAJORNO;
  String? sTDSTATUSCURRENT;
  String? cITIZENNO;
  String? fACULTYNO;
  String? sTDSTATUSDESC;
  String? bIRTHDATE;
  String? sTDCODE;
  String? cURRNO;
  String? cHKCERTNAMETHAI;
  String? codecolor;
  String? cURRNAMETHAI;
  String? rEGISOK;
  String? cAMPUSNAMETHAI;
  String? cERTLOCK;
  String? sTDTYPEDESCTHAI;
  String? eNROLLYEAR;
  String? eNROLLSEMESTER;
  bool? tF;
  String? fACULTYNAMETHAI;
  String? nAMETHAI;
  String? lIBRARYLOCK;
  String? mSG_STATUS;

  Ruregis(
      {this.mAJORNAMETHAI,
      this.cHKCERTNO,
      this.cAMPUSNO,
      this.sTDTYPE,
      this.errString,
      this.mAJORNO,
      this.sTDSTATUSCURRENT,
      this.cITIZENNO,
      this.fACULTYNO,
      this.sTDSTATUSDESC,
      this.bIRTHDATE,
      this.sTDCODE,
      this.cURRNO,
      this.cHKCERTNAMETHAI,
      this.codecolor,
      this.cURRNAMETHAI,
      this.rEGISOK,
      this.cAMPUSNAMETHAI,
      this.cERTLOCK,
      this.sTDTYPEDESCTHAI,
      this.eNROLLYEAR,
      this.eNROLLSEMESTER,
      this.tF,
      this.fACULTYNAMETHAI,
      this.nAMETHAI,
      this.lIBRARYLOCK,
      this.mSG_STATUS});

  Ruregis.fromJson(Map<String, dynamic> json) {
    mAJORNAMETHAI = json['MAJOR_NAME_THAI'];
    cHKCERTNO = json['CHK_CERT_NO'];
    cAMPUSNO = json['CAMPUS_NO'];
    sTDTYPE = json['STD_TYPE'];
    errString = json['errString'];
    mAJORNO = json['MAJOR_NO'];
    sTDSTATUSCURRENT = json['STD_STATUS_CURRENT'];
    cITIZENNO = json['CITIZEN_NO'];
    fACULTYNO = json['FACULTY_NO'];
    sTDSTATUSDESC = json['STD_STATUS_DESC'];
    bIRTHDATE = json['BIRTH_DATE'];
    sTDCODE = json['STD_CODE'];
    cURRNO = json['CURR_NO'];
    cHKCERTNAMETHAI = json['CHK_CERT_NAME_THAI'];
    codecolor = json['codecolor'];
    cURRNAMETHAI = json['CURR_NAME_THAI'];
    rEGISOK = json['REGIS_OK'];
    cAMPUSNAMETHAI = json['CAMPUS_NAME_THAI'];
    cERTLOCK = json['CERT_LOCK'];
    sTDTYPEDESCTHAI = json['STD_TYPE_DESC_THAI'];
    eNROLLYEAR = json['ENROLL_YEAR'];
    eNROLLSEMESTER = json['ENROLL_SEMESTER'];
    tF = json['TF'];
    fACULTYNAMETHAI = json['FACULTY_NAME_THAI'];
    nAMETHAI = json['NAME_THAI'];
    lIBRARYLOCK = json['LIBRARY_LOCK'];
    mSG_STATUS = json['MSG_STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MAJOR_NAME_THAI'] = this.mAJORNAMETHAI;
    data['CHK_CERT_NO'] = this.cHKCERTNO;
    data['CAMPUS_NO'] = this.cAMPUSNO;
    data['STD_TYPE'] = this.sTDTYPE;
    data['errString'] = this.errString;
    data['MAJOR_NO'] = this.mAJORNO;
    data['STD_STATUS_CURRENT'] = this.sTDSTATUSCURRENT;
    data['CITIZEN_NO'] = this.cITIZENNO;
    data['FACULTY_NO'] = this.fACULTYNO;
    data['STD_STATUS_DESC'] = this.sTDSTATUSDESC;
    data['BIRTH_DATE'] = this.bIRTHDATE;
    data['STD_CODE'] = this.sTDCODE;
    data['CURR_NO'] = this.cURRNO;
    data['CHK_CERT_NAME_THAI'] = this.cHKCERTNAMETHAI;
    data['codecolor'] = this.codecolor;
    data['CURR_NAME_THAI'] = this.cURRNAMETHAI;
    data['REGIS_OK'] = this.rEGISOK;
    data['CAMPUS_NAME_THAI'] = this.cAMPUSNAMETHAI;
    data['CERT_LOCK'] = this.cERTLOCK;
    data['STD_TYPE_DESC_THAI'] = this.sTDTYPEDESCTHAI;
    data['ENROLL_YEAR'] = this.eNROLLYEAR;
    data['ENROLL_SEMESTER'] = this.eNROLLSEMESTER;
    data['TF'] = this.tF;
    data['FACULTY_NAME_THAI'] = this.fACULTYNAMETHAI;
    data['NAME_THAI'] = this.nAMETHAI;
    data['LIBRARY_LOCK'] = this.lIBRARYLOCK;
    data['MSG_STATUS'] = this.mSG_STATUS;
    return data;
  }
}
