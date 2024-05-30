class Locationexam {
  bool? success;
  String? message;
  List<Results>? results;

  Locationexam({this.success, this.message, this.results});

  Locationexam.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
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
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? eXAMLOCATIONNAMETHAI;
  String? rEGIONALEXAMNO;

  Results({this.eXAMLOCATIONNAMETHAI, this.rEGIONALEXAMNO});

  Results.fromJson(Map<String, dynamic> json) {
    eXAMLOCATIONNAMETHAI = json['EXAM_LOCATION_NAME_THAI'];
    rEGIONALEXAMNO = json['REGIONAL_EXAM_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EXAM_LOCATION_NAME_THAI'] = this.eXAMLOCATIONNAMETHAI;
    data['REGIONAL_EXAM_NO'] = this.rEGIONALEXAMNO;
    return data;
  }
}
