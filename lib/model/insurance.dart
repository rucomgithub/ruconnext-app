class Insurance {
  String? studentCode = '';
  int? total = 0;
  List<Detail>? detail = [];

  Insurance({this.studentCode, this.total, this.detail});

  Insurance.fromJson(Map<String, dynamic> json) {
    studentCode = json['StudentCode'];
    total = json['Total'];
    if (json['Detail'] != null) {
      detail = <Detail>[];
      json['Detail'].forEach((v) {
        detail!.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StudentCode'] = this.studentCode;
    data['Total'] = this.total;
    if (this.detail != null) {
      data['Detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  String? studentCode;
  String? personCode;
  String? nameInsurance;
  String? startDate;
  String? endDate;
  String? statusInsurance;
  String? typeInsurance;
  String? yearMonth;
  String? expire;

  Detail(
      {this.studentCode,
      this.personCode,
      this.nameInsurance,
      this.startDate,
      this.endDate,
      this.statusInsurance,
      this.typeInsurance,
      this.yearMonth,
      this.expire});

  Detail.fromJson(Map<String, dynamic> json) {
    studentCode = json['StudentCode'];
    personCode = json['PersonCode'];
    nameInsurance = json['NameInsurance'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    statusInsurance = json['StatusInsurance'];
    typeInsurance = json['TypeInsurance'];
    yearMonth = json['YearMonth'];
    expire = json['Expire'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StudentCode'] = this.studentCode;
    data['PersonCode'] = this.personCode;
    data['NameInsurance'] = this.nameInsurance;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['StatusInsurance'] = this.statusInsurance;
    data['TypeInsurance'] = this.typeInsurance;
    data['YearMonth'] = this.yearMonth;
    data['Expire'] = this.expire;
    return data;
  }
}
