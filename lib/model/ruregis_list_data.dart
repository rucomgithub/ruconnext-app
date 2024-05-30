import 'package:flutter/material.dart';

class RuregisListData {
  RuregisListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.navigateScreen = '',
    this.summary = 0,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  String navigateScreen;
  int summary;

  static List<RuregisListData> ruregisList = <RuregisListData>[
    RuregisListData(
      imagePath: 'assets/rotcs/rotcs_1.jpg',
      titleTxt: 'ลงทะเบียนฝึก นศท.',
      subTxt: 'ข้อมูลลงทะเบียนฝึกนักศึกษาวิชาทหารทั้งหมด',
      navigateScreen: '/rotcsregister',
      summary: 0,
    ),
    RuregisListData(
      imagePath: 'assets/rotcs/rotcs_2.jpg',
      titleTxt: 'ขอผ่อนผันการเกณฑ์ทหาร',
      subTxt: 'ข้อมูลขอผ่อนผันการเกณฑ์ทหารทั้งหมด',
      navigateScreen: '/rotcsextend',
      summary: 0,
    ),
  ];
}
