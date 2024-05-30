class Genqr {
  bool? success;
  String? message;
  bool? rECEIPTSTATUS;
  List<Results>? results;

  Genqr({this.success, this.message, this.rECEIPTSTATUS, this.results});

  Genqr.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    rECEIPTSTATUS = json['RECEIPT_STATUS'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['RECEIPT_STATUS'] = this.rECEIPTSTATUS;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? qRURL;
  int? tOTALAMOUNT;
  String? dUEDATE;

  Results({this.qRURL, this.tOTALAMOUNT, this.dUEDATE});

  Results.fromJson(Map<String, dynamic> json) {
    qRURL = json['QR_URL'];
    tOTALAMOUNT = json['TOTAL_AMOUNT'];
    dUEDATE = json['DUE_DATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['QR_URL'] = this.qRURL;
    data['TOTAL_AMOUNT'] = this.tOTALAMOUNT;
    data['DUE_DATE'] = this.dUEDATE;
    return data;
  }
}
