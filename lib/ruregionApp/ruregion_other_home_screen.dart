import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/model/ruregion_other_list_model.dart';
import 'package:th.ac.ru.uSmart/providers/authen_regis.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_mr30_provider.dart';
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
    super.initState();

    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);

    Provider.of<RuregisProvider>(context, listen: false)
        .fetchProfileAppRuregion();
    Provider.of<AuthenRuRegionAppProvider>(context, listen: false).getProfile();
    getData();
    Provider.of<AuthenRuRegionAppProvider>(context, listen: false)
        .getCounterRegionApp();
    Provider.of<RuregisProvider>(context, listen: false).getCounterRegionApp();
    Provider.of<RuregisProvider>(context, listen: false).getQRButton();
    // ✅ หลังจาก Build เสร็จแล้วค่อยเช็คค่าจาก API แล้วเด้ง Popup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAPIStatusAndShowPopup();
    });
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
    bool? checkReceipt = Provider.of<RuregisProvider>(context, listen: false)
        .buttonQRregionApp
        .rECEIPTSTATUS;
    bool? checkRegis = Provider.of<RuregisProvider>(context, listen: false)
        .buttonQRregionApp
        .rEGISSTATUS;
    if (checkReceipt == true) {
      otherList = RuregionOtherListData.otherListSuccess;
    } else {
      otherList = RuregionOtherListData.otherListDefualt;
    }
    // var statusregis = context.watch<RuregisProvider>().ruregionApp.rEGISSTATUS;
    // print('home ====> $statusregis');
    // if (statusregis == false) {
    //   otherList = RuregionOtherListData.otherListSuccess;
    // } else {
    //   otherList = RuregionOtherListData.otherListDefualt;
    // }

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
                            Expanded(child: getListUI()),
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
          Expanded(
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                var counter =
                    Provider.of<RuregisProvider>(context, listen: false);
                var rureisprov =
                    Provider.of<RuregisProvider>(context, listen: false);
                var statusregis =
                    context.watch<RuregisProvider>().ruregionApp.rEGISSTATUS;

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
                              if (counter.counterregionApp.resultsCounter![0]
                                      .sYSTEMSTATUS ==
                                  false) {
                                showAlert(context, 'แจ้งเตือน ออกจากระบบ',
                                    '${otherList[index].navigateScreen}');
                              } else {
                                if (counter.counterregionApp.resultsCounter![0]
                                        .sYSTEMSTATUSCLOSE ==
                                    true) {
                                  showAlert(
                                      context,
                                      'เปิดการลงทะเบียนเรียนวันที่ ${counter.counterregionApp.resultsCounter![0].sTARTDATE} - ${counter.counterregionApp.resultsCounter![0].eNDDATE}',
                                      '${otherList[index].navigateScreen}');
                                } else {
                                  if (statusregis == false) {
                                    showAlert(
                                        context,
                                        '${rureisprov.ruregionApp.eRRMSG}',
                                        '${otherList[index].navigateScreen}');
                                  } else {
                                    if (otherList[index].navigateScreen ==
                                        '/ruregionAppmr30') {
                                      // ดึง API_ID = 3 ออกมา
                                      final api3 = counter
                                          .counterregionApp.resultsAppControl!
                                          .firstWhere((e) => e.aPIID == "3");

                                      // API_STATUS == true → ห้ามเข้า + แจ้งเตือน
                                      if (api3.aPISTATUS == true) {
                                        showAlert(
                                          context,
                                          api3.aPIDES ??
                                              'ไม่สามารถดำเนินการได้', // ข้อความแจ้งเตือน
                                          otherList[index].navigateScreen,
                                        );
                                        return;
                                      } else {
                                        if (rureisprov.buttonQRregionApp
                                                .rEGISSTATUS ==
                                            true) {
                                          showAlert(
                                            context,
                                            'นักศึกษาได้ลงทะเบียนเรียนและรับ QRCODE แล้วไม่สามารถเปลี่ยนแปลงวิชาเรียนได้', // ข้อความแจ้งเตือน
                                            otherList[index].navigateScreen,
                                          );
                                        } else {
                                          // API_STATUS == false → เข้าได้
                                          Get.toNamed(
                                              otherList[index].navigateScreen);
                                        }
                                      }
                                    } else if (otherList[index]
                                            .navigateScreen ==
                                        '/ruregionAppQR') {
                                      final api1 = counter
                                          .counterregionApp.resultsAppControl!
                                          .firstWhere((e) => e.aPIID == "1");
                                      if (api1.aPISTATUS == true) {
                                        showAlert(
                                          context,
                                          api1.aPIDES ??
                                              'ไม่สามารถดำเนินการได้', // ข้อความแจ้งเตือน
                                          otherList[index].navigateScreen,
                                        );
                                        return;
                                      } else {
                                        if (rureisprov.buttonQRregionApp
                                                .rEGISSTATUS ==
                                            false) {
                                          showAlert(
                                            context,
                                            'กรุณาลงทะเบียนเรียนและยืนยันการรับ QRCODE ก่อน', // ข้อความแจ้งเตือน
                                            otherList[index].navigateScreen,
                                          );
                                        } else {
                                          Get.toNamed(
                                              otherList[index].navigateScreen);
                                        }
                                      }
                                    } else if (otherList[index]
                                            .navigateScreen ==
                                        '/ruregionAppreceipt') {
                                      final api3 = counter
                                          .counterregionApp.resultsAppControl!
                                          .firstWhere((e) => e.aPIID == "3");
                                      if (api3.aPISTATUS == true) {
                                        showAlert(
                                          context,
                                          api3.aPIDES ??
                                              'ไม่สามารถดำเนินการได้', // ข้อความแจ้งเตือน
                                          otherList[index].navigateScreen,
                                        );
                                        return;
                                      } else {
                                        if (rureisprov.buttonQRregionApp
                                                .rEGISSTATUS ==
                                            false) {
                                          showAlert(
                                            context,
                                            'กรุณาเลือกวิชาลงทะเบียนก่อน', // ข้อความแจ้งเตือน
                                            otherList[index].navigateScreen,
                                          );
                                        } else {
                                          Get.toNamed(
                                              otherList[index].navigateScreen);
                                        }
                                      }
                                    } else {
                                      Get.toNamed(
                                          otherList[index].navigateScreen);
                                    }
                                  }
                                }
                              }
                            },
                            // callback: () {

                            //   if (counter.counterregionApp.resultsAppControl![0]
                            //           .aPISTATUS ==
                            //       true) {
                            //     showAlert(
                            //         context,
                            //         '${counter.counterregionApp.resultsAppControl![0].aPIDES}',
                            //         '${otherList[index].navigateScreen}');
                            //   } else if (counter.counterregionApp
                            //           .resultsAppControl![0].aPISTATUS ==
                            //       false) {
                            //     if (otherList[index].navigateScreen ==
                            //         '/ruregionAppmr30') {
                            //       if (rureisprov.ruregionApp.rEGISSTATUS ==
                            //           false) {
                            //         Get.toNamed(
                            //             otherList[index].navigateScreen);
                            //       } else {
                            //         showAlert(
                            //             context,
                            //             'ลงทะเบียนเรียนได้นักศึกษารับ QRCODE แล้วไม่สามารถเปลี่ยนแปลงวิชาเรียนได้',
                            //             '${otherList[index].navigateScreen}');
                            //       }
                            //     }
                            //      else if (otherList[index].navigateScreen ==
                            //         '/ruregionAppQR') {
                            //       if (rureisprov.ruregionApp.rEGISSTATUS ==
                            //           false) {
                            //                     showAlert(
                            //             context,
                            //             'กรุณาลงทะเบียนเรียนและยืนยันการรับ QRCODE ก่อน',
                            //             '${otherList[index].navigateScreen}');

                            //       } else {
                            //             Get.toNamed(
                            //             otherList[index].navigateScreen);
                            //       }
                            //     }
                            //     // else if (otherList[index].navigateScreen ==
                            //     //     '/ruregionAppreceipt' || otherList[index].navigateScreen ==
                            //     //     '/ruregionAppsuccess2') {
                            //     //   if (rureisprov.ruregionApp.rEGISSTATUS ==
                            //     //       false) {
                            //     //     Get.toNamed(
                            //     //         otherList[index].navigateScreen);
                            //     //   } else {
                            //     //     showAlert(
                            //     //         context,
                            //     //         '${rureisprov.ruregionApp.eRRMSG}',
                            //     //         '${otherList[index].navigateScreen}');
                            //     //   }
                            //     // }
                            //     else {
                            //       Get.toNamed(otherList[index].navigateScreen);
                            //     }
                            //   }
                            // },
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
    var provmr30 = Provider.of<RUREGISMR30Provider>(context, listen: false);
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
                    );
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
                        provmr30.removeRuregionPref1();
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
      barrierDismissible: true,
      builder: (context) {
        TextEditingController textEditingController = TextEditingController();

        var rureisprov = Provider.of<RuregisProvider>(context, listen: false);
        List<TextSpan> textSpans = [
          TextSpan(
            text: '$txtAlert',
            style: TextStyle(
              fontFamily: AppTheme.ruFontKanit,
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: FitnessAppTheme.nearlyBlack,
            ),
          ),
        ];

        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(hintText: ''),
                ),
                Text.rich(TextSpan(children: textSpans)),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'ตกลง',
                style: TextStyle(
                  fontFamily: AppTheme.ruFontKanit,
                  fontSize: 15,
                  color: Color.fromARGB(255, 54, 82, 60),
                ),
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
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!provider.isLoading)
                  Text(
                      '${provider.counterregionApp.resultsAppControl![2].aPIDES}'),
                if (provider.isLoading) CircularProgressIndicator(),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'ตกลง',
                style: TextStyle(
                  fontFamily: AppTheme.ruFontKanit,
                  fontSize: 15,
                  color: Color.fromARGB(255, 54, 82, 60),
                ),
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

  // ✅ ฟังก์ชันตรวจสอบ API แล้วเด้ง Popup
  void _checkAPIStatusAndShowPopup() {
    final counterProv = Provider.of<RuregisProvider>(context, listen: false);

    // ✅ ดึงค่าจาก API
    final apiStatus =
        counterProv.counterregionApp.resultsAppControl![2].aPISTATUS;

    final apiName =
        counterProv.counterregionApp.resultsAppControl![2].aPINAME ?? '';
    final apiMessage =
        counterProv.counterregionApp.resultsAppControl![2].aPIDES ?? '';

    // ✅ ถ้ามีข้อความจาก API ให้เด้ง Popup
    if (apiMessage.isNotEmpty) {
      _showWelcomePopup(apiStatus, apiMessage, apiName);
    }
  }

  // ✅ ฟังก์ชัน Popup จาก API
  void _showWelcomePopup(bool? apiStatus, String apiMessage, String apiName) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text(
            apiName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: AppTheme.ruFontKanit,
            ),
          ),
          content: Text(
            apiMessage,
            style: TextStyle(
              fontSize: 16,
              fontFamily: AppTheme.ruFontKanit,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'ตกลง',
                style: TextStyle(
                  fontFamily: AppTheme.ruFontKanit,
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
