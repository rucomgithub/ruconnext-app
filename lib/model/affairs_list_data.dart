class AffairsListData {
  AffairsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.navigateScreen = '',
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  String navigateScreen;

  static List<AffairsListData> affairsList = <AffairsListData>[
    AffairsListData(
      imagePath: 'assets/fitness_app/r18.png',
      titleTxt: 'ข้อมูลนักศึกษาวิชาทหาร',
      subTxt:
          'ข้อมูลลงทะเบียนฝึกนักศึกษาวิชาทหาร และ ข้อมูลขอผ่อนผันการเกณฑ์ทหาร ',
      navigateScreen: '/rotcs',
    ),
    AffairsListData(
      imagePath: 'assets/fitness_app/r18.png',
      titleTxt: 'ข้อมูลกรมธรรม์ประกันภัย',
      subTxt: 'ข้อมูลกรมธรรม์ประกันภัย สำหรับกิจกรรมต่างๆของนักศึกษา',
      navigateScreen: '/insurance',
    ),
    AffairsListData(
      imagePath: 'assets/fitness_app/r18.png',
      titleTxt: 'ข้อมูลทุนของนักศึกษา',
      subTxt: 'ข้อมูลทุนของนักศึกษา',
      navigateScreen: '/affairs',
    ),
    AffairsListData(
      imagePath: 'assets/fitness_app/r18.png',
      titleTxt: 'ข้อมูลร่วมกิจกรรมต่างๆ ของนักศึกษา',
      subTxt: 'ข้อมูลร่วมกิจกรรมต่างๆ ของนักศึกษา',
      navigateScreen: '/affairs',
    ),
  ];
}
