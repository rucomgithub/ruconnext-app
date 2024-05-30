import 'dart:convert';

class Roommap {
  String? room;
  double? destlat;
  double? destlng;

  Roommap({this.room, this.destlat, this.destlng});

  Roommap.fromJson(Map<String, dynamic> json) {
    room = json['room'];
    destlat = json['destlat'];
    destlng = json['destlng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room'] = this.room;
    data['destlat'] = this.destlat;
    data['destlng'] = this.destlng;
    return data;
  }

  static List<Roommap> decode(String roommap) =>
      (json.decode(roommap) as List<dynamic>)
          .map<Roommap>((item) => Roommap.fromJson(item))
          .toList();
}