class ManualListData {
  ManualListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.navigateScreen = '',
  });
  String imagePath;
  String titleTxt;
  String subTxt;
  String navigateScreen;

  static List<ManualListData> manualList = <ManualListData>[
    ManualListData(
      imagePath: 'assets/fitness_app/A2.png',
      titleTxt: 'หน้าแรก',
      subTxt: 'การใช้งานเบื้องต้นของหน้าแรก',
      navigateScreen: '/homehelp',
    ),
    ManualListData(
      imagePath: 'assets/fitness_app/A1.png',
      titleTxt: 'หน้าบัตรนักศึกษา',
      subTxt: 'การใช้งานเบื้องต้นหน้าบัตรนักศึกษา',
      navigateScreen: '/cardhelp',
    ),
    ManualListData(
      imagePath: 'assets/fitness_app/A9.png',
      titleTxt: 'หน้าข้อมูลผลการเรียนทั้งหมด',
      subTxt: 'การใช้งานเบื้องต้นหน้าข้อมูลผลการเรียนทั้งหมด',
      navigateScreen: '/gradehelp',
    ),
    ManualListData(
      imagePath: 'assets/fitness_app/A2.png',
      titleTxt: 'หน้าข้อมูลการลงทะเบียน',
      subTxt: 'การใช้งานข้อมูลการลงทะเบียน',
      navigateScreen: '/regishelp',
    ),
    ManualListData(
      imagePath: 'assets/fitness_app/A7.png',
      titleTxt: 'หน้ามร.30',
      subTxt: 'การใช้งานมร.30',
      navigateScreen: '/mr30help',
    ),
    ManualListData(
      imagePath: 'assets/fitness_app/A14.png',
      titleTxt: 'หน้าข่าวประชาสัมพันธ์',
      subTxt: 'การใช้งานข่าวประชาสัมพันธ์',
      navigateScreen: '/newshelp',
    ),
    ManualListData(
      imagePath: 'assets/fitness_app/A20.png',
      titleTxt: 'หน้าปฏิทินกิจกรรม',
      subTxt: 'การใช้งานปฏิทินกิจกรรม',
      navigateScreen: '/schedulehelp',
    ),
  ];
}
