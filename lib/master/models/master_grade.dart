class MasterGrade {
  String? stdCode;
  String? year;
  int? summaryCredit;
  double? gpa;
  List<GRADEDATA>? gradedata;

  MasterGrade(
      {this.stdCode, this.year, this.summaryCredit, this.gpa, this.gradedata});

  MasterGrade.fromJson(Map<String, dynamic> json) {
    stdCode = json['STD_CODE'];
    year = json['YEAR'];
    summaryCredit = json['SUMMARY_CREDIT'];
    gpa = json['GPA'];
    if (json['GRADEDATA'] != null) {
      gradedata = <GRADEDATA>[];
      json['GRADEDATA'].forEach((v) {
        //print(v);
        gradedata!.add(new GRADEDATA.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STD_CODE'] = this.stdCode;
    data['YEAR'] = this.year;
    data['SUMMARY_CREDIT'] = summaryCredit;
    data['GPA'] = gpa;
    if (this.gradedata != null) {
      data['GRADEDATA'] = this.gradedata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GRADEDATA {
  String? year;
  String? semester;
  String? stdCode;
  String? courseNo;
  int? credit;
  String? grade;

  GRADEDATA(
      {this.year,
      this.semester,
      this.stdCode,
      this.courseNo,
      this.credit,
      this.grade});

  GRADEDATA.fromJson(Map<String, dynamic> json) {
    year = json['YEAR'];
    semester = json['SEMESTER'];
    stdCode = json['STD_CODE'];
    courseNo = json['COURSE_NO'];
    credit = json['CREDIT'];
    grade = json['GRADE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['semester'] = this.semester;
    data['std_code'] = this.stdCode;
    data['course_no'] = this.courseNo;
    data['credit'] = this.credit;
    data['grade'] = this.grade;
    return data;
  }
}
