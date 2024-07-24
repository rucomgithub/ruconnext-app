import 'package:th.ac.ru.uSmart/fitness_app/ui_view/wave_view.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:th.ac.ru.uSmart/master/providers/master_grade_provider.dart';
import 'package:th.ac.ru.uSmart/providers/grade_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MasterSummaryCreditView extends StatefulWidget {
  const MasterSummaryCreditView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _MasterSummaryCreditViewState createState() =>
      _MasterSummaryCreditViewState();
}

class _MasterSummaryCreditViewState extends State<MasterSummaryCreditView>
    with TickerProviderStateMixin {
  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
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
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: FitnessAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: prov.summaryCreditPass.isEmpty
                    ? Text('ไม่พบข้อมูล')
                    : Padding(
                        padding: const EdgeInsets.only(
                            top: 16, left: 16, right: 16, bottom: 16),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, bottom: 8),
                                            child: Text(
                                              'หน่วยกิตสะสม',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                                letterSpacing: -0.2,
                                                color: FitnessAppTheme
                                                    .nearlyDarkBlue,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, bottom: 3),
                                            child: Text(
                                              '${prov.grade.summaryCredit}',
                                              //'87',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 28,
                                                color: FitnessAppTheme
                                                    .nearlyDarkBlue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, bottom: 8),
                                            child: Text(
                                              'คะแนนเฉลี่ยสะสม',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                                letterSpacing: -0.2,
                                                color: FitnessAppTheme
                                                    .nearlyDarkBlue,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, bottom: 3),
                                            child: Text(
                                              '${prov.grade.gpa}',
                                              //'87',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 28,
                                                color: FitnessAppTheme
                                                    .nearlyDarkBlue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 4, top: 8, bottom: 16),
                                    child: Container(
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: FitnessAppTheme.background,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
