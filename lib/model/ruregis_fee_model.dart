class Ruregisfee {
  String? errString;
  List<Rec>? rec;
  bool? tF;
  String? codecolor;

  Ruregisfee({this.errString, this.rec, this.tF, this.codecolor});

  Ruregisfee.fromJson(Map<String, dynamic> json) {
    errString = json['errString'];
    if (json['rec'] != null) {
      rec = <Rec>[];
      json['rec'].forEach((v) {
        rec!.add(new Rec.fromJson(v));
      });
    }
    tF = json['TF'];
    codecolor = json['codecolor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errString'] = this.errString;
    if (this.rec != null) {
      data['rec'] = this.rec!.map((v) => v.toJson()).toList();
    }
    data['TF'] = this.tF;
    data['codecolor'] = this.codecolor;
    return data;
  }
}

class Rec {
  String? feeamount;
  String? feename;
  String? feetype;
  String? feeno;

  Rec({this.feeamount, this.feename, this.feetype, this.feeno});

  Rec.fromJson(Map<String, dynamic> json) {
    feeamount = json['feeamount'];
    feename = json['feename'];
    feetype = json['feetype'];
    feeno = json['feeno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feeamount'] = this.feeamount;
    data['feename'] = this.feename;
    data['feetype'] = this.feetype;
    data['feeno'] = this.feeno;
    return data;
  }
}
