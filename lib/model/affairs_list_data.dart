class AffairsListData {
  AffairsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.navigateScreen = '',
    this.url = '',
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  String navigateScreen;
  String url;

  static List<AffairsListData> affairsList = <AffairsListData>[
    // AffairsListData(
    //   imagePath: 'assets/fitness_app/AF1.png',
    //   titleTxt: 'ระบบสารสนเทศด้านกิจการทหาร',
    //   subTxt: 'ระบบสารสนเทศด้านกิจการทหาร',
    //   navigateScreen: '',
    //   url: 'https://fis.ru.ac.th/rotcs/index.php?r=site/protected&id_token=',
    // ),
    AffairsListData(
      imagePath: 'assets/fitness_app/AF1.png',
      titleTxt: 'นักศึกษาวิชาทหาร',
      subTxt: 'ลงทะเบียนฝึกนักศึกษาวิชาทหาร และ ข้อมูลขอผ่อนผันการเกณฑ์ทหาร ',
      navigateScreen: '/rotcs',
      url: '',
    ),
    AffairsListData(
      imagePath: 'assets/fitness_app/AF2.png',
      titleTxt: 'กรมธรรม์ประกันภัย',
      subTxt: 'กรมธรรม์ประกันภัย สำหรับกิจกรรมต่างๆของนักศึกษา',
      navigateScreen: '/insurance',
      url: '',
    ),
    AffairsListData(
      imagePath: 'assets/fitness_app/AF3.png',
      titleTxt: 'ประวัติการรับทุนการศึกษา',
      subTxt: 'ประวัติการรับทุนการศึกษา',
      navigateScreen: '/scholarship',
      url: '',
    ),
    AffairsListData(
      imagePath: 'assets/fitness_app/AF4.png',
      titleTxt: 'ร่วมกิจกรรมต่างๆ ของนักศึกษา',
      subTxt: 'ร่วมกิจกรรมต่างๆ ของนักศึกษา',
      navigateScreen: '/affairs',
      url: '',
    ),
  ];
}
