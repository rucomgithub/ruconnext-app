import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../providers/grade_provider.dart';
import '../models/grade_list_data.dart';
import '../ui_view/gradeyear_screen.dart';

class YearSemesterListView extends StatefulWidget {
  const YearSemesterListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _YearSemesterListViewState createState() => _YearSemesterListViewState();
}

class _YearSemesterListViewState extends State<YearSemesterListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<GradeListData> gradeListData = GradeListData.tabIconsList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
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
    var prov = Provider.of<GradeProvider>(context, listen: false);
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: Container(
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
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();

                  return YearSemesterView(
                    gradeListData: prov.gradeYearSemester[index],
                    animation: animation,
                    animationController: animationController!,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class YearSemesterView extends StatelessWidget {
  const YearSemesterView(
      {Key? key, this.gradeListData, this.animationController, this.animation})
      : super(key: key);

  final GradeListData? gradeListData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
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
                      builder: (context) => GradeYearScreen(
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
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 0.2,
                                  color: AppTheme.white,
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
                                          height: 100.0,
                                          width: 80.0,
                                          child: Text(
                                            gradeListData!.grades!
                                                .asMap()
                                                .map((index, value) => MapEntry(
                                                    index,
                                                    '${index + 1}.$value'))
                                                .values
                                                .join('\n'),
                                            style: TextStyle(
                                              fontFamily:
                                                  AppTheme.ruFontKanit,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                              letterSpacing: 0.2,
                                              color: AppTheme.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              gradeListData?.creditsum != 0
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          gradeListData!.creditsum.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                AppTheme.ruFontKanit,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            letterSpacing: 0.2,
                                            color: AppTheme.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, bottom: 0),
                                          child: Text(
                                            'หน่วยกิต',
                                            style: TextStyle(
                                              fontFamily:
                                                  AppTheme.ruFontKanit,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              letterSpacing: 0.2,
                                              color: AppTheme.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        color: AppTheme.nearlyWhite,
                                        shape: BoxShape.circle,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: AppTheme.nearlyBlack
                                                  .withOpacity(0.4),
                                              offset: Offset(8.0, 8.0),
                                              blurRadius: 8.0),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Icon(
                                          Icons.add,
                                          color:
                                              HexColor(gradeListData!.endColor),
                                          size: 24,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 84,
                        height: 84,
                        decoration: BoxDecoration(
                          color: AppTheme.nearlyWhite.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 8,
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset(gradeListData!.imagePath),
                        //child: Text(gradeListData!.),
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
