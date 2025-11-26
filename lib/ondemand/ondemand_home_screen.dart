import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/calendar_popup_view.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/hotel_list_view.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/model/hotel_list_data.dart';
import 'package:th.ac.ru.uSmart/model/ondemand.dart';
import 'package:th.ac.ru.uSmart/providers/ondemand_provider.dart';
import 'package:th.ac.ru.uSmart/providers/schedule_provider.dart';
import 'package:th.ac.ru.uSmart/schedule/schedule_list_view.dart';
import 'package:th.ac.ru.uSmart/today/today_list_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';
import '../hotel_booking/filters_screen.dart';
import '../hotel_booking/hotel_app_theme.dart';
import '../login_page.dart';
import '../providers/authenprovider.dart';
import 'ondemand_list_view.dart';

class OndemandHomeScreen extends StatefulWidget {
  @override
  _OndemandHomeScreenState createState() => _OndemandHomeScreenState();
}

class _OndemandHomeScreenState extends State<OndemandHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<HotelListData> hotelList = HotelListData.hotelList;
  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
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
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    super.initState();
    final Map<String, dynamic> args = Get.arguments;
    final String? course = args['course'];
    final String? semester = args['semester'];
    final String? year = args['year'];
    Provider.of<OndemandProvider>(context, listen: false)
        .getOndemandList('$course', '$semester', '$year');
    // print('init ----${course.toString().trim()}xxx');
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
    final Map<String, dynamic> args = Get.arguments;
    final String? course = args['course'];
    final String? semester = args['semester'];
    final String? year = args['year'];
    var dataOndemand = context.watch<OndemandProvider>();
    var authen = context.watch<AuthenProvider>();
    // authen.profile.accessToken =
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NfdG9rZW5fa2V5IjoiNjI5OTk5OTk5MTo6YWNjZXNzOjo3YWIyYzVhNC0wNDViLTRiMjgtYTFhMy1iNmM2MTJlODhmNTIiLCJleHBpcmVzX3Rva2VuIjoxNjg4NzA2MDE5LCJpc3N1ZXIiOiJSdS1TbWFydCIsInJlZnJlc2hfdG9rZW5fa2V5IjoiNjI5OTk5OTk5MTo6cmVmcmVzaDo6MmFlNmEwMzMtOTVkYy00ZTQ3LTkxYzEtMmM0YjY0MmZkYjQ3Iiwicm9sZSI6IiIsInN1YmplY3QiOiJSdS1TbWFydDYyOTk5OTk5OTEifQ.IrdWhLxJUZMG1YwzOrr3KLToeZ8z4rrRiZzFbyqLL2A';
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          body: authen.profile.accessToken != null
              ? Stack(
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
                          getAppBarUI(course.toString(), semester.toString(),
                              year.toString()),
                          Expanded(
                            child: NestedScrollView(
                              controller: _scrollController,
                              headerSliverBuilder: (BuildContext context,
                                  bool innerBoxIsScrolled) {
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
                              body: SmartRefresher(
                                enablePullDown: true,
                                enablePullUp: false,
                                header: const WaterDropHeader(),
                                footer: CustomFooter(
                                  builder:
                                      (BuildContext context, LoadStatus? mode) {
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final int count =
                                        dataOndemand.countOndemand > 10
                                            ? 10
                                            : dataOndemand.countOndemand;
                                    final Animation<double> animation =
                                        Tween<double>(begin: 0.0, end: 1.0)
                                            .animate(CurvedAnimation(
                                                parent: animationController!,
                                                curve: Interval(
                                                    (1 / count) * index, 1.0,
                                                    curve:
                                                        Curves.fastOutSlowIn)));
                                    animationController?.forward();
                                    return OndemandListView(
                                      record: dataOndemand
                                          .ondemand.rECORD!.detail![index],
                                      callback: () {
                                        Get.toNamed('/runewsdetail',
                                            arguments: {
                                              'url':                                             
                                              'https://appsapis.ru.ac.th/Streaming/vedioPlayer/?id=${dataOndemand.ondemand.rECORD!.detail![index].audioId}',
                                              'title':
                                                  '${dataOndemand.ondemand.rECORD!.detail![index].subjectId}ครั้งที่${dataOndemand.ondemand.rECORD!.detail![index].audioSec}(${dataOndemand.ondemand.rECORD!.detail![index].sem}/${dataOndemand.ondemand.rECORD!.detail![index].year})',
                                            });
                                      },
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
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : LoginPage(),
        ),
      ),
    );
  }

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().scaffoldBackgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder<bool>(
              future: getData2(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: hotelList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          hotelList.length > 10 ? 10 : hotelList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController?.forward();

                      return HotelListView(
                        callback: () {},
                        hotelData: hotelList[index],
                        animation: animation,
                        animationController: animationController!,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getHotelViewList() {
    final List<Widget> hotelListViews = <Widget>[];
    for (int i = 0; i < hotelList.length; i++) {
      final int count = hotelList.length;
      final Animation<double> animation =
          Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController!,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      hotelListViews.add(
        HotelListView(
          callback: () {},
          hotelData: hotelList[i],
          animation: animation,
          animationController: animationController!,
        ),
      );
    }
    animationController?.forward();
    return Column(
      children: hotelListViews,
    );
  }

  Widget getTimeDateUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, bottom: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // setState(() {
                      //   isDatePopupOpen = true;
                      // });
                      showDemoDialog(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Choose date',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
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
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Number of Rooms',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '1 Room - 2 Adults',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
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
        ],
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HotelAppTheme.buildLightTheme().scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: HotelAppTheme.buildLightTheme().primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'London...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: HotelAppTheme.buildLightTheme().primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.magnifyingGlass,
                      size: 20,
                      color: HotelAppTheme.buildLightTheme().scaffoldBackgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('This is an alert message.'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget getFilterBarUI(BuildContext context) {
    var dataOndemand = context.watch<OndemandProvider>();
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: HotelAppTheme.buildLightTheme().scaffoldBackgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: HotelAppTheme.buildLightTheme().scaffoldBackgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: dataOndemand.ondemand.rECORD!.subjectCode != ""
                        ? Text(
                            'วิดีโอคำบรรยาย จำนวน ${dataOndemand.countOndemand} ครั้ง',
                            style: TextStyle(
                              fontFamily: AppTheme.ruFontKanit,
                              //fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          )
                        : Text(
                          'ไม่พบวีดีโอคำบรรยายในวิชานี้',
                           style: TextStyle(
                              fontFamily: AppTheme.ruFontKanit,
                              //fontWeight: FontWeight.w100,
                              fontSize: 16,
                              color: Colors.redAccent,
                            ),
                          ),
                  ),
                ),
                // Material(
                //   color: Colors.transparent,
                //   child: InkWell(
                //     focusColor: Colors.transparent,
                //     highlightColor: Colors.transparent,
                //     hoverColor: Colors.transparent,
                //     splashColor: Colors.grey.withOpacity(0.2),
                //     borderRadius: const BorderRadius.all(
                //       Radius.circular(4.0),
                //     ),
                //     onTap: () {
                //       FocusScope.of(context).requestFocus(FocusNode());
                //       Navigator.push<dynamic>(
                //         context,
                //         MaterialPageRoute<dynamic>(
                //             builder: (BuildContext context) => FiltersScreen(),
                //             fullscreenDialog: true),
                //       );
                //     },
                //     child: Padding(
                //       padding: const EdgeInsets.only(left: 8),
                //       child: Row(
                //         children: <Widget>[
                //           Text(
                //             'Filter',
                //             style: TextStyle(
                //               fontWeight: FontWeight.w100,
                //               fontSize: 16,
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Icon(Icons.sort,
                //                 color: HotelAppTheme.buildLightTheme()
                //                     .primaryColor),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            startDate = startData;
            endDate = endData;
          });
        },
        onCancelClick: () {},
      ),
    );
  }

  Widget getAppBarUI(String course, semester, year) {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().scaffoldBackgroundColor,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  '$course($semester/$year)',
                  style: TextStyle(
                    fontFamily: AppTheme.ruFontKanit,
                    //fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
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
