import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/models/grade_list_data.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/model/rotcs_extend.dart';
import 'package:th.ac.ru.uSmart/providers/rotcs_provider.dart';

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
        duration: const Duration(milliseconds: 1000), vsync: this);
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
    return loading
        ? Container(child: SizedBox())
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
                      child: Container(
                        height: extend.detail!.length > 0 ? 200 : 10,
                        width: double.infinity,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 0, right: 16, left: 16),
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
                            //return Text('data');
                            return ExtendItemView(
                              detail: extend.detail![index],
                              animation: animation,
                              animationController: animationController!,
                            );
                          },
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

class ExtendItemView extends StatelessWidget {
  const ExtendItemView(
      {Key? key, this.detail, this.animationController, this.animation})
      : super(key: key);

  final RotcsExtendDetail? detail;
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
                // ondemand.ondemand.rECORD.detail.isEmpty
                // print(ondemand.error);
              },
              child: SizedBox(
                width: 280,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: HexColor("#FF19196B").withOpacity(0.6),
                                offset: const Offset(1.1, 4.0),
                                blurRadius: 8.0),
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
                              top: 16, left: 32, right: 16, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'ปีการศึกษา ${detail!.registerSemester}/${detail!.registerYear}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 12,
                                  letterSpacing: 0.2,
                                  color: AppTheme.white,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: SingleChildScrollView(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'จำนวน ${detail!.credit} หน่วยกิต ',
                                            style: TextStyle(
                                              fontFamily: AppTheme.ruFontKanit,
                                              fontWeight: FontWeight.w200,
                                              fontSize: 12,
                                              letterSpacing: 0.2,
                                              color: AppTheme.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppTheme.nearlyWhite,
                                      shape: BoxShape.circle,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: AppTheme.nearlyBlack
                                                .withOpacity(0.4),
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 4.0),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Icon(Icons.save),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        '${detail!.created}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: 0.2,
                                          color: AppTheme.nearlyWhite,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppTheme.nearlyWhite.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 15,
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/fitness_app/AF1.png'),
                          radius: 50,
                        ),
                        //child: Text(gradeListData!.),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 60,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: 200,
                        child: Text(
                          '${detail!.description}',
                          style: TextStyle(
                            fontFamily: AppTheme.ruFontKanit,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppTheme.nearlyWhite,
                          ),
                        ),
                      ),
                    ),
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
