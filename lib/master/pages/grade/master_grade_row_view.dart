import 'package:th.ac.ru.uSmart/app_theme.dart';
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
            child: prov.gradeYearSemester.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      padding: const EdgeInsets.all(32.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.1),
                            offset: const Offset(0, 4),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.inbox_outlined,
                              size: 48,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'ไม่พบข้อมูล',
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontSize: 16,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: SizedBox(
                      height: 190,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemCount: prov.gradeYearSemester.length,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
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

                          final bool isEven = index % 2 == 0;
                          final Color primaryColor = isEven
                              ? AppTheme.ru_yellow
                              : AppTheme.ru_dark_blue;
                          final Color secondaryColor = isEven
                              ? AppTheme.ru_dark_blue
                              : AppTheme.ru_yellow;

                          return AnimatedBuilder(
                            animation: animationController!,
                            builder: (BuildContext context, Widget? child) {
                              return FadeTransition(
                                opacity: animation,
                                child: Transform(
                                  transform: Matrix4.translationValues(
                                      100 * (1.0 - animation.value), 0.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        onTap: () {
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
                                        child: Container(
                                          width: 170,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            border: Border.all(
                                              color: primaryColor,
                                              width: 2,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: primaryColor,
                                                offset: const Offset(0, 6),
                                                blurRadius: 16,
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Icon Section
                                              Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                decoration: BoxDecoration(
                                                  color: secondaryColor,
                                                  // gradient: LinearGradient(
                                                  //   colors: [
                                                  //     primaryColor,
                                                  //     secondaryColor
                                                  //   ],
                                                  //   begin: Alignment.topLeft,
                                                  //   end: Alignment.bottomRight,
                                                  // ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(18.0),
                                                    topRight:
                                                        Radius.circular(18.0),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withValues(
                                                                    alpha: 0.2),
                                                            offset:
                                                                const Offset(
                                                                    0, 4),
                                                            blurRadius: 8,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Icon(
                                                        Icons.school,
                                                        color: primaryColor,
                                                        size: 32,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Content Section
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 12.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        prov
                                                            .gradeYearSemester[
                                                                index]
                                                            .yearSemester,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily: AppTheme
                                                              .ruFontKanit,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppTheme
                                                              .ru_dark_blue,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12,
                                                                vertical: 6),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons.credit_card,
                                                              size: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            const SizedBox(
                                                                width: 4),
                                                            Text(
                                                              '${prov.gradeYearSemester[index].creditsum}',
                                                              style: TextStyle(
                                                                fontFamily: AppTheme
                                                                    .ruFontKanit,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 2),
                                                            Text(
                                                              'หน่วยกิต',
                                                              style: TextStyle(
                                                                fontFamily: AppTheme
                                                                    .ruFontKanit,
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
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
