import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/master/models/master_grade_list_data.dart';
import 'package:th.ac.ru.uSmart/master/models/master_register.dart';
import 'package:th.ac.ru.uSmart/master/providers/master_register_provider.dart';

class MasterRegisterRowView extends StatefulWidget {
  const MasterRegisterRowView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _MasterRegisterRowViewState createState() => _MasterRegisterRowViewState();
}

class _MasterRegisterRowViewState extends State<MasterRegisterRowView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<MasterGradeListData> gradeListData = MasterGradeListData.tabIconsList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
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
    var prov = Provider.of<MasterRegisterProvider>(context, listen: false);
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
              child: prov.listGroupYearSemester.isEmpty
                  ? Container(
                      padding: const EdgeInsets.only(
                          top: 32, bottom: 8, right: 8, left: 8),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 240, 232, 232),
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
                      child: Text('ไม่พบข้อมูลลงทะเบียน'))
                  : Container(
                      padding: const EdgeInsets.only(
                          top: 32, bottom: 16, right: 8, left: 8),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 245, 242, 242),
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
                      height: (130.0 * prov.listGroupYearSemester.length),
                      width: double.infinity,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, right: 8, left: 8),
                        itemCount: prov.listGroupYearSemester.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          final int count =
                              prov.listGroupYearSemester.length > 10
                                  ? 10
                                  : prov.listGroupYearSemester.length;
                          final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                      parent: animationController!,
                                      curve: Interval((1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn)));
                          animationController?.forward();
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, right: 16, left: 8),
                                decoration: BoxDecoration(
                                  color: FitnessAppTheme.nearlyWhite,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      bottomLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0),
                                      topRight: Radius.circular(68.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: FitnessAppTheme.grey
                                            .withOpacity(0.2),
                                        offset: Offset(1.1, 1.1),
                                        blurRadius: 10.0),
                                  ],
                                ),
                                height: 50.0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.book,
                                            color: FitnessAppTheme.grey,
                                            size: 18,
                                          ),
                                          Text(
                                            'ภาคเรียนที่ ${prov.listGroupYearSemester.entries.elementAt(index).key}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              letterSpacing: 0.2,
                                              color: FitnessAppTheme.dark_grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '${prov.listGroupYearSemester.entries.elementAt(index).value.length} วิชา',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        letterSpacing: 0.2,
                                        color: FitnessAppTheme.dark_grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListRegisterListValueView(
                                listData: prov.listGroupYearSemester.entries
                                    .elementAt(index)
                                    .value,
                                animation: animation,
                                animationController: animationController!,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

class ListRegisterListValueView extends StatelessWidget {
  const ListRegisterListValueView(
      {Key? key, this.listData, this.animationController, this.animation})
      : super(key: key);
  final List<REGISTERECORDVIEW>? listData;
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
                200 * (1.0 - animation!.value), 0.0, 0.0),
            child: Container(
              height: 150.0,
              width: double.infinity,
              child: ListView.builder(
                itemCount: listData!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                      listData!.length > 10 ? 10 : listData!.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RowRegisterView(
                        index: index,
                        course: listData!.elementAt(index),
                        animation: animation,
                        animationController: animationController!,
                      )
                    ],
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

class RowRegisterView extends StatelessWidget {
  const RowRegisterView(
      {Key? key,
      this.index,
      this.course,
      this.animationController,
      this.animation})
      : super(key: key);

  final int? index;
  final REGISTERECORDVIEW? course;
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
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => MasterGradeYearScreen(
                //           animationController: animationController!,
                //           yearSemester: gradeListData!.yearSemester,
                //           grades: gradeListData!.grades),
                //     ));
              },
              child: SizedBox(
                width: 120,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16, left: 16, right: 16, bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: HexColor(course!.endColor!)
                                    .withOpacity(0.6),
                                offset: const Offset(1.1, 4.0),
                                blurRadius: 8.0),
                          ],
                          gradient: LinearGradient(
                            colors: <HexColor>[
                              HexColor(course!.startColor!),
                              HexColor(course!.endColor!),
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
                              top: 40, left: 16, right: 16, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                course!.courseNo!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: FitnessAppTheme.white,
                                ),
                              ),
                              Text(
                                '${course!.credit.toString()} หน่วยกิต',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: FitnessAppTheme.white,
                                ),
                              ),
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
                        child: Image.asset(course!.imagePath!),
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
