class Scholarship {
  String? stdCode;
  int? total;
  List<RECORD>? rECORD;

  Scholarship({this.stdCode, this.total, this.rECORD});

  Scholarship.fromJson(Map<String, dynamic> json) {
    stdCode = json['std_code'];
    total = json['total'];
    if (json['RECORD'] != null) {
      rECORD = <RECORD>[];
      json['RECORD'].forEach((v) {
        rECORD!.add(new RECORD.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['std_code'] = this.stdCode;
    data['total'] = this.total;
    if (this.rECORD != null) {
      data['RECORD'] = this.rECORD!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RECORD {
  int? id;
  String? stdCode;
  int? scholarshipYear;
  String? scholarshipSemester;
  String? scholarshipType;
  int? amount;
  String? created;
  String? modified;
  String? username;
  String? subsidyNo;
  String? subsidyNameThai;

  RECORD(
      {this.id,
      this.stdCode,
      this.scholarshipYear,
      this.scholarshipSemester,
      this.scholarshipType,
      this.amount,
      this.created,
      this.modified,
      this.username,
      this.subsidyNo,
      this.subsidyNameThai});

  RECORD.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stdCode = json['std_code'];
    scholarshipYear = json['scholarship_year'];
    scholarshipSemester = json['scholarship_semester'];
    scholarshipType = json['scholarship_type'];
    amount = json['amount'];
    created = json['created'];
    modified = json['modified'];
    username = json['username'];
    subsidyNo = json['subsidy_no'];
    subsidyNameThai = json['subsidy_name_thai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['std_code'] = this.stdCode;
    data['scholarship_year'] = this.scholarshipYear;
    data['scholarship_semester'] = this.scholarshipSemester;
    data['scholarship_type'] = this.scholarshipType;
    data['amount'] = this.amount;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['username'] = this.username;
    data['subsidy_no'] = this.subsidyNo;
    data['subsidy_name_thai'] = this.subsidyNameThai;
    return data;
  }
}
