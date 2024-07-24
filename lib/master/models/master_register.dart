class MasterRegister {
  String? stdCode;
  String? year;
  List<REGISTERECORD>? record;

  MasterRegister({this.stdCode, this.year, this.record});

  MasterRegister.fromJson(Map<String, dynamic> json) {
    stdCode = json['std_code'];
    year = json['year'];
    if (json['register'] != null) {
      record = <REGISTERECORD>[];
      json['register'].forEach((v) {
        record!.add(new REGISTERECORD.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['std_code'] = this.stdCode;
    data['year'] = this.year;
    if (this.record != null) {
      data['register'] = this.record!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class REGISTERECORD {
  String? year;
  String? semester;
  String? stdCode;
  String? courseNo;
  int? credit;

  REGISTERECORD({
    this.year,
    this.semester,
    this.stdCode,
    this.courseNo,
    this.credit,
  });

  REGISTERECORD.fromJson(Map<String, dynamic> json) {
    year = json['YEAR'];
    semester = json['SEMESTER'];
    stdCode = json['STD_CODE'];
    courseNo = json['COURSE_NO'];
    credit = json['CREDIT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['YEAR'] = this.year;
    data['SEMESTER'] = this.semester;
    data['STD_CODE'] = this.stdCode;
    data['COURSE_NO'] = this.courseNo;
    data['CREDIT'] = this.credit;
    return data;
  }
}

class REGISTERECORDVIEW {
  String? startColor;
  String? endColor;
  String? imagePath;
  String? year;
  String? semester;
  String? stdCode;
  String? courseNo;
  int? credit;

  REGISTERECORDVIEW(
      {this.year,
      this.semester,
      this.stdCode,
      this.courseNo,
      this.credit,
      this.startColor,
      this.endColor,
      this.imagePath});
}
