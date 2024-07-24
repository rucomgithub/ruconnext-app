class Course {
  final String regisYear;
  final String regisSemester;
  final String courseNo;
  final String credit;
  final String grade;

  Course({
    required this.regisYear,
    required this.regisSemester,
    required this.courseNo,
    required this.credit,
    required this.grade,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      regisYear: json['regis_year'],
      regisSemester: json['regis_semester'],
      courseNo: json['course_no'],
      credit: json['credit'],
      grade: json['grade'],
    );
  }
}
