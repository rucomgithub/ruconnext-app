import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/master/models/master_grade_list_data.dart';
import 'package:th.ac.ru.uSmart/master/models/master_register.dart';
import 'package:th.ac.ru.uSmart/master/providers/master_register_provider.dart';
import 'package:th.ac.ru.uSmart/widget/card/card_book_title.dart';

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
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: prov.listGroupYearSemester.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, right: 16, left: 16),
                    child: Container(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, right: 0, left: 0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 240, 232, 232),
                          borderRadius: BorderRadius.only(
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
                        child: Text('ไม่พบข้อมูลลงทะเบียน')),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, right: 16, left: 16),
                    child: Container(
                      height: (prov.listGroupYearSemester.length * 300) + 8,
                      width: double.infinity,
                      child: ListView.builder(
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, right: 16, left: 8),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/ID.png'),
                                    fit: BoxFit.cover,
                                    opacity: 0.2,
                                  ),
                                  color: isLightMode
                                      ? AppTheme.nearlyWhite
                                      : AppTheme.ru_grey,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      bottomLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0),
                                      topRight: Radius.circular(48.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          AppTheme.ru_yellow.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(4, 4),
                                    ),
                                  ],
                                ),
                                height: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Icon(
                                              Icons.book,
                                              size: 38,
                                              color: AppTheme.ru_dark_blue,
                                            ),
                                            Positioned(
                                              top: 14,
                                              left: 20,
                                              child: Text(
                                                '${prov.listGroupYearSemester.entries.elementAt(index).value.length}',
                                                style: AppTheme.subtitle,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${prov.listGroupYearSemester.entries.elementAt(index).key}  ',
                                              style: AppTheme.header,
                                            ),
                                          ],
                                        ),
                                      ],
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/ID.png'),
                  fit: BoxFit.cover,
                  opacity: 0.2,
                ),
              ),
              height: 240.0,
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, bottom: 8.0, right: 8.0),
                        child: CardBookTitle(
                          iconheader: Icons.book,
                          iconfooter: Icons.grade,
                          header: '${listData!.elementAt(index).courseNo}',
                          footer:
                              '${listData!.elementAt(index).credit.toString()} หน่วยกิต',
                          title: '${listData!.elementAt(index).courseNo}',
                          //content: listData!.elementAt(index).stdCode,
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
        );
      },
    );
  }
}
