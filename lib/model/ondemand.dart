import 'dart:convert';

class Ondemand {
  String? subjectId;
  String? semester;
  String? year;
  RECORD? rECORD;

  Ondemand({this.subjectId, this.semester, this.year, this.rECORD});

  Ondemand.fromJson(Map<String, dynamic> json) {
    subjectId = json['subject_id'];
    semester = json['semester'];
    year = json['year'];
    rECORD =
        json['RECORD'] != null ? new RECORD.fromJson(json['RECORD']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_id'] = this.subjectId;
    data['semester'] = this.semester;
    data['year'] = this.year;
    if (this.rECORD != null) {
      data['RECORD'] = this.rECORD!.toJson();
    }
    return data;
  }
}

class RECORD {
  String? subjectCode;
  String? subjectId;
  String? subjectNameEng;
  String? semester;
  String? year;
  List<Detail>? detail;

  RECORD(
      {this.subjectCode,
      this.subjectId,
      this.subjectNameEng,
      this.semester,
      this.year,
      this.detail});

  RECORD.fromJson(Map<String, dynamic> json) {
    subjectCode = json['subject_code'];
    subjectId = json['subject_id'];
    subjectNameEng = json['subject_name_eng'];
    semester = json['semester'];
    year = json['year'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_code'] = this.subjectCode;
    data['subject_id'] = this.subjectId;
    data['subject_name_eng'] = this.subjectNameEng;
    data['semester'] = this.semester;
    data['year'] = this.year;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  String? audioId;
  String? subjectCode;
  String? subjectId;
  String? audioSec;
  String? sem;
  String? year;
  String? audioCreate;
  String? audioStatus;
  String? audioTeach;
  String? audioComment;

  Detail(
      {this.audioId,
      this.subjectCode,
      this.subjectId,
      this.audioSec,
      this.sem,
      this.year,
      this.audioCreate,
      this.audioStatus,
      this.audioTeach,
      this.audioComment});

  Detail.fromJson(Map<String, dynamic> json) {
    audioId = json['audio_id '];
    subjectCode = json['subject_code'];
    subjectId = json['subject_id'];
    audioSec = json['audio_sec'];
    sem = json['sem'];
    year = json['year'];
    audioCreate = json['audio_create'];
    audioStatus = json['audio_status'];
    audioTeach = json['audio_teach'];
    audioComment = json['audio_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audio_id '] = this.audioId;
    data['subject_code'] = this.subjectCode;
    data['subject_id'] = this.subjectId;
    data['audio_sec'] = this.audioSec;
    data['sem'] = this.sem;
    data['year'] = this.year;
    data['audio_create'] = this.audioCreate;
    data['audio_status'] = this.audioStatus;
    data['audio_teach'] = this.audioTeach;
    data['audio_comment'] = this.audioComment;
    return data;
  }
}
