class YearSemester {
  final String year;
  final String semester;

  YearSemester({
    required this.year,
    required this.semester,
  });

  factory YearSemester.fromJson(Map<String, dynamic> json) {
    return YearSemester(
      year: json['year'],
      semester: json['semester'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['semester'] = this.semester;
    return data;
  }
}
