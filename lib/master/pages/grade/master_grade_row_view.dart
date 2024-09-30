import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/master/models/master_grade_list_data.dart';
import 'package:th.ac.ru.uSmart/master/pages/grade/master_gradeyear_screen.dart';
import 'package:th.ac.ru.uSmart/master/providers/master_grade_provider.dart';
import 'package:th.ac.ru.uSmart/widget/card/card_book.dart';

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
                        height: 240,
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
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0,
                                      left: 8.0,
                                      bottom: 8.0,
                                      right: 8),
                                  child: CardBook(
                                    index: index,
                                    icondata: Icons.book,
                                    title: prov
                                        .gradeYearSemester[index].yearSemester,
                                    content:
                                        '${prov.gradeYearSemester[index].creditsum} หน่วยกิต ',
                                    callback: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MasterGradeYearScreen(
                                                    animationController:
                                                        animationController!,
                                                    yearSemester: prov
                                                        .gradeYearSemester[
                                                            index]
                                                        .yearSemester,
                                                    grades: prov
                                                        .gradeYearSemester[
                                                            index]
                                                        .grades),
                                          ));
                                    },
                                    animation: animation,
                                    animationController: animationController!,
                                  ),
                                )
                              ],
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
