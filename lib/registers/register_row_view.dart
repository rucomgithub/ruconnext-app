import 'package:get/get.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/model/register_model.dart';
import 'package:th.ac.ru.uSmart/providers/mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/register_provider.dart';

class RegisterRowView extends StatefulWidget {
  const RegisterRowView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _RegisterRowViewState createState() => _RegisterRowViewState();
}

class _RegisterRowViewState extends State<RegisterRowView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    Provider.of<RegisterProvider>(context, listen: false).getAllRegisterYear();
    Provider.of<RegisterProvider>(context, listen: false).getAllMr30Catalog();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 600));
    return true;
  }

  Future<void> loadData(BuildContext context) async {
    //print("call provider");
    Provider.of<RegisterProvider>(context, listen: false).getAllRegisterYear();
    Provider.of<RegisterProvider>(context, listen: false).getAllMr30Catalog();
  }

  Future<void> refreshData(BuildContext context) async {
    //print("refresh register");
    await loadData(context);
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<RegisterProvider>(context, listen: false);
    return RefreshIndicator(
      onRefresh: () => refreshData(context),
      child: Consumer<RegisterProvider>(builder: (context1, provider, _) {
        if (provider.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
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
                        left: 30, right: 16, top: 16, bottom: 16),
                    child: prov.listGroupCourse.isEmpty
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
                                    color:
                                        FitnessAppTheme.grey.withOpacity(0.2),
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
                                    color:
                                        FitnessAppTheme.grey.withOpacity(0.2),
                                    offset: Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),
                            height: 240.0 * prov.listGroupCourse.length,
                            width: double.infinity,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, right: 8, left: 8),
                              itemCount: prov.listGroupCourse.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                final int count =
                                    prov.listGroupCourse.length > 4
                                        ? 10
                                        : prov.listGroupCourse.length;
                                final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                        CurvedAnimation(
                                            parent: animationController!,
                                            curve: Interval(
                                                (1 / count) * index, 1.0,
                                                curve: Curves.fastOutSlowIn)));
                                animationController?.forward();
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 8,
                                          bottom: 8,
                                          right: 16,
                                          left: 8),
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
                                            padding:
                                                const EdgeInsets.only(right: 8),
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
                                                  'ภาคเรียนที่ ${prov.listGroupCourse.entries.elementAt(index).key}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: FitnessAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    letterSpacing: 0.2,
                                                    color: FitnessAppTheme
                                                        .dark_grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            '${prov.listGroupCourse.entries.elementAt(index).value.length} วิชา',
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
                                    ListRegisterListValueView(
                                      listData: prov.listGroupCourse.entries
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
      }),
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
    var mr30Prov = context.watch<MR30Provider>();
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                200 * (1.0 - animation!.value), 0.0, 0.0),
            child: Container(
              height: 160.0,
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
                        callback: () {
                          Get.toNamed('/ondemand', arguments: {
                            'course': '${listData![index].courseNo}',
                            'semester':
                                '${mr30Prov.yearsemester.semester.toString()}',
                            'year':
                                '${mr30Prov.yearsemester.year.toString().substring(2, 4)}'
                          });
                        },
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
      this.callback,
      this.animationController,
      this.animation})
      : super(key: key);
  final VoidCallback? callback;
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
              onTap: callback,
              child: SizedBox(
                width: 140,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 8),
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
                              top: 50, left: 8, right: 8, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  '${course!.credit.toString()} หน่วยกิต',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    color: AppTheme.ru_yellow,
                                  ),
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: AppTheme.nearlyWhite,
                                        shape: BoxShape.rectangle,
                                        borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(16.0),
                                          bottomLeft: Radius.circular(16.0),
                                          topLeft: Radius.circular(16.0),
                                          topRight: Radius.circular(16.0),
                                        ),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: AppTheme.nearlyBlack
                                                  .withOpacity(0.4),
                                              offset: Offset(2.0, 2.0),
                                              blurRadius: 4.0),
                                        ],
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.book),
                                              Text(
                                                '${course!.courseNo.toString()}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: AppTheme.nearlyBlack,
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //     border: Border.all(
                                    //         color: Color.fromARGB(
                                    //             255, 255, 255, 255),
                                    //         width: 3.0),
                                    //     borderRadius: BorderRadius.circular(12),
                                    //   ),
                                    //   child: Text(
                                    //     '${course!.courseNo.toString()}',
                                    //     textAlign: TextAlign.center,
                                    //     style: TextStyle(
                                    //       fontFamily: AppTheme.ruFontKanit,
                                    //       fontWeight: FontWeight.w600,
                                    //       fontSize: 14,
                                    //       color: AppTheme.nearlyWhite,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              )
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
                      top: 25,
                      left: 25,
                      child: SizedBox(
                        width: 30,
                        height: 30,
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
