class RotcsRegister {
  String? studentCode;
  int? total;
  List<RotcsRegisterDetail>? detail;

  RotcsRegister({this.studentCode, this.total, this.detail});

  RotcsRegister.fromJson(Map<String, dynamic> json) {
    studentCode = json['studentCode'];
    total = json['total'];
    if (json['detail'] != null) {
      detail = <RotcsRegisterDetail>[];
      json['detail'].forEach((v) {
        detail!.add(new RotcsRegisterDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentCode'] = this.studentCode;
    data['total'] = this.total;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RotcsRegisterDetail {
  String? yearReport;
  String? locationArmy;
  String? layerArmy;
  String? layerReport;
  String? typeReport;
  String? status;

  RotcsRegisterDetail(
      {this.yearReport,
      this.locationArmy,
      this.layerArmy,
      this.layerReport,
      this.typeReport,
      this.status});

  RotcsRegisterDetail.fromJson(Map<String, dynamic> json) {
    yearReport = json['yearReport'];
    locationArmy = json['locationArmy'];
    layerArmy = json['layerArmy'];
    layerReport = json['layerReport'];
    typeReport = json['typeReport'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yearReport'] = this.yearReport;
    data['locationArmy'] = this.locationArmy;
    data['layerArmy'] = this.layerArmy;
    data['layerReport'] = this.layerReport;
    data['typeReport'] = this.typeReport;
    data['status'] = this.status;
    return data;
  }
}
