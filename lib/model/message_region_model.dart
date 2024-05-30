class MessageRegion {
  bool? success;
  String? message;
  String? messageWarning;
  String? messageNoti;

  MessageRegion(
      {this.success, this.message, this.messageWarning, this.messageNoti});

  MessageRegion.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    messageWarning = json['message_warning'];
    messageNoti = json['message_noti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['message_warning'] = this.messageWarning;
    data['message_noti'] = this.messageNoti;
    return data;
  }
}
