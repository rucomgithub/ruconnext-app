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
      imagePath: 'assets/fitness_app/AF1.png',
      titleTxt: 'ข้อมูลนักศึกษาวิชาทหาร',
      subTxt:
          'ข้อมูลลงทะเบียนฝึกนักศึกษาวิชาทหาร และ ข้อมูลขอผ่อนผันการเกณฑ์ทหาร ',
      navigateScreen: '/rotcs',
    ),
    AffairsListData(
      imagePath: 'assets/fitness_app/AF2.png',
      titleTxt: 'ข้อมูลกรมธรรม์ประกันภัย',
      subTxt: 'ข้อมูลกรมธรรม์ประกันภัย สำหรับกิจกรรมต่างๆของนักศึกษา',
      navigateScreen: '/insurance',
    ),
    AffairsListData(
      imagePath: 'assets/fitness_app/AF3.png',
      titleTxt: 'ข้อมูลทุนของนักศึกษา',
      subTxt: 'ข้อมูลทุนของนักศึกษา',
      navigateScreen: '/scholarship',
    ),
    AffairsListData(
      imagePath: 'assets/fitness_app/AF4.png',
      titleTxt: 'ข้อมูลร่วมกิจกรรมต่างๆ ของนักศึกษา',
      subTxt: 'ข้อมูลร่วมกิจกรรมต่างๆ ของนักศึกษา',
      navigateScreen: '/affairs',
    ),
  ];
}
