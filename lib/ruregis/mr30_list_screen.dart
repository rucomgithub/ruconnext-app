import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/ui_view/glass_view.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/mr30/favorite_list_view.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/ruregis/mr30_view.dart';
import 'package:th.ac.ru.uSmart/widget/Rubar.dart';
import 'package:badges/badges.dart' as badges;

import '../providers/grade_provider.dart';
import '../fitness_app/ui_view/running_view.dart';
import '../providers/mr30_provider.dart';
import 'mr30_list_view.dart';
import 'titlenone_view.dart';

class Mr30ListScreen extends StatefulWidget {
  const Mr30ListScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;
  @override
  _Mr30ListScreenState createState() => _Mr30ListScreenState();
}

class _Mr30ListScreenState extends State<Mr30ListScreen>
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
  }

  void addAllListData() {
    const int count = 9;
    //var mr30 = context.watch<MR30Provider>().mr30record;


    listViews.add(
      FavoriteListView(
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
        titleTxt:'สืบค้นรายการ มร.30' ,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

// มร 30
    listViews.add(
      Mr30RuregisView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      Mr30ListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: Interval((1 / count) * 5, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController!,
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
      color: AppTheme.background,
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
              bottom: 1 + MediaQuery.of(context).padding.bottom,
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
    //   var mr30 = context.watch<MR30Provider>().mr30record;

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
                          color: AppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
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
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                               IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Rubar(textTitle: 'ค้นหาวิชามร.30'),
                              ),
                            ),
                          //   Expanded(
                          //     child: Padding(
                          //   padding: const EdgeInsets.only(left: 0.0),
                          //   child: badges.Badge(
                          //     badgeContent: Text('${mr30.length}'),
                          //     position:
                          //         badges.BadgePosition.topEnd(top: 0, end: 285),
                          //     child: IconButton(
                          //       icon: Icon(
                          //         Icons.shopping_cart,
                          //         size: 35,
                          //         color: Color.fromARGB(255, 11, 11, 11),
                          //       ),
                          //       onPressed: () {
                          //         Get.toNamed('/homehelp');
                          //       },
                          //     ),
                          //   ),
                          // ),
                          //   ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
