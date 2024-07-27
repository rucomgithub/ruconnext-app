import 'package:th.ac.ru.uSmart/app_theme.dart';
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
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
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
            child: prov.listGroupYearSemester.isEmpty
                ? Container(
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
                    child: Text('ไม่พบข้อมูลลงทะเบียน'))
                : Container(
                    height: screenHeight * 0.85,
                    width: double.infinity,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, right: 8, left: 8),
                      itemCount: prov.listGroupYearSemester.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        final int count = prov.listGroupYearSemester.length > 10
                            ? 10
                            : prov.listGroupYearSemester.length;
                        final Animation<double> animation =
                            Tween<double>(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                    parent: animationController!,
                                    curve: Interval((1 / count) * index, 1.0,
                                        curve: Curves.fastOutSlowIn)));
                        animationController?.forward();
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, right: 16, left: 8),
                                decoration: BoxDecoration(
                                  color: AppTheme.nearlyWhite,
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
                                height: screenHeight * 0.35,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Icon(
                                              Icons.book,
                                              size: baseFontSize + 18,
                                              color: AppTheme.ru_dark_blue,
                                            ),
                                            Positioned(
                                              top: 14,
                                              left: 20,
                                              child: Text(
                                                '${prov.listGroupYearSemester.entries.elementAt(index).value.length}',
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                  color: AppTheme.ru_yellow,
                                                  fontSize: baseFontSize - 6,
                                                ),
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
                                              '${prov.listGroupYearSemester.entries.elementAt(index).key}',
                                              style: TextStyle(
                                                fontFamily:
                                                    AppTheme.ruFontKanit,
                                                fontSize: baseFontSize,
                                                letterSpacing: 0.2,
                                                color: AppTheme.ru_dark_blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Container(
                                        width: screenWidth * 0.9,
                                        height: 2,
                                        decoration: BoxDecoration(
                                          color: AppTheme.ru_yellow,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0.0),
                                            bottomLeft: Radius.circular(0.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    ListRegisterListValueView(
                                      listData: prov
                                          .listGroupYearSemester.entries
                                          .elementAt(index)
                                          .value,
                                      animation: animation,
                                      animationController: animationController!,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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

class ListRegisterListValueView extends StatelessWidget {
  const ListRegisterListValueView(
      {Key? key, this.listData, this.animationController, this.animation})
      : super(key: key);
  final List<REGISTERECORDVIEW>? listData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;
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
              height: screenHeight * 0.25,
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;
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
              onTap: () {},
              child: SizedBox(
                width: screenWidth * 0.4,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/ID.png'),
                            fit: BoxFit.cover,
                            opacity: 0.08,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.ru_dark_blue.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(4, 4),
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: <HexColor>[
                              HexColor("#FF19196B"),
                              HexColor("#FF1919EB"),
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
                              top: 8, left: 16, right: 16, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                course!.year!.toString(),
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontSize: baseFontSize - 4,
                                  color: AppTheme.white,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 16, bottom: 8),
                                  child: SingleChildScrollView(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          course!.courseNo!.toString(),
                                          style: TextStyle(
                                            fontFamily: AppTheme.ruFontKanit,
                                            fontSize: baseFontSize + 2,
                                            letterSpacing: 0.2,
                                            color: AppTheme.ru_yellow,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    course!.credit.toString(),
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: baseFontSize,
                                      color: AppTheme.ru_yellow,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Text(
                                      'หน่วยกิต',
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: baseFontSize - 6,
                                        color: AppTheme.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 10,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppTheme.nearlyWhite,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 25,
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: Text(
                          course!.semester!.toString(),
                          style: TextStyle(
                            fontFamily: AppTheme.ruFontKanit,
                            fontSize: baseFontSize - 4,
                            color: AppTheme.ru_dark_blue,
                          ),
                        ),
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
