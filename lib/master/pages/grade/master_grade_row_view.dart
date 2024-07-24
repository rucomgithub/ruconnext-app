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
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: FitnessAppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: FitnessAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: prov.gradeYearSemester.isEmpty
                    ? Text('ไม่พบข้อมูล')
                    : Container(
                        height: 216,
                        width: double.infinity,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 0, right: 16, left: 16),
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

    return AnimatedBuilder(
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
                width: 130,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 32, left: 8, right: 8, bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: HexColor(gradeListData!.endColor)
                                    .withOpacity(0.6),
                                offset: const Offset(1.1, 4.0),
                                blurRadius: 8.0),
                          ],
                          gradient: LinearGradient(
                            colors: <HexColor>[
                              HexColor(gradeListData!.startColor),
                              HexColor(gradeListData!.endColor),
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
                              top: 54, left: 16, right: 16, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                gradeListData!.yearSemester,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 0.2,
                                  color: FitnessAppTheme.white,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: SingleChildScrollView(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 80.0,
                                          child: Text(
                                            formattedGrades,
                                            style: TextStyle(
                                              fontFamily:
                                                  FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                              letterSpacing: 0.2,
                                              color: FitnessAppTheme.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    gradeListData!.creditsum.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      letterSpacing: 0.2,
                                      color: FitnessAppTheme.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, bottom: 0),
                                    child: Text(
                                      'หน่วยกิต',
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        letterSpacing: 0.2,
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
                      top: 20,
                      left: 20,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset(gradeListData!.imagePath),
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
