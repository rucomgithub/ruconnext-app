import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:th.ac.ru.uSmart/model/ondemand.dart';
import 'package:th.ac.ru.uSmart/providers/ondemand_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';
import 'ondemand_list_view.dart';

class OndemandHomeScreen extends StatefulWidget {
  @override
  _OndemandHomeScreenState createState() => _OndemandHomeScreenState();
}

class _OndemandHomeScreenState extends State<OndemandHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  final ScrollController _scrollController = ScrollController();
  Ondemand article = Ondemand();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    try {
      // monitor network fetch
      await Future.delayed(const Duration(milliseconds: 700));
      // if failed,use refreshFailed()

      setState(() {
        article.rECORD!.detail!.clear();
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
    final Map<String, dynamic> args = Get.arguments;
    final String? course = args['course'];
    final String? semester = args['semester'];
    final String? year = args['year'];

    await Provider.of<OndemandProvider>(context, listen: false)
        .getOndemandList('$course', '$semester', '$year');
    setState(() {
      article = Provider.of<OndemandProvider>(context, listen: false).ondemand;
    });
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, dynamic> args = Get.arguments;
      final String? course = args['course'];
      final String? semester = args['semester'];
      final String? year = args['year'];
      Provider.of<OndemandProvider>(context, listen: false)
          .getOndemandList('$course', '$semester', '$year');
      getData();
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    final String? course = args['course'];
    final String? semester = args['semester'];
    final String? year = args['year'];
    var dataOndemand = context.watch<OndemandProvider>();
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppTheme.nearlyWhite,
        ),
        title: Text(
          'วิดีโอคำบรรยาย',
          style: AppTheme.headline,
        ),
        centerTitle: true,
        backgroundColor: AppTheme.ru_dark_blue,
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
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverPersistentHeader(
                        pinned: true,
                        floating: true,
                        delegate: ContestTabHeader(
                          getFilterBarUI(context),
                        ),
                      ),
                    ];
                  },
                  body: (dataOndemand.ondemand.rECORD?.detail == null ||
                          dataOndemand.ondemand.rECORD!.detail!.isEmpty)
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (dataOndemand.isLoading) ...[
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      AppTheme.ru_dark_blue),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "กำลังโหลดข้อมูล...",
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 16,
                                    color: isLightMode
                                        ? AppTheme.ru_dark_blue
                                        : AppTheme.nearlyWhite,
                                  ),
                                ),
                              ] else ...[
                                Icon(
                                  Icons.video_library_outlined,
                                  size: 80,
                                  color: isLightMode
                                      ? AppTheme.ru_dark_blue.withValues(alpha: 0.3)
                                      : AppTheme.nearlyWhite.withValues(alpha: 0.3),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "ไม่พบรายการวิดีโอคำบรรยาย",
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: isLightMode
                                        ? AppTheme.ru_dark_blue
                                        : AppTheme.nearlyWhite,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "ไม่มีวิดีโอคำบรรยายสำหรับรายวิชานี้",
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 14,
                                    color: isLightMode
                                        ? AppTheme.ru_dark_blue.withValues(alpha: 0.6)
                                        : AppTheme.nearlyWhite.withValues(alpha: 0.6),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        )
                      : SmartRefresher(
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
                            itemCount: dataOndemand.countOndemand,
                            padding: const EdgeInsets.only(top: 8),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              final int count = dataOndemand.countOndemand > 10
                                  ? 10
                                  : dataOndemand.countOndemand;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                          parent: animationController!,
                                          curve: Interval(
                                              (1 / count) * index, 1.0,
                                              curve: Curves.fastOutSlowIn)));

                              if (index == 0 &&
                                  animationController?.status ==
                                      AnimationStatus.dismissed) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  animationController?.forward();
                                });
                              }

                              return OndemandListView(
                                record: dataOndemand
                                    .ondemand.rECORD!.detail![index],
                                callback: () {
                                  Get.toNamed('/runewsdetail', arguments: {
                                    'url':
                                        'https://appsapis.ru.ac.th/Streaming/vedioPlayer/?id=${dataOndemand.ondemand.rECORD!.detail![index].audioId}',
                                    'title':
                                        '${dataOndemand.ondemand.rECORD!.detail![index].subjectId}ครั้งที่${dataOndemand.ondemand.rECORD!.detail![index].audioSec}(${dataOndemand.ondemand.rECORD!.detail![index].sem}/${dataOndemand.ondemand.rECORD!.detail![index].year})',
                                  });
                                },
                                index: index,
                                animation: animation,
                                animationController: animationController!,
                              );
                            },
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getFilterBarUI(BuildContext context) {
    var dataOndemand = context.watch<OndemandProvider>();
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    // Safe null checks
    final hasData = dataOndemand.ondemand.rECORD?.subjectCode != null &&
        dataOndemand.ondemand.rECORD!.subjectCode != "";
    final videoCount = dataOndemand.countOndemand;

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
                    Icons.video_library_rounded,
                    color: AppTheme.ru_dark_blue,
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  hasData ? 'วิดีโอคำบรรยาย' : 'กำลังโหลด...',
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
            if (hasData && videoCount > 0)
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
                      '$videoCount',
                      style: TextStyle(
                        fontFamily: AppTheme.ruFontKanit,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.nearlyWhite,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'ครั้ง',
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
