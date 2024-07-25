import 'dart:ffi';

import 'package:th.ac.ru.uSmart/app_theme.dart';
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
    await Future<dynamic>.delayed(const Duration(milliseconds: 600));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MasterGradeProvider>(context, listen: false);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;
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
                  color: AppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(48.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.ru_yellow,
                        offset: Offset(1.1, 1.1),
                        blurRadius: 5.0),
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'หน่วยกิตสะสม',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                  fontSize: baseFontSize,
                                                  letterSpacing: -0.2,
                                                  color: AppTheme.ru_dark_blue,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: screenWidth * 0.15,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: <HexColor>[
                                                      HexColor("#FF19196B"),
                                                      HexColor("#FF1919EB"),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(16.0),
                                                    bottomLeft:
                                                        Radius.circular(16.0),
                                                    topLeft:
                                                        Radius.circular(16.0),
                                                    topRight:
                                                        Radius.circular(16.0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '${prov.grade.summaryCredit}',
                                                    //'87',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppTheme.ruFontKanit,
                                                      letterSpacing: -0.2,
                                                      fontSize: baseFontSize,
                                                      color: AppTheme.ru_yellow,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'คะแนนเฉลี่ยสะสม',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                  fontSize: baseFontSize,
                                                  letterSpacing: -0.2,
                                                  color: AppTheme.ru_dark_blue,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Container(
                                                width: screenWidth * 0.15,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: <HexColor>[
                                                      HexColor("#FF19196B"),
                                                      HexColor("#FF1919FB"),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(16.0),
                                                    bottomLeft:
                                                        Radius.circular(16.0),
                                                    topLeft:
                                                        Radius.circular(16.0),
                                                    topRight:
                                                        Radius.circular(16.0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '${prov.grade.gpa}',
                                                    //'87',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppTheme.ruFontKanit,
                                                      fontSize: baseFontSize,
                                                      color: AppTheme.ru_yellow,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
