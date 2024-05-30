// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/model/hotel_list_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/model/ruregis_list_data.dart';
import 'package:th.ac.ru.uSmart/providers/region_enroll_provider.dart';
import 'package:th.ac.ru.uSmart/ruregis/ruregion_login.dart';
import 'package:th.ac.ru.uSmart/widget/Rubar.dart';
import '../hotel_booking/hotel_app_theme.dart';
import '../providers/ruregis_provider.dart';
import 'package:get/get.dart';

class RuRegisHomeScreen extends StatefulWidget {
  @override
  _RuRegisHomeScreenState createState() => _RuRegisHomeScreenState();
}

class _RuRegisHomeScreenState extends State<RuRegisHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<RuregisListData> ruregisList = RuregisListData.ruregisList;
  List<HotelListData> hotelList = HotelListData.hotelList;
  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  var msgNoti;
 final secret = dotenv.env['SECRET'];
  @override
  void initState() {
    
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    // simply use this
    var stdcode = Provider.of<RuregisProvider>(context, listen: false).stdcode;
    var semester =
        Provider.of<RuregisProvider>(context, listen: false).semester;
    var year = Provider.of<RuregisProvider>(context, listen: false).year;
    Provider.of<RuregisProvider>(context, listen: false).fetchProfileRuregis();

    Provider.of<RuregisProvider>(context, listen: false).fetchMessageRegion();
    Provider.of<RuregisProvider>(context, listen: false).fetchCounterRegion();
    Provider.of<RegionEnrollProvider>(context, listen: false)
        .getEnrollRegionProv(stdcode, semester, year);
    bool appclose =
        Provider.of<RuregisProvider>(context, listen: false).appClose;
    // Timer.run(() {
    //   if (appclose == true) {
    //     showCloseApp(context);
    //   } else {
    //     showAlertMsgNoti(context);
    //   }
    // });
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
    //context.read<RuregisProvider>().getAllRuregis();

    var ruregisProv = context.watch<RuregisProvider>();

    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Container(
        child: Provider.of<RuregisProvider>(context).isLoading == false
            ? Scaffold(
                body: Stack(
                  children: <Widget>[
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: ruregisProv.auth != 'notoken' 
                          ? Column(
                              children: <Widget>[
                                getAppBarUI(),
                                Column(children: <Widget>[
                                  ProfileCard(),
                                ]),
                                Column(children: <Widget>[
                                  NavigateToSearch(),
                                ]),
                                Column(children: <Widget>[
                                  NavigateToCheckRegis(),
                                ]),
                                Column(children: <Widget>[
                                  NavigateToQRCode(),
                                ]),
                              ],
                            )
                          : RuregionLoginPage(),
                    ),
                  ],
                ),
              )
            : Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }

  Widget NavigateToSearch() {
    var ctrlMr30 = context.watch<RuregisProvider>().ctrlMr30;
    var checkregis = context.watch<RuregisProvider>().ruregis.rEGISSTATUS;
    return GestureDetector(
        onTap: () {
          if (ctrlMr30 == false && checkregis == true)
            Get.toNamed('/ruregionmr30');
          if (ctrlMr30 == true) showAlertMr30(context);
          if (checkregis == false) showAlertcanRegis(context);
        },
        child: Container(
            child: Card(
          margin: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'ค้นหาวิชา',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                subtitle: Text(''),
              ),
            ],
          ),
        )));
  }

  Widget NavigateToQRCode() {
    var ctrlMr30 = context.watch<RuregisProvider>().ctrlMr30;
    var checkregis = context.watch<RuregisProvider>().ruregis.rEGISSTATUS;

    return GestureDetector(
        onTap: () {
          if (ctrlMr30 == false && checkregis == true)
            Get.toNamed('/ruregionqrcode');
          if (ctrlMr30 == true) showAlertGenQR(context);
          if (checkregis == false) showAlertcanRegis(context);
        },
        child: Container(
            child: Card(
          margin: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'รับ QRCode',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                subtitle: Text(''),
              ),
            ],
          ),
        )));
  }

  Widget NavigateToCheckRegis() {
    var checkRegis =
        context.watch<RegionEnrollProvider>().enrollruregion.rEGISSTATUS;
    var checkcanregis = context.watch<RuregisProvider>().ruregis.rEGISSTATUS;

    return GestureDetector(
        onTap: () {
          if (checkRegis == true && checkcanregis == true) {
            Get.toNamed('/ruregionreceipt');
          } else if (checkRegis == false && checkcanregis == true) {
            Get.toNamed('/ruregisconfirm');
          } else if (checkcanregis == false) {
            showAlertcanRegis(context);
          }
        },
        child: Container(
            child: Card(
          margin: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'ตรวจสอบการลงทะเบียน',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                subtitle: Text(''),
              ),
            ],
          ),
        )));
  }

  Widget ProfileCard() {
    var ruregisProv = context.watch<RuregisProvider>();
    return Container(
        child: SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/ID.png'),
              ),
              title: Text(
                ruregisProv.ruregis.nAMETHAI!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              subtitle: Text(
                '${ruregisProv.ruregis.fACULTYNAMETHAI!} สาขา${ruregisProv.ruregis.mAJORNAMETHAI!} หลักสูตร${ruregisProv.ruregis.cURRNAMETHAI!}  ',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  // void showAlertMsgNoti(BuildContext context) {
  //   final provider = Provider.of<RuregisProvider>(context);
  //   showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             content: Text("${provider.messageregion}"),
  //           ));
  // }
  void showCloseApp(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents closing the dialog by tapping outside
      builder: (context) {
        final provider = Provider.of<RuregisProvider>(context);
        TextEditingController textEditingController = TextEditingController();

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!provider.isLoading) Text(provider.appCloseMsg),
              if (provider.isLoading) CircularProgressIndicator(),
              if (!provider.isLoading)
                TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: '',
                  ),
                ),
            ],
          ),
          actions: [
            if (!provider.isLoading) // Show close button only if not loading
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  if (textEditingController.text == 'k$secret') {
                    Navigator.of(context).pop();
                  } else {
                    // You can handle incorrect input here if needed
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                },
              ),
          ],
        );
      },
    );
  }

  void showAlertMsgNoti(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          true, // Prevents closing the dialog by tapping outside
      builder: (context) {
        final provider = Provider.of<RuregisProvider>(context);
        var profilestatus = Provider.of<RuregisProvider>(context);
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!provider.isLoading)
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: ' • ${profilestatus.ruregis.eRRMSG! + '\n'}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            ' • ${profilestatus.ruregis.sTDSTATUSDESCTHAI! + '\n'}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: '${'\n' + provider.msgNotiRegion}'),
                    ],
                  ),
                ),
              if (provider.isLoading) CircularProgressIndicator(),
            ],
          ),
          actions: [
            if (!provider.isLoading)
              TextButton(
                child: Text(
                  'Close',
                  style: TextStyle(color: Colors.red), // Change color here
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

  void showAlertGenQR(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        final provider = Provider.of<RuregisProvider>(context);
        TextEditingController textEditingController = TextEditingController();

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!provider.isLoading) Text(provider.ctrlMsgMr30),
              if (provider.isLoading) CircularProgressIndicator(),
              if (!provider.isLoading)
                TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: '',
                  ),
                ),
            ],
          ),
          actions: [
            if (!provider.isLoading) // Show close button only if not loading
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  if (textEditingController.text == 'qr$secret') {
                    Get.toNamed('/ruregionqrcode');
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

  void showAlertMr30(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        final provider = Provider.of<RuregisProvider>(context);
        TextEditingController textEditingController = TextEditingController();

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!provider.isLoading) Text(provider.ctrlMsgMr30),
              if (provider.isLoading) CircularProgressIndicator(),
              if (!provider.isLoading)
                TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: '',
                  ),
                ),
            ],
          ),
          actions: [
            if (!provider.isLoading) // Show close button only if not loading
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  if (textEditingController.text == 'regis$secret') {
                    Get.toNamed('/ruregionmr30');
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

  void showAlertcanRegis(BuildContext context) {
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
                Text('${provider.ruregis.eRRMSG}'),
              if (provider.isLoading == true) CircularProgressIndicator(),
            ],
          ),
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
              if (provider.isLoading == false) Text(provider.ctrlMsgMr30),
              if (provider.isLoading == true) CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 8.0,
          ),
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
              child: Rubar(textTitle: 'ลงทะเบียนเรียนส่วนภูมิภาค'),
            ),
            Container(
              width: AppBar().preferredSize.height,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    _logout(context);
                    // Add your logout functionality here
                    // Example: AuthService.logout();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.logout),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _logout(BuildContext context) async {
  //   // Clear the specific shared preference
  //   // final pref = await SharedPreferences.getInstance();
  //   // await pref.clear();
  //   print('clear');

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //    await prefs.clear();
  //   // Navigate to the root screen (assuming your root screen is named 'RootScreen')
  //   // Navigator.of(context).popUntil(
  //   //   (route) => route.isFirst,
  //   // );
  // }
  static Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('regionlogin', 'notoken');
    Navigator.of(context).popUntil(
      (route) => route.isFirst,
    );
  }
}
