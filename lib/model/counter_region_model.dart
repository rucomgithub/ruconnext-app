class CounterRegion {
  bool? success;
  String? messages;
  List<ResultsCounter>? resultsCounter;
  List<ResultsAppControl>? resultsAppControl;

  CounterRegion(
      {this.success,
      this.messages,
      this.resultsCounter,
      this.resultsAppControl});

  CounterRegion.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    messages = json['messages'];
    if (json['results_counter'] != null) {
      resultsCounter = <ResultsCounter>[];
      json['results_counter'].forEach((v) {
        resultsCounter!.add(new ResultsCounter.fromJson(v));
      });
    }
    if (json['results_app_control'] != null) {
      resultsAppControl = <ResultsAppControl>[];
      json['results_app_control'].forEach((v) {
        resultsAppControl!.add(new ResultsAppControl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['messages'] = this.messages;
    if (this.resultsCounter != null) {
      data['results_counter'] =
          this.resultsCounter!.map((v) => v.toJson()).toList();
    }
    if (this.resultsAppControl != null) {
      data['results_app_control'] =
          this.resultsAppControl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultsCounter {
  String? sTARTDATE;
  String? eNDDATE;
  bool? sTARTTIME;
  bool? eNDTIME;
  bool? sYSTEMSTATUSCLOSE;
  String? fISCALYEAR;
  bool? sYSTEMSTATUS;
  String? sTUDYYEAR;
  String? sTUDYSEMESTER;
  String? dUEDATE;

  ResultsCounter(
      {this.sTARTDATE,
      this.eNDDATE,
      this.sTARTTIME,
      this.eNDTIME,
      this.sYSTEMSTATUSCLOSE,
      this.fISCALYEAR,
      this.sYSTEMSTATUS,
      this.sTUDYYEAR,
      this.sTUDYSEMESTER,
      this.dUEDATE});

  ResultsCounter.fromJson(Map<String, dynamic> json) {
    sTARTDATE = json['START_DATE'];
    eNDDATE = json['END_DATE'];
    sTARTTIME = json['START_TIME'];
    eNDTIME = json['END_TIME'];
    sYSTEMSTATUSCLOSE = json['SYSTEM_STATUS_CLOSE'];
    fISCALYEAR = json['FISCAL_YEAR'];
    sYSTEMSTATUS = json['SYSTEM_STATUS'];
    sTUDYYEAR = json['STUDY_YEAR'];
    sTUDYSEMESTER = json['STUDY_SEMESTER'];
    dUEDATE = json['DUE_DATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['START_DATE'] = this.sTARTDATE;
    data['END_DATE'] = this.eNDDATE;
    data['START_TIME'] = this.sTARTTIME;
    data['END_TIME'] = this.eNDTIME;
    data['SYSTEM_STATUS_CLOSE'] = this.sYSTEMSTATUSCLOSE;
    data['FISCAL_YEAR'] = this.fISCALYEAR;
    data['SYSTEM_STATUS'] = this.sYSTEMSTATUS;
    data['STUDY_YEAR'] = this.sTUDYYEAR;
    data['STUDY_SEMESTER'] = this.sTUDYSEMESTER;
    data['DUE_DATE'] = this.dUEDATE;
    return data;
  }
}

class ResultsAppControl {
  String? aPIID;
  String? aPINAME;
  bool? aPISTATUS;
  String? aPIDES;

  ResultsAppControl({this.aPIID, this.aPINAME, this.aPISTATUS, this.aPIDES});

  ResultsAppControl.fromJson(Map<String, dynamic> json) {
    aPIID = json['API_ID'];
    aPINAME = json['API_NAME'];
    aPISTATUS = json['API_STATUS'];
    aPIDES = json['API_DES'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['API_ID'] = this.aPIID;
    data['API_NAME'] = this.aPINAME;
    data['API_STATUS'] = this.aPISTATUS;
    data['API_DES'] = this.aPIDES;
    return data;
  }
}
