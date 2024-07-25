class SaveStatus {
  bool? success;
  String? message;
  bool? rECEIPTSTATUS;
  bool? rEGISSTATUS;

  SaveStatus(
      {this.success, this.message, this.rECEIPTSTATUS, this.rEGISSTATUS});

  SaveStatus.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    rECEIPTSTATUS = json['RECEIPT_STATUS'];
    rEGISSTATUS = json['REGIS_STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['RECEIPT_STATUS'] = this.rECEIPTSTATUS;
    data['REGIS_STATUS'] = this.rEGISSTATUS;
    return data;
  }
}
