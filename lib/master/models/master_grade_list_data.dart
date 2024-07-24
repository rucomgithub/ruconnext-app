class MasterGradeListData {
  MasterGradeListData({
    this.imagePath = '',
    this.yearSemester = '',
    this.startColor = '#FA7D82',
    this.endColor = '#FFB295',
    this.grades,
    this.creditsum = 0,
  });

  String imagePath;
  String yearSemester;
  String startColor;
  String endColor;
  List<String>? grades;
  int creditsum;

  static List<MasterGradeListData> tabIconsList = <MasterGradeListData>[
    MasterGradeListData(
      imagePath: '',
      yearSemester: '',
      creditsum: 525,
      grades: [],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
  ];
}
