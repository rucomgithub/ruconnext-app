import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/manual/manual_list_view.dart';
import 'package:th.ac.ru.uSmart/model/other_list_data.dart';
import 'package:th.ac.ru.uSmart/other/other_list_view.dart';
import 'package:th.ac.ru.uSmart/ruconnext_app_theme.dart';
import 'package:th.ac.ru.uSmart/widget/ru_wallpaper.dart';
import 'package:th.ac.ru.uSmart/widget/top_bar.dart';
import 'package:th.ac.ru.uSmart/widget/top_menu_bar.dart';

import '../model/manual_list_data.dart';

class ManualHomeScreen extends StatefulWidget {
  @override
  _ManualHomeScreenState createState() => _ManualHomeScreenState();
}

class _ManualHomeScreenState extends State<ManualHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<ManualListData> manualList = ManualListData.manualList;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    super.initState();
    getData();
    //Noti.initialize(flutterLocalNotificationsPlugin);
  }

  Future<bool> getData() async {
    print('call getData');
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
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppTheme.nearlyWhite, // Change back arrow color to white
        ),
        title: Text(
          'แนะนำการใช้งาน',
          style: TextStyle(
            fontSize: 22,
            fontFamily: AppTheme.ruFontKanit,
            color: AppTheme.nearlyWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Centers the title
        backgroundColor:
            AppTheme.ru_dark_blue, // Background color of the AppBar
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(
        //       Icons.help,
        //       color: AppTheme.nearlyWhite,
        //     ),
        //     onPressed: () {
        //       Get.toNamed("/manual");
        //     },
        //   ),
        // ],
      ),
      backgroundColor:
          isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            //print('register : ${authen.profile.accessToken}');
            return Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0, -2),
                      blurRadius: 8.0),
                ],
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: getListUI(),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget getListUI() {
    return Container(
      height: MediaQuery.of(context).size.height - 120,
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Stack(
              children: <Widget>[
                RuWallpaper(),
                ListView.builder(
                  itemCount: manualList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    final int count =
                        manualList.length > 10 ? 10 : manualList.length;
                    final Animation<double> animation =
                        Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: animationController!,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn)));
                    animationController?.forward();

                    return ManualListView(
                      callback: () {
                        Get.toNamed(manualList[index].navigateScreen);
                      },
                      manualData: manualList[index],
                      animation: animation,
                      animationController: animationController!,
                    );
                  },
                )
              ],
            );
          }
        },
      ),
    );
  }

  // Widget getBg() {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       image: DecorationImage(
  //         image: AssetImage('assets/images/bg.png'),
  //         fit: BoxFit.cover,
  //       ),
  //     ),
  //   );
  // }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: RuConnextAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  // child: Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Icon(Icons.arrow_back),
                  // ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'แนะนำการใช้งาน',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 20,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // Material(
                  //   color: Colors.transparent,
                  //   child: InkWell(
                  //     borderRadius: const BorderRadius.all(
                  //       Radius.circular(32.0),
                  //     ),
                  //     onTap: () {},
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Icon(Icons.favorite_border),
                  //     ),
                  //   ),
                  // ),
                  // Material(
                  //   color: Colors.transparent,
                  //   child: InkWell(
                  //     borderRadius: const BorderRadius.all(
                  //       Radius.circular(32.0),
                  //     ),
                  //     onTap: () {},
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Icon(FontAwesomeIcons.bookOpenReader),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
