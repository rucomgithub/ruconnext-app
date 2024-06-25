class Register {
  String? stdCode;
  String? year;
  List<REGISTERECORD>? record;

  Register({this.stdCode, this.year, this.record});

  Register.fromJson(Map<String, dynamic> json) {
    stdCode = json['std_code'];
    year = json['year'];
    if (json['RECORD'] != null) {
      record = <REGISTERECORD>[];
      json['RECORD'].forEach((v) {
        record!.add(new REGISTERECORD.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['std_code'] = this.stdCode;
    data['year'] = this.year;
    if (this.record != null) {
      data['RECORD'] = this.record!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class REGISTERECORD {
  String? regisYear;
  String? regisSemester;
  String? courseNo;
  String? credit;

  REGISTERECORD({
    this.regisYear,
    this.regisSemester,
    this.courseNo,
    this.credit,
  });

  REGISTERECORD.fromJson(Map<String, dynamic> json) {
    regisYear = json['year'];
    regisSemester = json['semester'];
    courseNo = json['course_no'];
    credit = json['credit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.regisYear;
    data['semester'] = this.regisSemester;
    data['course_no'] = this.courseNo;
    data['credit'] = this.credit;
    return data;
  }
}

class REGISTERECORDVIEW {
  String? regisYear;
  String? regisSemester;
  String? courseNo;
  String? credit;
  String? startColor;
  String? endColor;
  String? imagePath;

  REGISTERECORDVIEW(
      {this.regisYear,
      this.regisSemester,
      this.courseNo,
      this.credit,
      this.startColor,
      this.endColor,
      this.imagePath});
}

