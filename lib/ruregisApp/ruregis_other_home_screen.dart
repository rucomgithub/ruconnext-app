import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/model/ruregis_other_list.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_provider.dart';
import 'package:th.ac.ru.uSmart/ruconnext_app_theme.dart';
import 'package:th.ac.ru.uSmart/ruregisApp/profile_view.dart';
import 'package:th.ac.ru.uSmart/ruregisApp/ruregis_other_list_view.dart';

class RuRegisOtherHomeScreen extends StatefulWidget {
  @override
  _RuRegisOtherHomeScreenState createState() => _RuRegisOtherHomeScreenState();
}

class _RuRegisOtherHomeScreenState extends State<RuRegisOtherHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<RuregisOtherListData> otherList = RuregisOtherListData.otherList;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    super.initState();
    Provider.of<RuregisProvider>(context, listen: false)
        .fetchProfileAppRuregis();

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
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              //print('register : ${authen.profile.accessToken}');
              return Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      getAppBarUI(),
                      ProfileView(
                        animation: animationController,
                        animationController: animationController,
                      ),
                      getListUI(),
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: RuConnextAppTheme.buildLightTheme().scaffoldBackgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 80,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return Stack(
                    children: <Widget>[
                      getBg(),
                      ListView.builder(
                        itemCount: otherList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          final int count =
                              otherList.length > 10 ? 10 : otherList.length;
                          final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                      parent: animationController!,
                                      curve: Interval((1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn)));
                          animationController?.forward();

                          return RuregisOtherListView(
                            callback: () {
                              Get.toNamed(otherList[index].navigateScreen);
                            },
                            otherData: otherList[index],
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
          )
        ],
      ),
    );
  }

  Widget getBg() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: RuConnextAppTheme.buildLightTheme().scaffoldBackgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
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
                    Navigator.of(context).popUntil(
                      (route) => route.isFirst,
                    ); // Navigate to the root
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
                  'RU REGIS',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
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
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.logout),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
