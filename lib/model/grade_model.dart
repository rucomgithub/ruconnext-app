class Grade {
  String? stdCode;
  String? year;
  List<RECORD>? record;

  Grade({this.stdCode, this.year, this.record});

  Grade.fromJson(Map<String, dynamic> json) {
    stdCode = json['std_code'];
    year = json['year'];
    if (json['RECORD'] != null) {
      record = <RECORD>[];
      json['RECORD'].forEach((v) {
        record!.add(new RECORD.fromJson(v));
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

class RECORD {
  String? regisYear;
  String? regisSemester;
  String? courseNo;
  String? credit;
  String? grade;

  RECORD(
      {this.regisYear,
      this.regisSemester,
      this.courseNo,
      this.credit,
      this.grade});

  RECORD.fromJson(Map<String, dynamic> json) {
    regisYear = json['regis_year'];
    regisSemester = json['regis_semester'];
    courseNo = json['course_no'];
    credit = json['credit'];
    grade = json['grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['regis_year'] = this.regisYear;
    data['regis_semester'] = this.regisSemester;
    data['course_no'] = this.courseNo;
    data['credit'] = this.credit;
    data['grade'] = this.grade;
    return data;
  }
}
