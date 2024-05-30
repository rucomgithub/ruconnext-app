import 'dart:convert';

List<runews> showSubjectFromJson(String str) =>
    List<runews>.from(json.decode(str).map((x) => runews.fromJson(x)));
String showSubjectToJson(List<runews> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class runews {
  String? id;
  String? categoryId;
  String? title;
  String? photoHeader;
  String? detail;
  String? photoContent;
  String? fileDetail;
  String? fileDetail2;
  String? fileDetail3;
  String? fileComment;
  String? fileComment2;
  String? fileComment3;
  String? hit;
  String? dateReceive;
  String? datePost;
  String? dateExpire;
  String? status;
  String? priority;
  String? author;

  runews(
      {this.id,
      this.categoryId,
      this.title,
      this.photoHeader,
      this.detail,
      this.photoContent,
      this.fileDetail,
      this.fileDetail2,
      this.fileDetail3,
      this.fileComment,
      this.fileComment2,
      this.fileComment3,
      this.hit,
      this.dateReceive,
      this.datePost,
      this.dateExpire,
      this.status,
      this.priority,
      this.author});

  runews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    photoHeader = json['photo_header'];
    detail = json['detail'];
    photoContent = json['photo_content'];
    fileDetail = json['file_detail'];
    fileDetail2 = json['file_detail2'];
    fileDetail3 = json['file_detail3'];
    fileComment = json['file_comment'];
    fileComment2 = json['file_comment2'];
    fileComment3 = json['file_comment3'];
    hit = json['hit'];
    dateReceive = json['date_receive'];
    datePost = json['date_post'];
    dateExpire = json['date_expire'];
    status = json['status'];
    priority = json['priority'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['photo_header'] = this.photoHeader;
    data['detail'] = this.detail;
    data['photo_content'] = this.photoContent;
    data['file_detail'] = this.fileDetail;
    data['file_detail2'] = this.fileDetail2;
    data['file_detail3'] = this.fileDetail3;
    data['file_comment'] = this.fileComment;
    data['file_comment2'] = this.fileComment2;
    data['file_comment3'] = this.fileComment3;
    data['hit'] = this.hit;
    data['date_receive'] = this.dateReceive;
    data['date_post'] = this.datePost;
    data['date_expire'] = this.dateExpire;
    data['status'] = this.status;
    data['priority'] = this.priority;
    data['author'] = this.author;
    return data;
  }

  static List<runews> decode(String runew) =>
      (json.decode(runew) as List<dynamic>)
          .map<runews>((item) => runews.fromJson(item))
          .toList();
}
