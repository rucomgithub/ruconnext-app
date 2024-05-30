class Mr30Catalog {
  List<Rec>? rec;

  Mr30Catalog({this.rec});

  Mr30Catalog.fromJson(Map<String, dynamic> json) {
    if (json['rec'] != null) {
      rec = <Rec>[];
      json['rec'].forEach((v) {
        rec!.add(new Rec.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rec != null) {
      data['rec'] = this.rec!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rec {
  String? cName;
  String? cOURSENO;
  String? type;
  String? typeNo;
  String? grade;

  Rec({this.cName, this.cOURSENO, this.type, this.typeNo, this.grade});

  Rec.fromJson(Map<String, dynamic> json) {
    cName = json['cName'];
    cOURSENO = json['COURSENO'];
    type = json['type'];
    typeNo = json['typeNo'];
    grade = json['grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cName'] = this.cName;
    data['COURSENO'] = this.cOURSENO;
    data['type'] = this.type;
    data['typeNo'] = this.typeNo;
    data['grade'] = this.grade;
    return data;
  }
}
