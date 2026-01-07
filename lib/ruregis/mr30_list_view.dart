import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/model/mr30_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregion_mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_mr30_provider.dart';

import '../fitness_app/fitness_app_theme.dart';
import '../providers/mr30_provider.dart';

class Mr30ListView extends StatefulWidget {
  const Mr30ListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _Mr30ListViewState createState() => _Mr30ListViewState();
}

class _Mr30ListViewState extends State<Mr30ListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<String> areaListData = <String>[
    'assets/fitness_app/area1.png',
    'assets/fitness_app/area2.png',
    'assets/fitness_app/area3.png',
    'assets/fitness_app/area1.png',
  ];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    // monitor network fetch
    // if failed,use refreshFailed()
    getData();
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  void _onLoading() async {
    // monitor network fetch
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    getData();
    _refreshController.loadComplete();
  }

  Future<bool> getData() async {
    Provider.of<MR30Provider>(context, listen: false).getAllMR30Year();
    Provider.of<MR30Provider>(context, listen: false).getAllMR30Year();
    //Provider.of<RuregionProvider>(context, listen: false).fetchMR30RUREGION();
    await Future<dynamic>.delayed(const Duration(milliseconds: 600));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var mr30 = context.watch<MR30Provider>();
    var mr30ruregion = context.watch<RuregionProvider>();
    if (mr30.isLoading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
        ],
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
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    header: const WaterDropHeader(),
                    footer: CustomFooter(
                      builder: (BuildContext context, LoadStatus? mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = const Text("กำลังโหลดข้อมูล...");
                        } else if (mode == LoadStatus.loading) {
                          body = const CircularProgressIndicator();
                        } else if (mode == LoadStatus.failed) {
                          body = const Text(
                              "ไม่สามารถโหลดข้อมูลได้ กรุณาลองอีกครั้ง");
                        } else if (mode == LoadStatus.canLoading) {
                          body = const Text("release to load more");
                        } else {
                          body = const Text("ไม่พบข้อมูลแล้ว...");
                        }
                        return SizedBox(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: ListView(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 16),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: List<Widget>.generate(
                        mr30.mr30filter.rECORD!.length > 20 ? 20: mr30.mr30filter.rECORD!.length,
                        (int index) {
                          final int count = mr30.mr30filter.rECORD!.length > 20 ? 20: mr30.mr30filter.rECORD!.length;
                          final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn),
                            ),
                          );
                          animationController?.forward();
                          //return Text('asdfasdfasdf');
                          return Mr30ItemView(
                            index: index,
                            course: mr30.mr30filter.rECORD?.elementAt(index),
                            animation: animation,
                            animationController: animationController!,
                          );
                        },
                      ),
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
}

Icon IconFavorite(bool favorite) {
  return favorite
      ? Icon(
          Icons.star,
          color: Color.fromARGB(255, 255, 208, 0),
          size: 25,
        )
      : Icon(
          Icons.star_border_outlined,
          color: Color.fromARGB(255, 19, 19, 19),
          size: 25,
        );
}

class Mr30ItemView extends StatelessWidget {
  const Mr30ItemView({
    Key? key,
    this.index,
    this.course,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final int? index;
  final RECORD? course;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    var mr30prov = Provider.of<RUREGISMR30Provider>(context, listen: false);
     var mr30ruregionprov = Provider.of<RuregionProvider>(context, listen: false);
    List<String> parts = this.course.toString().split(',');
    EdgeInsets listItemPadding =
        EdgeInsets.only(left: 0, bottom: 4, top: 4, right: 40);
    Color favColor = AppTheme.ru_text_ocean_blue;
    if (course!.favorite!) {
      listItemPadding = EdgeInsets.only(left: 40, bottom: 4, top: 4, right: 0);
      favColor = AppTheme.ru_text_light_blue;
    }
    Color dayColor = Color.fromARGB(255, 43, 43, 43);
    if(course?.dayNameS == 'M'){
      dayColor = Color.fromARGB(255, 206, 196, 6);
    } if(course?.dayNameS == 'TU'){
      dayColor = Color.fromARGB(255, 224, 47, 236);
    } if(course?.dayNameS == 'W'){
      dayColor = Color.fromARGB(255, 5, 113, 2);
    } if(course?.dayNameS == 'TH'){
      dayColor = Color.fromARGB(255, 224, 142, 11);
    } if(course?.dayNameS == 'F'){
      dayColor = Color.fromARGB(255, 84, 178, 241);
    } if(course?.dayNameS == 'SAT'){
      dayColor = Color.fromARGB(255, 121, 11, 224);
    } if(course?.dayNameS == 'SU'){
      dayColor = Color.fromARGB(255, 242, 40, 40);
    } 
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: listItemPadding,
          child: FadeTransition(
            opacity: animation!,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 50 * (1.0 - animation!.value), 0.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: FitnessAppTheme.nearlyWhite.withValues(alpha: 0.9),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topRight: Radius.circular(8.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: FitnessAppTheme.grey.withValues(alpha: 0.4),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        splashColor: AppTheme.dark_grey.withValues(alpha: 0.2),
                        onTap: () {
                          mr30prov.addRuregisMR30(course!);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 8),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 244, 237, 237).withValues(alpha: 0.9),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: FitnessAppTheme.grey
                                                .withValues(alpha: 0.4),
                                            offset: const Offset(1.1, 1.1),
                                            blurRadius: 10.0),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: IconFavorite(course!.favorite!),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${course?.courseNo}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: 20,
                                        color: favColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Row(
                                children: [
                                  Text(
                                    '${course?.dayNameS}  ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: 16,
                                      color: dayColor,
                                    ),
                                  ), Text(
                                    '${course?.timePeriod} ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: 16,
                                      color: AppTheme.ru_text_grey,
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
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: FitnessAppTheme.nearlyWhite.withValues(alpha: 0.9),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topRight: Radius.circular(0.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: FitnessAppTheme.grey.withValues(alpha: 0.4),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        splashColor:
                            FitnessAppTheme.nearlyDarkBlue.withValues(alpha: 0.2),
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 227, 227, 227).withValues(alpha: 0.9),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    bottomLeft: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color:
                                          FitnessAppTheme.grey.withValues(alpha: 0.4),
                                    ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  '${course?.courseSemester}/${course?.courseYear}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 12,
                                    color: favColor,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 227, 227, 227).withValues(alpha: 0.9),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    bottomLeft: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color:
                                          FitnessAppTheme.grey.withValues(alpha: 0.4),
                              ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  '${course?.courseExamdate}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 12,
                                    color: favColor,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              '${course?.courseCredit} หน่วยกิต',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontSize: 12,
                                color: AppTheme.ru_text_grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
