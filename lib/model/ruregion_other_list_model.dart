class RuregionOtherListData {
  RuregionOtherListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.navigateScreen = '',
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  String navigateScreen;

  static List<RuregionOtherListData> otherListDefualt = <RuregionOtherListData>[
    RuregionOtherListData(
      imagePath: 'assets/fitness_app/A7.png',
      titleTxt: 'เลือกวิชาที่ต้องการลงทะเบียน',
      subTxt: 'เลือกวิชาที่ต้องการลงทะเบียน มร.30',
      navigateScreen: '/ruregionAppmr30',
    ),
    RuregionOtherListData(
      imagePath: 'assets/fitness_app/A1.png',
      titleTxt: 'ตรวจสอบสถานะการลงทะเบียน',
      subTxt: 'ตรวจสอบสถานะการลงทะเบียน',
      navigateScreen: '/ruregionAppreceipt',
    ),

    RuregionOtherListData(
      imagePath: 'assets/fitness_app/A2.png',
      titleTxt: 'รับ QRCODE',
      subTxt: 'รับ QR CODE',
      navigateScreen: '/ruregionAppQR',
    ),
  ];

  static List<RuregionOtherListData> otherListSuccess = <RuregionOtherListData>[
    RuregionOtherListData(
      imagePath: 'assets/fitness_app/A7.png',
      titleTxt: 'เลือกวิชาที่ต้องการลงทะเบียน',
      subTxt: 'เลือกวิชาที่ต้องการลงทะเบียน มร.30',
      navigateScreen: '/ruregionAppmr30',
    ),

    RuregionOtherListData(
      imagePath: 'assets/fitness_app/A3.png',
      titleTxt: 'ตรวจสอบสถานะการลงทะเบียน',
      subTxt: 'ตรวจสอบสถานะการลงทะเบียน',
      navigateScreen: '/ruregionAppsuccess2',
    ),
    RuregionOtherListData(
      imagePath: 'assets/fitness_app/A2.png',
      titleTxt: 'รับ QRCODE',
      subTxt: 'รับ QR CODE',
      navigateScreen: '/ruregionAppQR',
    ),
  ];
}
