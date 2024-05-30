class Calpay {
  bool? success;
  String? message;
  int? sumTotal;
  List<Results>? results;

  Calpay({this.success, this.message, this.sumTotal, this.results});

  Calpay.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    sumTotal = json['sum_total'];
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
    data['sum_total'] = this.sumTotal;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? fEENO;
  String? fEENAME;
  int? fEEAMOUNT;
  Null? fEETYPE;

  Results({this.fEENO, this.fEENAME, this.fEEAMOUNT, this.fEETYPE});

  Results.fromJson(Map<String, dynamic> json) {
    fEENO = json['FEE_NO'];
    fEENAME = json['FEE_NAME'];
    fEEAMOUNT = json['FEE_AMOUNT'];
    fEETYPE = json['FEE_TYPE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FEE_NO'] = this.fEENO;
    data['FEE_NAME'] = this.fEENAME;
    data['FEE_AMOUNT'] = this.fEEAMOUNT;
    data['FEE_TYPE'] = this.fEETYPE;
    return data;
  }
}
