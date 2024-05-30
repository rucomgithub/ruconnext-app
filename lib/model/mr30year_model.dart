import 'dart:convert';

class MR30YEAR {
  List<RECORDYEAR>? recordyear;

  MR30YEAR({this.recordyear});

  MR30YEAR.fromJson(Map<String, dynamic> json) {
    if (json['RECORDYEAR'] != null) {
      recordyear = <RECORDYEAR>[];
      json['RECORDYEAR'].forEach((v) {
        recordyear!.add(new RECORDYEAR.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recordyear != null) {
      data['RECORDYEAR'] = this.recordyear!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RECORDYEAR {
  String? courseYear;
  String? courseSemester;

  RECORDYEAR({this.courseYear, this.courseSemester});

  RECORDYEAR.fromJson(Map<String, dynamic> json) {
    courseYear = json['course_year'];
    courseSemester = json['course_semester'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_year'] = this.courseYear;
    data['course_semester'] = this.courseSemester;
    return data;
  }

  static List<RECORDYEAR> decode(String mr30year) =>
      (json.decode(mr30year) as List<dynamic>)
          .map<RECORDYEAR>((item) => RECORDYEAR.fromJson(item))
          .toList();
}
