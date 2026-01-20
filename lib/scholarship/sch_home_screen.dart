import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:th.ac.ru.uSmart/model/scholarship.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/sch_provider.dart';
import 'package:th.ac.ru.uSmart/scholarship/sch_list_view.dart';
import 'package:th.ac.ru.uSmart/store/authen.dart';
import '../app_theme.dart';
import '../providers/authenprovider.dart';

class SchHomeScreen extends StatefulWidget {
  @override
  _SchHomeScreenState createState() => _SchHomeScreenState();
}

class _SchHomeScreenState extends State<SchHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  final ScrollController _scrollController = ScrollController();
  String? accessToken;
  Scholarship scholarship = Scholarship();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    try {
      // monitor network fetch
      await Future.delayed(const Duration(milliseconds: 700));
      // if failed,use refreshFailed()

      setState(() {
        scholarship.rECORD!.clear();
      });
      getData();
      // print('onRefresh ${article.rECORD!.subjectCode}');
      _refreshController.refreshCompleted(resetFooterState: true);
    } catch (error) {
      // Handle the error and call refreshFailed to stop the loading animation with error message
      _refreshController.refreshCompleted(resetFooterState: true);
    }
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 500));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    getData();
    _refreshController.loadComplete();
  }

  Future<void> getData() async {
    accessToken = await AuthenStorage.getAccessToken();
    await Provider.of<SchProvider>(context, listen: false).getScholarShip();
    setState(() {
      scholarship =
          Provider.of<SchProvider>(context, listen: false).scholarshipData;
    });
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    super.initState();
    Provider.of<SchProvider>(context, listen: false).getScholarShip();
    getData();
  }

  Future<bool> getData2() async {
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
    var dataSch = context.watch<SchProvider>();
    var authen = context.watch<AuthenProvider>();
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    // print(
    //     '*******************Value: ${dataSch.scholarshipData.rECORD!.length}');
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppTheme.nearlyWhite, // Change back arrow color to white
        ),
        title: Text(
          'ประวัติการรับทุนการศึกษา',
          style: AppTheme.headline,
        ),
        centerTitle: true, // Centers the title
        backgroundColor:
            AppTheme.ru_dark_blue, // Background color of the AppBar
      ),
      backgroundColor:
          isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
      body: Builder(
        builder: (context) {
          if (accessToken == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.offNamed('/login');
            });
            return const SizedBox();
          }
          return Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
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
                            getListUI()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getListUI() {
    var sch = context.watch<SchProvider>();
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    // Show loading state
    if (sch.isLoading) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.ru_dark_blue),
              ),
              SizedBox(height: 16),
              Text(
                "กำลังโหลดข้อมูล...",
                style: TextStyle(
                  fontFamily: AppTheme.ruFontKanit,
                  fontSize: 16,
                  color: isLightMode ? AppTheme.ru_dark_blue : AppTheme.nearlyWhite,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Show empty state
    if (sch.scholarshipData.rECORD == null || sch.scholarshipData.rECORD!.isEmpty) {
      return Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.ru_yellow.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.school_outlined,
                    size: 80,
                    color: AppTheme.ru_dark_blue.withValues(alpha: 0.5),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "ไม่พบข้อมูลทุนการศึกษา",
                  style: TextStyle(
                    fontFamily: AppTheme.ruFontKanit,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: isLightMode ? AppTheme.ru_dark_blue : AppTheme.nearlyWhite,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "ยังไม่มีประวัติการรับทุนการศึกษา\nของคุณในระบบ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTheme.ruFontKanit,
                    fontSize: 16,
                    height: 1.5,
                    color: isLightMode
                        ? AppTheme.ru_dark_blue.withValues(alpha: 0.6)
                        : AppTheme.nearlyWhite.withValues(alpha: 0.7),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {});
                    Provider.of<SchProvider>(context, listen: false).getScholarShip();
                  },
                  icon: Icon(Icons.refresh_rounded, color: AppTheme.nearlyWhite),
                  label: Text(
                    'รีเฟรช',
                    style: TextStyle(
                      fontFamily: AppTheme.ruFontKanit,
                      fontSize: 16,
                      color: AppTheme.nearlyWhite,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.ru_dark_blue,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Expanded(
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: ContestTabHeader(
                      getFilterBarUI(sch),
                    ),
                  ),
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
                      body =
                          const Text("ไม่สามารถโหลดข้อมูลได้ กรุณาลองอีกครั้ง");
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
                  itemCount: sch.scholarshipData.rECORD!.length,
                  padding: const EdgeInsets.only(top: 8),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    final int count = sch.scholarshipData.rECORD!.length > 10
                        ? 10
                        : sch.scholarshipData.rECORD!.length;
                    final Animation<double> animation =
                        Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: animationController!,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn)));
                    animationController?.forward();
                    //return Text('data');
                    // print(index);
                    return SchListView(
                      record: sch.scholarshipData.rECORD![index],
                      animation: animation,
                      animationController: animationController!,
                    );
                  },
                ),
              ),
            ),
          );
  }

  Widget getFilterBarUI(SchProvider sch) {
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
                    Icons.workspace_premium_rounded,
                    color: AppTheme.ru_dark_blue,
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'ทุนการศึกษาทั้งหมด',
                  style: TextStyle(
                    fontFamily: AppTheme.ruFontKanit,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isLightMode ? AppTheme.ru_dark_blue : AppTheme.nearlyWhite,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.ru_dark_blue,
                    AppTheme.ru_dark_blue.withValues(alpha: 0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
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
                    '${sch.scholarshipData.rECORD!.length}',
                    style: TextStyle(
                      fontFamily: AppTheme.ruFontKanit,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.nearlyWhite,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'รายการ',
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
