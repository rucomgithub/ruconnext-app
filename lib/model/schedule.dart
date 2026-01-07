class Schedule {
  final String id;
  final String eventName;
  final String startDate;
  final String endDate;
  final String detail;
  final String orderList;
  final String image;
  final String file;
  final String linkEvent;
  final String secId;
  final String status;
  final String hit;
  final String color;
  final String pointer;

  Schedule({
    required this.id,
    required this.eventName,
    required this.startDate,
    required this.endDate,
    required this.detail,
    required this.orderList,
    required this.image,
    required this.file,
    required this.linkEvent,
    required this.secId,
    required this.status,
    required this.hit,
    required this.color,
    required this.pointer,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'] ?? '',
      eventName: json['event_name'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      detail: json['detail'] ?? '',
      orderList: json['orderlist'] ?? '',
      image: json['image'] ?? '',
      file: json['file'] ?? '',
      linkEvent: json['link_event'] ?? '',
      secId: json['sec_id'] ?? '',
      status: json['status'] ?? '',
      hit: json['hit'] ?? '',
      color: json['color'] ?? '',
      pointer: json['pointer'] ?? '',
    );
  }
}
