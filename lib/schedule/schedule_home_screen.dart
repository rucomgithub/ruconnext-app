import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/navigation_home_screen.dart';
import 'package:th.ac.ru.uSmart/pages/aboutRam_screen.dart';
import 'package:th.ac.ru.uSmart/providers/schedule_provider.dart';
import 'package:th.ac.ru.uSmart/schedule/schedule_list_view.dart';
import 'package:th.ac.ru.uSmart/screens/runewsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/widget/ru_wallpaper.dart';

class ScheduleHomeScreen extends StatefulWidget {
  @override
  _ScheduleHomeScreenState createState() => _ScheduleHomeScreenState();
}

class _ScheduleHomeScreenState extends State<ScheduleHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  int _selectedMenu =
      2; // Tracks selected bottom bar item/ Tracks selected bottom bar item

  void _onItemTapped(int index) {
    setState(() {
      _selectedMenu = index;
    });
    if (index == 0) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
    } else if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => aboutRam()));
    } else if (index == 2) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ScheduleHomeScreen()));
    } else if (index == 3) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RunewsScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;
    bool isLightMode = brightness == Brightness.light;
    var scheduleProv = context.watch<ScheduleProvider>();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppTheme.nearlyWhite, // Change back arrow color to white
        ),
        title: Text(
          'ปฏิทินการศึกษา',
          style: TextStyle(
            fontSize: baseFontSize - 2,
            fontFamily: AppTheme.ruFontKanit,
            color: AppTheme.nearlyWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Centers the title
        backgroundColor:
            AppTheme.ru_dark_blue, // Background color of the AppBar
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.help,
              color: AppTheme.nearlyWhite,
            ),
            onPressed: () {
              Get.toNamed("/schedulehelp");
            },
          ),
        ],
      ),
      backgroundColor:
          isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
      body: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                offset: const Offset(0, -2),
                blurRadius: 8.0),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  RuWallpaper(),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Column(
                      children: <Widget>[
                        //getAppBarUI(),
                        Expanded(
                          child: NestedScrollView(
                            controller: _scrollController,
                            headerSliverBuilder: (BuildContext context,
                                bool innerBoxIsScrolled) {
                              return <Widget>[
                                // SliverList(
                                //   delegate: SliverChildBuilderDelegate(
                                //       (BuildContext context, int index) {
                                //     return Column(
                                //       children: <Widget>[
                                //         getSearchBarUI(),
                                //         //getTimeDateUI(),
                                //       ],
                                //     );
                                //   }, childCount: 1),
                                // ),
                                SliverPersistentHeader(
                                  pinned: true,
                                  floating: true,
                                  delegate: ContestTabHeader(
                                    getFilterBarUI(scheduleProv),
                                  ),
                                ),
                              ];
                            },
                            body: Container(
                              child: ListView.builder(
                                itemCount: scheduleProv.schedules.length,
                                padding: const EdgeInsets.only(top: 8),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  final int count =
                                      scheduleProv.schedules.length > 10
                                          ? 10
                                          : scheduleProv.schedules.length;
                                  final Animation<double> animation =
                                      Tween<double>(begin: 0.0, end: 1.0)
                                          .animate(CurvedAnimation(
                                              parent: animationController!,
                                              curve: Interval(
                                                  (1 / count) * index, 1.0,
                                                  curve:
                                                      Curves.fastOutSlowIn)));
                                  animationController?.forward();
                                  return ScheduleListView(
                                    record: scheduleProv.schedules[index],
                                    callback: () {},
                                    //hotelData: hotelList[index],
                                    index: index,
                                    animation: animation,
                                    animationController: animationController!,
                                  );
                                  // return Container(child: Text('data'));
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: AppTheme.ru_yellow,
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: GNav(
              gap: 8, // Gap between tabs (optional)
              backgroundColor: AppTheme.white, // Adjust color as needed
              activeColor:
                  AppTheme.ru_dark_blue, // Adjust active color as needed
              color: AppTheme.ru_dark_blue
                  .withAlpha(200), // Adjust unselected color as needed
              iconSize: 24, // Icon size (optional)
              padding: EdgeInsets.symmetric(
                  horizontal: 15, vertical: 8), // Padding (optional)
              tabActiveBorder: Border.all(
                  color: AppTheme.ru_dark_blue,
                  width: 1), // Tab border (optional)
              curve: Curves.easeOutExpo, // tab animation curves
              duration: Duration(milliseconds: 600),
              tabs: [
                GButton(
                    icon: Icons.home,
                    text: 'หน้าแรก',
                    textStyle: TextStyle(
                        fontSize: baseFontSize - 4,
                        fontFamily: AppTheme.ruFontKanit,
                        color: AppTheme.ru_dark_blue)),
                GButton(
                    icon: Icons.person,
                    text: 'เกี่ยวกับราม',
                    textStyle: TextStyle(
                        fontSize: baseFontSize - 4,
                        fontFamily: AppTheme.ruFontKanit,
                        color: AppTheme.ru_dark_blue)),
                GButton(
                    icon: Icons.calendar_today,
                    text: 'ปฏิทินการศึกษา',
                    textStyle: TextStyle(
                        fontSize: baseFontSize - 4,
                        fontFamily: AppTheme.ruFontKanit,
                        color: AppTheme.ru_dark_blue)),
                GButton(
                    icon: Icons.newspaper,
                    text: 'ประชาสัมพันธ์',
                    textStyle: TextStyle(
                        fontSize: baseFontSize - 4,
                        fontFamily: AppTheme.ruFontKanit,
                        color: AppTheme.ru_dark_blue)),
              ],
              selectedIndex: _selectedMenu,
              onTabChange: (index) => _onItemTapped(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget getFilterBarUI(ScheduleProvider scheduleProv) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
            isLightMode
                ? AppTheme.ru_dark_blue.withValues(alpha: 0.02)
                : AppTheme.nearlyBlack,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: isLightMode
                ? Colors.grey.withValues(alpha: 0.15)
                : Colors.black.withValues(alpha: 0.3),
            offset: const Offset(0, 2),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.ru_dark_blue.withValues(alpha: 0.1),
                        AppTheme.ru_yellow.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.event_note_rounded,
                    color: AppTheme.ru_dark_blue,
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'ปฏิทินการศึกษา',
                  style: TextStyle(
                    fontFamily: AppTheme.ruFontKanit,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isLightMode
                        ? AppTheme.ru_dark_blue
                        : AppTheme.nearlyWhite,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.ru_dark_blue,
                    AppTheme.ru_dark_blue.withValues(alpha: 0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.ru_dark_blue.withValues(alpha: 0.3),
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.format_list_numbered_rounded,
                    color: AppTheme.ru_yellow,
                    size: 18,
                  ),
                  SizedBox(width: 6),
                  Text(
                    '${scheduleProv.schedules.length}',
                    style: TextStyle(
                      fontFamily: AppTheme.ruFontKanit,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.nearlyWhite,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'กิจกรรม',
                    style: TextStyle(
                      fontFamily: AppTheme.ruFontKanit,
                      fontSize: 14,
                      color: AppTheme.nearlyWhite.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
