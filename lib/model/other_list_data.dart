class OtherListData {
  OtherListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.navigateScreen = '',
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  String navigateScreen;

  static List<OtherListData> otherList = <OtherListData>[
    OtherListData(
      imagePath: 'assets/fitness_app/A7.png',
      titleTxt: 'ข้อมูลนักศึกษาวิชาทหาร',
      subTxt:
          'ข้อมูลลงทะเบียนฝึกนักศึกษาวิชาทหาร และ ข้อมูลขอผ่อนผันการเกณฑ์ทหาร ',
      navigateScreen: '/rotcs',
    ),
    //   OtherListData(
    //   imagePath: 'assets/fitness_app/A7.png',
    //   titleTxt: 'ข้อมูลค่าปรับหอสมุด',
    //   subTxt:
    //       'ข้อมูลค่าปรับหอสมุด ',
    //   navigateScreen: '/rotcs',
    // ),
    // OtherListData(
    //   imagePath: 'assets/fitness_app/A2.png',
    //   titleTxt: 'ข้อมูลทุนของนักศึกษา',
    //   subTxt: 'ข้อมูลทุนของนักศึกษา',
    //   navigateScreen: '/rotcs',
    // ),
  ];
}
