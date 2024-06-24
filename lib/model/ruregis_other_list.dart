class RuregisOtherListData {
  RuregisOtherListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.navigateScreen = '',
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  String navigateScreen;

  static List<RuregisOtherListData> otherList = <RuregisOtherListData>[
    RuregisOtherListData(
      imagePath: 'assets/fitness_app/A7.png',
      titleTxt: 'เลือกวิชาที่ต้องการลงทะเบียน',
      subTxt:
          'เลือกวิชาที่ต้องการลงทะเบียน มร.30',
      navigateScreen: '/ruregismr30',
    ),

    RuregisOtherListData(
      imagePath: 'assets/fitness_app/A7.png',
      titleTxt: 'ตรวจสอบสถานะการลงทะเบียน',
      subTxt:
          'ตรวจสอบสถานะการลงทะเบียน',
      navigateScreen: '/ruregionmr30',
    ),
        RuregisOtherListData(
      imagePath: 'assets/fitness_app/A7.png',
      titleTxt: 'รับ QRCODE',
      subTxt:
          'รับ QRCODE',
      navigateScreen: '/ruregisqrcode',
    ),
  ];
}
