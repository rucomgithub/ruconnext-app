class RotcsExtend {
  String? studentCode;
  String? extendYear;
  String? code9;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  String? option5;
  String? option6;
  String? option7;
  String? option8;
  String? option9;
  String? optionOther;
  int? total;
  List<RotcsExtendDetail>? detail;

  RotcsExtend(
      {this.studentCode,
      this.extendYear,
      this.code9,
      this.option1,
      this.option2,
      this.option3,
      this.option4,
      this.option5,
      this.option6,
      this.option7,
      this.option8,
      this.option9,
      this.optionOther,
      this.total,
      this.detail});

  RotcsExtend.fromJson(Map<String, dynamic> json) {
    studentCode = json['studentCode'];
    extendYear = json['extendYear'];
    code9 = json['code9'];
    option1 = json['option1'];
    option2 = json['option2'];
    option3 = json['option3'];
    option4 = json['option4'];
    option5 = json['option5'];
    option6 = json['option6'];
    option7 = json['option7'];
    option8 = json['option8'];
    option9 = json['option9'];
    optionOther = json['optionOther'];
    total = json['total'];
    if (json['detail'] != null) {
      detail = <RotcsExtendDetail>[];
      json['detail'].forEach((v) {
        detail!.add(new RotcsExtendDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentCode'] = this.studentCode;
    data['extendYear'] = this.extendYear;
    data['code9'] = this.code9;
    data['option1'] = this.option1;
    data['option2'] = this.option2;
    data['option3'] = this.option3;
    data['option4'] = this.option4;
    data['option5'] = this.option5;
    data['option6'] = this.option6;
    data['option7'] = this.option7;
    data['option8'] = this.option8;
    data['option9'] = this.option9;
    data['optionOther'] = this.optionOther;
    data['total'] = this.total;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RotcsExtendDetail {
  String? id;
  String? registerYear;
  String? registerSemester;
  String? description;
  String? credit;
  String? created;
  String? modified;

  RotcsExtendDetail(
      {this.id,
      this.registerYear,
      this.registerSemester,
      this.credit,
      this.description,
      this.created,
      this.modified});

  RotcsExtendDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    registerYear = json['registerYear'];
    registerSemester = json['registerSemester'];
    credit = json['credit'];
    description = json['description'];
    created = json['created'];
    modified = json['modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['registerYear'] = this.registerYear;
    data['registerSemester'] = this.registerSemester;
    data['description'] = this.description;
    data['credit'] = this.credit;
    data['created'] = this.created;
    data['modified'] = this.modified;
    return data;
  }
}
