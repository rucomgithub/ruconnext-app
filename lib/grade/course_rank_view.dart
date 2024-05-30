import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';
import '../providers/grade_provider.dart';

class CourseRankView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const CourseRankView(
      {Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<GradeProvider>(context, listen: false);

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.ru_grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4, bottom: 8, top: 16),
                            child: Text(
                              '4 อันดับแรก',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  letterSpacing: -0.1,
                                  color: AppTheme.ru_text_grey),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, bottom: 3),
                                    child: Text(
                                      prov.groupCourse.entries.elementAt(0).key,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: 22,
                                        color: AppTheme.ru_text_ocean_blue,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, bottom: 8),
                                    child: Text(
                                      '(1)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: 18,
                                        letterSpacing: -0.2,
                                        color: AppTheme.ru_text_grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.access_time,
                                        color: AppTheme.ru_text_grey
                                            .withOpacity(0.5),
                                        size: 16,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          // 'ลงทะเบียน ${prov.groupCourse.entries.elementAt(0).value['count'].toString()} ครั้ง',
                                          'ลงทะเบียน ${prov.groupCourse.entries.elementAt(0).value['count'].toString()} ครั้ง',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                AppTheme.ruFontKanit,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: AppTheme.ru_text_ocean_blue
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 14),
                                    child: Text(
                                      'ทั้งหมด ${prov.groupCourse.entries.elementAt(0).value['credit_sum'].toString()} หน่วยกิต',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: 14,
                                        letterSpacing: 0.0,
                                        color: AppTheme.ru_text_grey,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 8),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${prov.groupCourse.entries.elementAt(1).key} (2)',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 14,
                                    letterSpacing: -0.2,
                                    color: AppTheme.ru_text_ocean_blue,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    '${prov.groupCourse.entries.elementAt(1).value['count'].toString()} ครั้ง (${prov.groupCourse.entries.elementAt(1).value['credit_sum'].toString()})',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: 12,
                                      color:
                                          AppTheme.ru_text_grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${prov.groupCourse.entries.elementAt(2).key} (3)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: -0.2,
                                        color: AppTheme.ru_text_ocean_blue,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        '${prov.groupCourse.entries.elementAt(2).value['count'].toString()} ครั้ง (${prov.groupCourse.entries.elementAt(2).value['credit_sum'].toString()})',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 12,
                                          color: AppTheme.ru_text_grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      '${prov.groupCourse.entries.elementAt(3).key} (4)',
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: -0.2,
                                        color: AppTheme.ru_text_ocean_blue,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        '${prov.groupCourse.entries.elementAt(3).value['count'].toString()} ครั้ง (${prov.groupCourse.entries.elementAt(3).value['credit_sum'].toString()})',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 12,
                                          color: AppTheme.ru_text_grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
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
