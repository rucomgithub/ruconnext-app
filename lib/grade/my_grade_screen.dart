import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/my_diary/yearsemester_list_view.dart';
import 'package:th.ac.ru.uSmart/fitness_app/ui_view/glass_view.dart';

import 'package:th.ac.ru.uSmart/fitness_app/ui_view/title_view.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/grade/course_rank_view.dart';
import 'package:th.ac.ru.uSmart/grade/summary_credit_view.dart';
import 'package:th.ac.ru.uSmart/grade/summary_grade_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/widget/RadarChartWidget.dart';

import '../providers/grade_provider.dart';
import '../fitness_app/ui_view/titlenone_view.dart';

class MyGradeScreen extends StatefulWidget {
  const MyGradeScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;
  @override
  _MyGradeScreenState createState() => _MyGradeScreenState();
}

class _MyGradeScreenState extends State<MyGradeScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
    Provider.of<GradeProvider>(context, listen: false).getAllGrade();
    Provider.of<GradeProvider>(context, listen: false).getMr30Catalog();
  }

  void addAllListData() {
    const int count = 9;

    var prov = Provider.of<GradeProvider>(context, listen: false);

    listViews.add(
      TitleNoneView(
        titleTxt: 'เกรดแยกตามปี/ภาค',
        subTxt: 'รายละเอียด',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      YearSemesterListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: Interval((1 / count) * 3, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );

    listViews.add(
      TitleNoneView(
        titleTxt: 'สัดส่วนการสอบผ่าน',
        subTxt: 'รายละเอียด',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      SummaryCreditView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: Interval((1 / count) * 6, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController!,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'ความถนัดของนักศึกษา',
        subTxt: 'รายละเอียด',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      SizedBox(
        height: 250,
        width: 250,
        child: RadarChartWidget(
            grades: prov.gradesCatalog,
            counts: prov.countsCatalog,
            ticks: prov.ticksCatalog),
      ),
    );
    // listViews.add(
    //   Text('ความถนัดด้านมนุษย์สัมพันธ์ (Interpersonal Intelligence) ความสามารถในการเข้าใจผู้อื่น ทั้งด้านความรู้สึกนึกคิด อารมณ์ เจตนาที่ซ่อนเร้น มีความไวในการสังเกตสีหน้า ท่าทาง อารมณ์ของคนอื่น และตอบสนองสิ่งเหล่านั้นได้เหมาะสม สร้างมิตรภาพได้ง่าย เจรจาต่อรองเก่งและชักจูงผู้อื่นได้ดีชอบมีเพื่อน ชอบพบปะผู้คนร่วมสังสรรค์กับผู้อื่นชอบเป็นผู้นำหรือมีส่วนร่วมในกลุ่ชอบแสดงออกให้ผู้อื่นทำตาม ช่วยเหลือผู้อื่น ทำงานหรือประสานงานกับผู้อื่นได้ดีชอบพูดชักจูงให้ผู้อื่นทำมากกว่าจะลงมือทำด้วยตนเองเข้าใจผู้อื่นได้ดี สามารถอ่านกิริยาท่าทางของผู้อื่นได้มักจะมีเพื่อนสนิทหลายคนชอบสังคม อยู่ร่วมกับผู้อื่นมากกว่าจะอยู่คนเดียวที่บ้านในวันหยุดอาชีพที่เหมาะสม : นักบริหาร ผู้จัดการ นักธุรกิจ นักการตลาด นักประชาสัมพันธ์ ครู'),
    // );
    //     for (var item in prov.catalogsCombine) {
    //     listViews.add(Text('วิชา:${item.cOURSENO} ///// กลุ่ม: ${item.typeNo}///// grade: ${item.grade}'));

    // }

    listViews.add(
      TitleView(
        titleTxt: 'สรุปรายการเกรด',
        subTxt: 'รายละเอียด',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    // listViews.add(
    //   SizedBox(
    //     height: 250,
    //     width: 250,
    //     child: RadarChartWidget(
    //         grades: prov.grades, counts: prov.counts, ticks: prov.ticks),
    //   ),
    // );

    listViews.add(
      SummaryGradeView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'อันดับการลงทะเบียน',
        subTxt: 'รายละเอียด',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      CourseRankView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 600));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppTheme.grey.withOpacity(0.4 * topBarOpacity),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16 - 8.0 * topBarOpacity,
                          bottom: 12 - 8.0 * topBarOpacity,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'ผลการศึกษา',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: AppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Icon(
                                      Icons.person,
                                      color: AppTheme.grey,
                                      size: 18,
                                    ),
                                  ),
                                  Text(
                                    '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                      letterSpacing: -0.2,
                                      color: AppTheme.darkerText,
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
            );
          },
        ),
      ],
    );
  }
}
