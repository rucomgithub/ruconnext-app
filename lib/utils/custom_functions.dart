import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatCurrency(num amount, {int decimalCount = 0}) {
  final formatCurrency =
      new NumberFormat.simpleCurrency(decimalDigits: decimalCount);
  return formatCurrency.format(amount);
}

dynamic ColorDay(String daycode) {
  var daycolor;
  switch (daycode) {
    case '1':
      {
        daycolor = Color.fromARGB(255, 250, 250, 106);
      }
      break;
    case '2':
      {
        daycolor = Color.fromARGB(255, 248, 175, 200);
      }
      break;
    case '3':
      {
        daycolor = Color.fromARGB(255, 154, 248, 203);
      }
      break;
    case '4':
      {
        daycolor = Color.fromARGB(255, 255, 187, 85);
      }
      break;
    case '5':
      {
        daycolor = Color.fromARGB(255, 144, 205, 255);
      }
      break;
    case '6':
      {
        daycolor = Colors.purpleAccent;
      }
      break;
    case '7':
      {
        daycolor = Colors.redAccent;
      }
      break;
    default:
      {
        daycolor = Colors.black12;
      }
      break;
  }
  return daycolor;
}

String StringTimeStudy(String periodtime) {
  final period = periodtime.split('-');
  var format = DateFormat("HH:mm");
  var timenow = DateFormat(DateFormat.HOUR24_MINUTE).format(DateTime.now());
  int timeCurrent = int.parse(timenow.replaceAll(":", ""));
  int timeStart = int.parse(period[0]);
  int timeEnd = int.parse(period[1]);
  String strcheck = "";
  String strStarttime = "";
  String strEndtime = "";
  String strtime = "";

  print(timeCurrent);

  if (timeCurrent >= timeStart && timeCurrent < timeEnd) {
    strEndtime =
        '${(period[1]).toString().substring(0, 2)}:${(period[1]).toString().substring(2, 4)}';
    strtime = format
        .parse(strEndtime)
        .difference(format.parse(timenow))
        .toString()
        .substring(0, 4);
    strcheck = 'อีก $strtime หมดเวลา';
  } else {
    if (timeCurrent < timeStart) {
      strStarttime =
          '${(period[0]).toString().substring(0, 2)}:${(period[0]).toString().substring(2, 4)}';
      strtime = format
          .parse(strStarttime)
          .difference(format.parse(timenow))
          .toString()
          .substring(0, 4);
      strcheck = 'เริ่มเรียนอีก $strtime';
    } else
      strcheck = 'หมดเวลาเรียน';
  }
  return strcheck;
}

//สำหรับ schedule
String formatDate(String dateStr) {
  DateFormat inputFormat = DateFormat('yyyy-MM-dd');
  //DateFormat outputFormat = DateFormat('dd/MM/yyyy');
  DateTime date = inputFormat.parse(dateStr);
  DateFormat formatter = DateFormat.yMMMd('th');
  //return outputFormat.format(date);
  return formatter.format(date);
}

Duration dateDiff(DateTime date1, DateTime date2) {
  return date1.difference(date2);
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

String commingTime(DateTime date1, DateTime date2, DateTime date3) {
  var txtResponse = null;
  // print("xxxx${daysBetween(date2, date1).toString()}");
  if (daysBetween(date2, DateTime.now()) == 0) {
    // print(date2);
    // print(daysBetween(date2, date1).toString());
    //txtResponse = "เหลืออีก 1 วัน${dateDiff(date1, date2).inDays}";
    // print(dateDiff(date1, date2).inDays);
    // print(dateDiff(date1, date2).inHours);
    // print(dateDiff(date1, date2).inMinutes);
    txtResponse =
        "เหลือ ${dateDiff(date3, DateTime.now()).inDays + 1} วัน กิจกรรมจะหมดเวลา";
  } else if (daysBetween(date2, date1) > 0) {
    print(daysBetween(date2, date1).toString());
    // txtResponse =
    //     "อีก ${dateDiff(date1, date2).inDays + 1} วัน กิจกรรมจะเริ่มขึ้น";
    txtResponse =
        "อีก ${daysBetween(date2, date1).toString()} วัน กิจกรรมจะเริ่มขึ้น";
  } else {
    //txtResponse = "หมดเวลา${dateDiff(date1, date2).inDays}";
    txtResponse = "กิจกรรมนี้หมดเวลาแล้ว";
  }

  return txtResponse;
}

String commingTimeNewLine(DateTime date1, DateTime date2, DateTime date3) {
  var txtResponse = null;
  // print("xxxx${daysBetween(date2, date1).toString()}");
  if (daysBetween(date2, DateTime.now()) == 0) {
    // print(date2);
    // print(daysBetween(date2, date1).toString());
    //txtResponse = "เหลืออีก 1 วัน${dateDiff(date1, date2).inDays}";
    // print(dateDiff(date1, date2).inDays);
    // print(dateDiff(date1, date2).inHours);
    // print(dateDiff(date1, date2).inMinutes);
    txtResponse =
        "เหลือ ${dateDiff(date3, DateTime.now()).inDays + 1} วัน \n กิจกรรมจะหมดเวลา";
  } else if (daysBetween(date2, date1) > 0) {
    print(daysBetween(date2, date1).toString());
    // txtResponse =
    //     "อีก ${dateDiff(date1, date2).inDays + 1} วัน กิจกรรมจะเริ่มขึ้น";
    txtResponse =
        "อีก ${daysBetween(date2, date1).toString()} วัน \n กิจกรรมจะเริ่มขึ้น";
  } else {
    //txtResponse = "หมดเวลา${dateDiff(date1, date2).inDays}";
    txtResponse = "กิจกรรมนี้หมดเวลาแล้ว ";
  }

  return txtResponse;
}
