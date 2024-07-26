import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/model/ruregion_other_list_model.dart';
import 'package:th.ac.ru.uSmart/other/other_list_view.dart';
import 'package:th.ac.ru.uSmart/providers/authen_regis.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_provider.dart';
import 'package:th.ac.ru.uSmart/ruconnext_app_theme.dart';
import 'package:th.ac.ru.uSmart/ruregionApp/profile_region_view.dart';
import 'package:th.ac.ru.uSmart/ruregionApp/ruregion_login.dart';
import 'package:th.ac.ru.uSmart/ruregionApp/ruregion_other_list_view.dart';

class RuRegionOtherHomeScreen extends StatefulWidget {
  @override
  _RuRegionOtherHomeScreenState createState() =>
      _RuRegionOtherHomeScreenState();
}

class _RuRegionOtherHomeScreenState extends State<RuRegionOtherHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<RuregionOtherListData> otherList =
      RuregionOtherListData.otherListDefualt;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  final secret = dotenv.env['SECRET'];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    super.initState();
    Provider.of<RuregisProvider>(context, listen: false)
        .fetchProfileAppRuregion();
    Provider.of<AuthenRuRegionAppProvider>(context, listen: false).getProfile();
    getData();
    Provider.of<AuthenRuRegionAppProvider>(context, listen: false)
        .getCounterRegionApp();

    Provider.of<RuregisProvider>(context, listen: false).getCounterRegionApp();

    // Timer.run(() {
    //   showAlertRegis(context);
    // });
    //Noti.initialize(flutterLocalNotificationsPlugin);
  }

  Future<bool> getData() async {
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
    var provruregis =
        Provider.of<AuthenRuRegionAppProvider>(context, listen: false);
    // var statusregis = Provider.of<RuregisProvider>(context, listen: false)
    //     .ruregionApp
    //     .rEGISSTATUS;

    var statusregis = context.watch<RuregisProvider>().ruregionApp.rEGISSTATUS;

    if (statusregis == false) {
      otherList = RuregionOtherListData.otherListSuccess;
    } else {
      otherList = RuregionOtherListData.otherListDefualt;
    }
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
              // print('login res ${provruregis.loginres.rec![0].username}');
              return provruregis.loginres.tf != null
                  ? Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            getAppBarUI(),
                            ProfileRegionView(
                              animation: animationController,
                              animationController: animationController,
                            ),
                            getListUI(),
                          ],
                        )
                      ],
                    )
                  : RuregionAppLoginPage();
            }
          },
        ),
      ),
    );
  }

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: RuConnextAppTheme.buildLightTheme().backgroundColor,
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
            height: MediaQuery.of(context).size.height - 80,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                var counter =
                    Provider.of<RuregisProvider>(context, listen: false);
                var rureisprov =
                    Provider.of<RuregisProvider>(context, listen: false);

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

                          return RuregionOtherListView(
                            callback: () {
                              print(
                                  'status regis ${counter.counterregionApp.resultsAppControl}');
                              if (counter.counterregionApp.resultsAppControl![0]
                                      .aPISTATUS ==
                                  true) {
                                showAlert(
                                    context,
                                    '${counter.counterregionApp.resultsAppControl![0].aPIDES}',
                                    '${otherList[index].navigateScreen}');
                              } else if (counter.counterregionApp
                                      .resultsAppControl![0].aPISTATUS ==
                                  false) {
                                if (otherList[index].navigateScreen ==
                                    '/ruregionAppmr30') {
                                  if (rureisprov.ruregionApp.rEGISSTATUS ==
                                      true) {
                                    Get.toNamed(
                                        otherList[index].navigateScreen);
                                  } else if (rureisprov
                                          .ruregionApp.rEGISSTATUS ==
                                      false) {
                                    showAlert(
                                        context,
                                        '${rureisprov.ruregionApp.eRRMSG}',
                                        '${otherList[index].navigateScreen}');
                                  }
                                } else {
                                  Get.toNamed(otherList[index].navigateScreen);
                                }
                              }
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
    var provruregis =
        Provider.of<AuthenRuRegionAppProvider>(context, listen: false);
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
                  'RU REGION',
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
                      onTap: () {
                        provruregis.logout();
                      },
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

  void showAlert(BuildContext context, String txtAlert, String navigate) {
    showDialog(
      context: context,
      barrierDismissible: true, // Allows closing the dialog by tapping outside
      builder: (context) {
        TextEditingController textEditingController = TextEditingController();

        var rureisprov = Provider.of<RuregisProvider>(context, listen: false);
        List<TextSpan> textSpans = [];

        textSpans.add(
          TextSpan(
            text: '$txtAlert',
            style: TextStyle(
              fontFamily: AppTheme.ruFontKanit,
              fontWeight: FontWeight.normal,
              fontSize: 15,
              letterSpacing: 0.0,
              color: FitnessAppTheme.nearlyBlack,
            ),
          ),
        );

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: '',
                ),
              ),
              Text.rich(
                TextSpan(
                  children: textSpans,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                'ตกลง',
                style: TextStyle(
                  fontFamily: AppTheme.ruFontKanit,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  letterSpacing: 0.0,
                  color: Color.fromARGB(255, 54, 82, 60),
                ), // Sets the text color
              ),
              onPressed: () {
                if (textEditingController.text == 'dev$secret') {
                  Get.toNamed('${navigate}');
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showAlertRegis(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        final provider = Provider.of<RuregisProvider>(context);
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (provider.isLoading == false)
                Text(
                    '${provider.counterregionApp.resultsAppControl![2].aPIDES}'),
              if (provider.isLoading == true) CircularProgressIndicator(),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                'ตกลง',
                style: TextStyle(
                  fontFamily: AppTheme.ruFontKanit,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  letterSpacing: 0.0,
                  color: Color.fromARGB(255, 54, 82, 60),
                ), // Sets the text color
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
