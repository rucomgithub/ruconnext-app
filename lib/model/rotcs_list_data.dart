import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/rotcs/rotcs_home_screen.dart';

class RotcsListData {
  RotcsListData({
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

  static List<RotcsListData> rotcsList = <RotcsListData>[
    RotcsListData(
      imagePath: 'assets/rotcs/rotcs_1.jpg',
      titleTxt: 'ลงทะเบียนฝึก นศท.',
      subTxt: 'ข้อมูลลงทะเบียนฝึกนักศึกษาวิชาทหารทั้งหมด',
      navigateScreen: '/rotcsregister',
      summary: 0,
    ),
    RotcsListData(
      imagePath: 'assets/rotcs/rotcs_2.jpg',
      titleTxt: 'ขอผ่อนผันการเกณฑ์ทหาร',
      subTxt: 'ข้อมูลขอผ่อนผันการเกณฑ์ทหารทั้งหมด',
      navigateScreen: '/rotcsextend',
      summary: 0,
    ),
  ];
}
