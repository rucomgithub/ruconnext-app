import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';

class MasterGradeYearListView extends StatefulWidget {
  const MasterGradeYearListView(
      {Key? key,
      this.mainScreenAnimationController,
      this.mainScreenAnimation,
      this.yearSemester,
      this.grades})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  final List<String>? grades;
  final String? yearSemester;
  @override
  _MasterGradeYearListViewState createState() =>
      _MasterGradeYearListViewState();
}

class _MasterGradeYearListViewState extends State<MasterGradeYearListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<String> areaListData = <String>[
    'assets/fitness_app/area1.png',
    'assets/fitness_app/area2.png',
    'assets/fitness_app/area3.png',
    'assets/fitness_app/area1.png',
  ];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 100 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                child: ListView(
                  padding: EdgeInsets.all(4.0),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: List<Widget>.generate(
                    widget.grades!.length,
                    (int index) {
                      final int count = widget.grades!.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController!,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      animationController?.forward();
                      return AreaView(
                        index: index,
                        course: widget.grades![index],
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

class AreaView extends StatelessWidget {
  const AreaView({
    Key? key,
    this.index,
    this.course,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final int? index;
  final String? course;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        List<String> parts = this.course.toString().split(',');
        EdgeInsets listItemPadding =
            EdgeInsets.only(left: 0, bottom: 4, top: 4, right: 40);
        Color gradColor = AppTheme.ru_text_light_blue;
        if (parts[1].contains("F")) {
          listItemPadding =
              EdgeInsets.only(left: 40, bottom: 4, top: 4, right: 0);
          gradColor = AppTheme.ru_text_grey;
        }
        return Padding(
          padding: listItemPadding,
          child: FadeTransition(
            opacity: animation!,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 80 * (1.0 - animation!.value), 0.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: FitnessAppTheme.nearlyWhite.withOpacity(0.9),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topRight: Radius.circular(8.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: FitnessAppTheme.grey.withOpacity(0.4),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        splashColor:
                            FitnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 8),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppTheme.ru_text_light_blue
                                          .withOpacity(0.9),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: FitnessAppTheme.grey
                                                .withOpacity(0.4),
                                            offset: const Offset(1.1, 1.1),
                                            blurRadius: 10.0),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons.book_sharp,
                                        color: AppTheme.white,
                                        size: baseFontSize - 4,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${parts[0]}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: baseFontSize - 4,
                                        color: AppTheme.ru_text_ocean_blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text(
                                '${parts[1]}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontSize: baseFontSize - 4,
                                  color: gradColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: FitnessAppTheme.nearlyWhite.withOpacity(0.9),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topRight: Radius.circular(0.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: FitnessAppTheme.grey.withOpacity(0.4),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        splashColor:
                            FitnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                '${parts[2]} หน่วยกิต',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontSize: baseFontSize - 4,
                                  color: AppTheme.ru_text_grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
