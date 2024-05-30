import 'dart:convert';

class Loginregion {
  List<Rec>? rec;
  bool? tf;
  String? errString;

  Loginregion({this.rec, this.tf, this.errString});

  Loginregion.fromJson(Map<String, dynamic> json) {
    if (json['rec'] != null) {
      rec = <Rec>[];
      json['rec'].forEach((v) {
        rec!.add(new Rec.fromJson(v));
      });
    }
    tf = json['tf'];
    errString = json['errString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rec != null) {
      data['rec'] = this.rec!.map((v) => v.toJson()).toList();
    }
    data['tf'] = this.tf;
    data['errString'] = this.errString;
    return data;
  }
}

class Rec {
  String? username;

  Rec({this.username});

  Rec.fromJson(Map<String, dynamic> json) {
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    return data;
  }

    static List<Rec> decode(String mr30ruregion) =>
      (json.decode(mr30ruregion) as List<dynamic>)
          .map<Rec>((item) => Rec.fromJson(item))
          .toList();
}
