import 'dart:convert';

class REGISTERYEAR {
  List<RECORDYEAR>? recordyear;

  REGISTERYEAR({this.recordyear});

  REGISTERYEAR.fromJson(Map<String, dynamic> json) {
    if (json['RECORD'] != null) {
      recordyear = <RECORDYEAR>[];
      json['RECORD'].forEach((v) {
        recordyear!.add(new RECORDYEAR.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recordyear != null) {
      data['RECORD'] = this.recordyear!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RECORDYEAR {
  String? year;

  RECORDYEAR({this.year});

  RECORDYEAR.fromJson(Map<String, dynamic> json) {
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    return data;
  }

  static List<RECORDYEAR> decode(String registeryear) =>
      (json.decode(registeryear) as List<dynamic>)
          .map<RECORDYEAR>((item) => RECORDYEAR.fromJson(item))
          .toList();
}
