import 'dart:ffi';

import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/models/grade_list_data.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/model/rotcs_extend.dart';
import 'package:th.ac.ru.uSmart/providers/rotcs_provider.dart';
import 'package:th.ac.ru.uSmart/widget/card/card_book_title.dart';

class RotcsExtendListView extends StatefulWidget {
  const RotcsExtendListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _RotcsExtendListViewState createState() => _RotcsExtendListViewState();
}

class _RotcsExtendListViewState extends State<RotcsExtendListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<GradeListData> gradeListData = GradeListData.tabIconsList;

  @override
  void initState() {
    Provider.of<RotcsProvider>(context, listen: false).getAllExtend();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loading = context.watch<RotcsProvider>().isLoading;
    var extend = context.watch<RotcsProvider>().rotcsextend;
    var error = context.watch<RotcsProvider>().rotcserror;

    return extend.studentCode!.isEmpty
        ? SizedBox()
        : Column(
            children: [
              AnimatedBuilder(
                animation: widget.mainScreenAnimationController!,
                builder: (BuildContext context, Widget? child) {
                  return FadeTransition(
                    opacity: widget.mainScreenAnimation!,
                    child: Transform(
                      transform: Matrix4.translationValues(0.0,
                          30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 250,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: extend.detail!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              final int count = extend.detail!.length > 10
                                  ? 10
                                  : extend.detail!.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                          parent: animationController!,
                                          curve: Interval(
                                              (1 / count) * index, 1.0,
                                              curve: Curves.fastOutSlowIn)));
                              animationController?.forward();
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 16.0, bottom: 8.0),
                                child: CardBookTitle(
                                  iconheader:
                                      extend.detail![index].description ==
                                              "ผ่อนผัน"
                                          ? Icons.add_business
                                          : Icons.check_box,
                                  iconfooter: Icons.credit_score,
                                  header:
                                      '${extend.detail![index].description}',
                                  title: '',
                                  footer:
                                      '${extend.detail![index].credit} หน่วยกิต',
                                  content:
                                      'ปีการศึกษา ${extend.detail![index].registerYear}/${extend.detail![index].registerSemester}',
                                  animation: animation,
                                  animationController: animationController!,
                                ),
                              );
                            },
                          ),
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
