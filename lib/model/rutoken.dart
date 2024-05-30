class Rutoken {
  String? accessToken;
  String? refreshToken;
  bool? isAuth;
  String? message;
  int? statusCode;

  Rutoken(
      {this.accessToken,
      this.refreshToken,
      this.isAuth,
      this.message,
      this.statusCode});

  Rutoken.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    isAuth = json['isAuth'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['isAuth'] = this.isAuth;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    return data;
  }
}
