class GradeListData {
  GradeListData({
    this.imagePath = '',
    this.yearSemester = '',
    this.startColor = '',
    this.endColor = '',
    this.grades,
    this.creditsum = 0,
  });

  String imagePath;
  String yearSemester;
  String startColor;
  String endColor;
  List<String>? grades;
  int creditsum;

  static List<GradeListData> tabIconsList = <GradeListData>[
    GradeListData(
      imagePath: 'assets/fitness_app/breakfast.png',
      yearSemester: 'Breakfast',
      creditsum: 525,
      grades: <String>['Bread,', 'Peanut butter,', 'Apple'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    GradeListData(
      imagePath: 'assets/fitness_app/lunch.png',
      yearSemester: 'Lunch',
      creditsum: 602,
      grades: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    GradeListData(
      imagePath: 'assets/fitness_app/snack.png',
      yearSemester: 'Snack',
      creditsum: 0,
      grades: <String>['Recommend:', '800 kcal'],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    GradeListData(
      imagePath: 'assets/fitness_app/dinner.png',
      yearSemester: 'Dinner',
      creditsum: 0,
      grades: <String>['Recommend:', '703 kcal'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
