import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/home_screen.dart';
import 'package:th.ac.ru.uSmart/navigation_home_screen.dart';
import 'package:th.ac.ru.uSmart/pages/profile_home_screen.dart';
import 'package:th.ac.ru.uSmart/today/today_home_screen.dart';
import 'package:th.ac.ru.uSmart/widget/ru_wallpaper.dart';
import 'package:th.ac.ru.uSmart/widget/top_bar.dart';

import '../hotel_booking/hotel_app_theme.dart';

import 'package:th.ac.ru.uSmart/model/runews.dart';
import 'package:th.ac.ru.uSmart/providers/runewsprovider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class RunewsScreen extends StatefulWidget {
  const RunewsScreen({Key? key}) : super(key: key);

  @override
  State<RunewsScreen> createState() => _RunewsScreenState();
}

class _RunewsScreenState extends State<RunewsScreen> {
  List<runews> article = [];
  AnimationController? animationController;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController _scrollController = ScrollController();
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 700));
    // if failed,use refreshFailed()
    setState(() {
      article.clear();
    });
    getData();
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 500));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    getData();
    _refreshController.loadComplete();
  }

  Future<void> getData() async {
    await Provider.of<RunewsProvider>(context, listen: false).getAllRunews();
    setState(() {
      article =
          Provider.of<RunewsProvider>(context, listen: false).runewsRecord;
    });
  }

  int _selectedIndex = 3; // Tracks selected bottom bar item

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
    } else if (index == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ProfileHomeScreen()));
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TodayHomeScreen()));
    } else if (index == 3) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RunewsScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
          'กิจกรรมประชาสัมพันธ์',
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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.help,
              color: AppTheme.nearlyWhite,
            ),
            onPressed: () {
              Get.toNamed("/newshelp");
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
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(0, -2),
                blurRadius: 8.0),
          ],
        ),
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
                  Expanded(
                    child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
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
                          // SliverPersistentHeader(
                          //   pinned: true,
                          //   floating: true,
                          //   delegate: ContestTabHeader(
                          //     getFilterBarUI(scheduleProv),
                          //   ),
                          // ),
                        ];
                      },
                      body: SmartRefresher(
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
                        child: ListView.builder(
                          itemCount: article.length,
                          itemBuilder: (context, index) {
                            final runew = article[index];
                            return Container(
                              decoration: BoxDecoration(
                                // borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    offset: const Offset(4, 4),
                                    blurRadius: 30,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                // borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                child: Card(
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed('/runewsdetail', arguments: {
                                        'url':
                                            'https://www.ru.ac.th/RuNews/NewsRu/viewApp/${runew.id}',
                                        'title': runew.title,
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    'https://www.ru.ac.th/RuNews/images/News/${runew.photoHeader}',
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                              Text(
                                                '${runew.title}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromARGB(
                                                      255, 41, 46, 93),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.person_pin_circle,
                                                    color: Color.fromARGB(
                                                        255, 41, 46, 93),
                                                    size: 12,
                                                    semanticLabel:
                                                        'Text to announce in accessibility modes',
                                                  ),
                                                  Expanded(
                                                    flex: 10,
                                                    child: Text(
                                                      'Author: ${runew.author}',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Color.fromARGB(
                                                            255, 41, 46, 93),
                                                      ),
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.local_library,
                                                    color: Color.fromARGB(
                                                        255, 41, 46, 93),
                                                    size: 12,
                                                    semanticLabel:
                                                        'Text to announce in accessibility modes',
                                                  ),
                                                  showHit(runew, context),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
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
                        fontFamily: AppTheme.ruFontKanit,
                        color: AppTheme.ru_dark_blue)),
                GButton(
                    icon: Icons.person,
                    text: 'บัตรนักศึกษา',
                    textStyle: TextStyle(
                        fontFamily: AppTheme.ruFontKanit,
                        color: AppTheme.ru_dark_blue)),
                GButton(
                    icon: Icons.calendar_today,
                    text: 'ตารางเรียนวันนี้',
                    textStyle: TextStyle(
                        fontFamily: AppTheme.ruFontKanit,
                        color: AppTheme.ru_dark_blue)),
                GButton(
                    icon: Icons.newspaper,
                    text: 'ประชาสัมพันธ์',
                    textStyle: TextStyle(
                        fontFamily: AppTheme.ruFontKanit,
                        color: AppTheme.ru_dark_blue)),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) => _onItemTapped(index),
            ),
          ),
        ),
      ),
    );
  }

  Expanded showHit(runews runew, BuildContext context) {
    List<runews> listNew = context.watch<RunewsProvider>().runewsRecord;
    final runews singlenews =
        listNew.singleWhere((runews element) => element.id == runew.id);

    return Expanded(
        flex: 6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${singlenews.hit}',
                style: const TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 41, 46, 93)))
          ],
        ));
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().backgroundColor,
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
              width: AppBar().preferredSize.height,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                'กิจกรรมประชาสัมพันธ์',
                style: TextStyle(
                  fontFamily: AppTheme.ruFontKanit,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
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
                  //       child: Icon(FontAwesomeIcons.locationDot),
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
