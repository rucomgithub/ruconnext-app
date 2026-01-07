import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/manual/manual_list_view.dart';
import 'package:th.ac.ru.uSmart/ruconnext_app_theme.dart';
import 'package:th.ac.ru.uSmart/widget/ru_wallpaper.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        leading: Container(),
        iconTheme: IconThemeData(
          color: AppTheme.nearlyWhite,
        ),
        title: Text(
          'แนะนำการใช้งาน',
          style: TextStyle(
            fontSize: baseFontSize,
            fontFamily: AppTheme.ruFontKanit,
            color: AppTheme.nearlyWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.ru_dark_blue,
      ),
      backgroundColor:
          isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return getListUI();
          }
        },
      ),
    );
  }

  Widget getListUI() {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    return Stack(
      children: <Widget>[
        RuWallpaper(),
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.ru_dark_blue,
                            AppTheme.ru_dark_blue.withValues(alpha: 0.85),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.ru_dark_blue.withValues(alpha: 0.3),
                            offset: const Offset(0, 8),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              Icons.menu_book_rounded,
                              color: AppTheme.nearlyWhite,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'คู่มือการใช้งาน',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppTheme.ruFontKanit,
                                    color: AppTheme.nearlyWhite,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'เลือกหัวข้อเพื่อดูคำแนะนำการใช้งาน',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: AppTheme.ruFontKanit,
                                    color: AppTheme.nearlyWhite.withValues(alpha: 0.85),
                                    height: 1.4,
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
            SliverPadding(
              padding: EdgeInsets.only(
                bottom: 16 + MediaQuery.of(context).padding.bottom,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final int count =
                        manualList.length > 10 ? 10 : manualList.length;
                    final Animation<double> animation =
                        Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animationController!,
                        curve: Interval((1 / count) * index, 1.0,
                            curve: Curves.fastOutSlowIn),
                      ),
                    );
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
                  childCount: manualList.length,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
