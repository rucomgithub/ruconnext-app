class Mr30Catalog {
  List<CourseType>? coursetype = [];

  Mr30Catalog({this.coursetype});

  Mr30Catalog.fromJson(Map<String, dynamic> json) {
    if (json['rec'] != null) {
      coursetype = <CourseType>[];
      json['rec'].forEach((v) {
        coursetype!.add(new CourseType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coursetype != null) {
      data['coursetype'] = this.coursetype!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseType {
  String? cname;
  String? courseno;
  String? type;
  String? typeno;
  String? grade;
  String? startColor;
  String? endColor;
  String? imagePath;

  CourseType(
      {this.cname = "",
      this.courseno = "",
      this.type = "",
      this.typeno = "",
      this.grade = "",
      this.startColor = "",
      this.endColor = "",
      this.imagePath = ""});

  CourseType.fromJson(Map<String, dynamic> json) {
    cname = json['cName'];
    courseno = json['COURSENO'];
    type = json['type'];
    typeno = json['typeNo'];
    grade = json['grade'];
    startColor = json['startColor'];
    endColor = json['endColor'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cname'] = this.cname;
    data['courseno'] = this.courseno;
    data['type'] = this.type;
    data['typeno'] = this.typeno;
    data['grade'] = this.grade;
    data['startColor'] = this.startColor;
    data['endColor'] = this.endColor;
    data['imagePath'] = this.imagePath;
    return data;
  }
}

class Percentage {
  int counter;
  final double percent;
  final List<String> listregister;
  final List<CourseType> listcoursetype;

  Percentage(
      {required this.counter,
      required this.percent,
      required this.listregister,
      required this.listcoursetype});

  @override
  String toString() {
    return 'Percentage(value: $counter, percent: $percent)';
  }
}
