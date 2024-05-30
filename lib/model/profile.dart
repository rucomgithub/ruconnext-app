class Profile {
  String? displayName;
  String? email;
  String? studentCode;
  String? photoUrl;
  String? googleToken;
  String? accessToken;
  String? refreshToken;
  bool? isAuth;

  Profile({
    this.displayName,
    this.email,
    this.studentCode,
    this.photoUrl,
    this.googleToken,
    this.accessToken,
    this.refreshToken,
    this.isAuth,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    studentCode = json['studentCode'];
    photoUrl = json['photoUrl'];
    googleToken = json['googleToken'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    isAuth = json['isAuth'];
  }

  Map toJson() => {
        'displayName': displayName,
        'email': email,
        'studentCode': studentCode,
        'photoUrl': photoUrl,
        'googleToken': googleToken,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'isAuth': isAuth,
      };
}
