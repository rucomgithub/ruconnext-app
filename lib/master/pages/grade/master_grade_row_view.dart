import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/master/models/master_grade_list_data.dart';
import 'package:th.ac.ru.uSmart/master/pages/grade/master_gradeyear_screen.dart';
import 'package:th.ac.ru.uSmart/master/providers/master_grade_provider.dart';

class MasterGradeRowView extends StatefulWidget {
  const MasterGradeRowView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _MasterGradeRowViewState createState() => _MasterGradeRowViewState();
}

class _MasterGradeRowViewState extends State<MasterGradeRowView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<MasterGradeListData> gradeListData = MasterGradeListData.tabIconsList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    Provider.of<MasterGradeProvider>(context, listen: false).getAllGrade();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 1200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    var prov = Provider.of<MasterGradeProvider>(context, listen: false);
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/ID.png'),
                    fit: BoxFit.cover,
                    opacity: 0.2,
                  ),
                  color: isLightMode ? AppTheme.nearlyWhite : AppTheme.ru_grey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(48.0)),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.ru_yellow.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(4, 4),
                    ),
                  ],
                ),
                child: prov.gradeYearSemester.isEmpty
                    ? Text('ไม่พบข้อมูล')
                    : Container(
                        height: screenHeight * 0.3,
                        width: double.infinity,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, right: 8, left: 8),
                          itemCount: prov.gradeYearSemester.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            final int count = prov.gradeYearSemester.length > 10
                                ? 10
                                : prov.gradeYearSemester.length;
                            final Animation<double> animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                        parent: animationController!,
                                        curve: Interval(
                                            (1 / count) * index, 1.0,
                                            curve: Curves.fastOutSlowIn)));
                            animationController?.forward();

                            return ListRowGradeView(
                              gradeListData: prov.gradeYearSemester[index],
                              animation: animation,
                              animationController: animationController!,
                            );
                          },
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ListRowGradeView extends StatelessWidget {
  const ListRowGradeView(
      {Key? key, this.gradeListData, this.animationController, this.animation})
      : super(key: key);

  final MasterGradeListData? gradeListData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    final String formattedGrades = (gradeListData?.grades != null)
        ? gradeListData!.grades!
            .asMap()
            .entries
            .map((entry) => '${entry.key + 1}. ${entry.value}')
            .join('\n')
        : '';

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;

    return formattedGrades.isEmpty
        ? SizedBox()
        : AnimatedBuilder(
            animation: animationController!,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: animation!,
                child: Transform(
                  transform: Matrix4.translationValues(
                      100 * (1.0 - animation!.value), 0.0, 0.0),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MasterGradeYearScreen(
                                animationController: animationController!,
                                yearSemester: gradeListData!.yearSemester,
                                grades: gradeListData!.grades),
                          ));
                    },
                    child: SizedBox(
                      width: screenWidth * 0.4,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 8, right: 8, bottom: 16),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/ID.png'),
                                  fit: BoxFit.cover,
                                  opacity: 0.08,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppTheme.ru_dark_blue.withOpacity(0.4),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(4, 4),
                                  ),
                                ],
                                gradient: LinearGradient(
                                  colors: <HexColor>[
                                    HexColor("#FF19196B"),
                                    HexColor("#FF1919EB"),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0),
                                  topLeft: Radius.circular(48.0),
                                  topRight: Radius.circular(8.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, left: 16, right: 16, bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      gradeListData!.yearSemester,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontWeight: FontWeight.w200,
                                        fontSize: baseFontSize - 4,
                                        letterSpacing: 0.2,
                                        color: AppTheme.ru_yellow,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16, bottom: 8),
                                        child: SingleChildScrollView(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                formattedGrades,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                  fontSize: baseFontSize - 10,
                                                  letterSpacing: 0.2,
                                                  color: FitnessAppTheme.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          gradeListData!.creditsum.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.ruFontKanit,
                                            fontSize: baseFontSize - 4,
                                            color: AppTheme.ru_yellow,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4),
                                          child: Text(
                                            'หน่วยกิต',
                                            style: TextStyle(
                                              fontFamily: AppTheme.ruFontKanit,
                                              fontSize: baseFontSize - 10,
                                              color: FitnessAppTheme.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 12,
                            left: 10,
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: AppTheme.nearlyWhite.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 14,
                            left: 14,
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.book_rounded,
                                    size: baseFontSize + 16,
                                    color: AppTheme.ru_dark_blue,
                                  ),
                                  Positioned(
                                    top: 12,
                                    left: 18,
                                    child: Text(
                                      gradeListData!.grades!.length.toString(),
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        color:
                                            AppTheme.ru_yellow.withOpacity(0.8),
                                        fontSize: baseFontSize - 8,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
