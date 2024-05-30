import 'dart:convert';

class MR30 {
  String? courseYear;
  String? courseSemester;
  List<RECORD>? rECORD;

  MR30({this.courseYear, this.courseSemester, this.rECORD});

  MR30.fromJson(Map<String, dynamic> json) {
    courseYear = json['course_year'];
    courseSemester = json['course_semester'];
    if (json['RECORD'] != null) {
      rECORD = <RECORD>[];
      json['RECORD'].forEach((v) {
        rECORD!.add(new RECORD.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_year'] = this.courseYear;
    data['course_semester'] = this.courseSemester;
    if (this.rECORD != null) {
      data['RECORD'] = this.rECORD!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RECORD {
  String? id;
  String? courseYear;
  String? courseSemester;
  String? courseNo;
  String? courseMethod;
  String? courseMethodNumber;
  String? dayCode;
  String? timeCode;
  String? roomGroup;
  String? instrGroup;
  String? courseCredit;
  String? courseMethodDetail;
  String? dayNameS;
  String? timePeriod;
  String? courseRoom;
  String? courseInstructor;
  String? showRu30;
  String? coursePr;
  String? courseComment;
  String? courseExamdate;
  bool? favorite;
  bool? register;

  RECORD(
      {this.id,
      this.courseYear,
      this.courseSemester,
      this.courseNo,
      this.courseMethod,
      this.courseMethodNumber,
      this.dayCode,
      this.timeCode,
      this.roomGroup,
      this.instrGroup,
      this.courseCredit,
      this.courseMethodDetail,
      this.dayNameS,
      this.timePeriod,
      this.courseRoom,
      this.courseInstructor,
      this.showRu30,
      this.coursePr,
      this.courseComment,
      this.courseExamdate,
      this.favorite,
      this.register});

  RECORD.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseYear = json['course_year'];
    courseSemester = json['course_semester'];
    courseNo = json['course_no'];
    courseMethod = json['course_method'];
    courseMethodNumber = json['course_method_number'];
    dayCode = json['day_code'];
    timeCode = json['time_code'];
    roomGroup = json['room_group'];
    instrGroup = json['instr_group'];
    courseCredit = json['course_credit'];
    courseMethodDetail = json['course_method_detail'];
    dayNameS = json['day_name_s'];
    timePeriod = json['time_period'];
    courseRoom = json['course_room'];
    courseInstructor = json['course_instructor'];
    showRu30 = json['show_ru30'];
    coursePr = json['course_pr'];
    courseComment = json['course_comment'];
    courseExamdate = json['course_examdate'];
    favorite = json['favorite'];
    register = json['register'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_year'] = this.courseYear;
    data['course_semester'] = this.courseSemester;
    data['course_no'] = this.courseNo;
    data['course_method'] = this.courseMethod;
    data['course_method_number'] = this.courseMethodNumber;
    data['day_code'] = this.dayCode;
    data['time_code'] = this.timeCode;
    data['room_group'] = this.roomGroup;
    data['instr_group'] = this.instrGroup;
    data['course_credit'] = this.courseCredit;
    data['course_method_detail'] = this.courseMethodDetail;
    data['day_name_s'] = this.dayNameS;
    data['time_period'] = this.timePeriod;
    data['course_room'] = this.courseRoom;
    data['course_instructor'] = this.courseInstructor;
    data['show_ru30'] = this.showRu30;
    data['course_pr'] = this.coursePr;
    data['course_comment'] = this.courseComment;
    data['favorite'] = this.favorite;
    data['register'] = this.register;
    return data;
  }

  static List<RECORD> decode(String mr30) =>
      (json.decode(mr30) as List<dynamic>)
          .map<RECORD>((item) => RECORD.fromJson(item))
          .toList();
}
