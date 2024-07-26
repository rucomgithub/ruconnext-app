class Student {
  String? stdcode = '';
  String? namethai = '';
  String? nameeng = '';
  String? birthdate = '';
  String? stdstatusdescthai = '';
  String? citizenid = '';
  String? regionalnamethai = '';
  String? stdtypedescthai = '';
  String? facultynamethai = '';
  String? majornamethai = '';
  String? waivedno = '';
  String? waivedpaid = '';
  int? waivedtotalcredit = 0;
  String? chkcertnamethai = '';
  String? penalnamethai = '';
  String? mobiletelephone = '';
  String? emailaddress = '';

  Student(
      {this.stdcode,
      this.namethai,
      this.nameeng,
      this.birthdate,
      this.stdstatusdescthai,
      this.citizenid,
      this.regionalnamethai,
      this.stdtypedescthai,
      this.facultynamethai,
      this.majornamethai,
      this.waivedno,
      this.waivedpaid,
      this.waivedtotalcredit,
      this.chkcertnamethai,
      this.penalnamethai,
      this.mobiletelephone,
      this.emailaddress});

  Student.fromJson(Map<String, dynamic> json) {
    stdcode = json['STD_CODE'];
    namethai = json['NAME_THAI'];
    nameeng = json['NAME_ENG'];
    birthdate = json['BIRTH_DATE'];
    stdstatusdescthai = json['STD_STATUS_DESC_THAI'];
    citizenid = json['CITIZEN_ID'];
    regionalnamethai = json['REGIONAL_NAME_THAI'];
    stdtypedescthai = json['STD_TYPE_DESC_THAI'];
    facultynamethai = json['FACULTY_NAME_THAI'];
    majornamethai = json['MAJOR_NAME_THAI'];
    waivedno = json['WAIVED_NO'];
    waivedpaid = json['WAIVED_PAID'];
    waivedtotalcredit = json['WAIVED_TOTAL_CREDIT'];
    chkcertnamethai = json['CHK_CERT_NAME_THAI'];
    penalnamethai = json['PENAL_NAME_THAI'];
    mobiletelephone = json['MOBILE_TELEPHONE'];
    emailaddress = json['EMAIL_ADDRESS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STD_CODE'] = this.stdcode;
    data['NAME_THAI'] = this.namethai;
    data['NAME_ENG'] = this.nameeng;
    data['BIRTH_DATE'] = this.birthdate;
    data['STD_STATUS_DESC_THAI'] = this.stdstatusdescthai;
    data['CITIZEN_ID'] = this.citizenid;
    data['REGIONAL_NAME_THAI'] = this.regionalnamethai;
    data['STD_TYPE_DESC_THAI'] = this.stdtypedescthai;
    data['FACULTY_NAME_THAI'] = this.facultynamethai;
    data['MAJOR_NAME_THAI'] = this.majornamethai;
    data['WAIVED_NO'] = this.waivedno;
    data['WAIVED_PAID'] = this.waivedpaid;
    data['WAIVED_TOTAL_CREDIT'] = this.waivedtotalcredit;
    data['CHK_CERT_NAME_THAI'] = this.chkcertnamethai;
    data['PENAL_NAME_THAI'] = this.penalnamethai;
    data['MOBILE_TELEPHONE'] = this.mobiletelephone;
    data['EMAIL_ADDRESS'] = this.emailaddress;
    return data;
  }
}
