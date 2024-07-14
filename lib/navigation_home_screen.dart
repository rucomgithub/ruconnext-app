import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/custom_drawer/drawer_user_controller.dart';
import 'package:th.ac.ru.uSmart/custom_drawer/home_drawer.dart';
import 'package:th.ac.ru.uSmart/feedback_screen.dart';
import 'package:th.ac.ru.uSmart/help_screen.dart';
import 'package:th.ac.ru.uSmart/home_screen.dart';
import 'package:th.ac.ru.uSmart/invite_friend_screen.dart';
import 'package:th.ac.ru.uSmart/manual/manual_home_screen.dart';
import 'package:th.ac.ru.uSmart/pages/aboutRam_screen.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/providers/mr30_provider.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;
  late FirebaseMessaging messaging;
  void showFlutterNotification(RemoteMessage event) {
    Get.defaultDialog(
        title: '${event.notification!.title}',
        content: Text('${event.notification!.body}'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('ตกลง'))
        ]);
  }

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = MyHomePage();
    super.initState();
    print('messaging token:');
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) => {print('Token Navigate: $value')});
    print('messaging token:');
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      Get.toNamed('/affairs');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            screenView = const MyHomePage();
          });
          break;
        case DrawerIndex.Help:
          setState(() {
            screenView = HelpScreen();
          });
          break;
        case DrawerIndex.Manual:
          setState(() {
            screenView = ManualHomeScreen();
          });
          break;
        case DrawerIndex.FeedBack:
          setState(() {
            screenView = FeedbackScreen();
          });
          break;
        case DrawerIndex.Invite:
          setState(() {
            screenView = InviteFriend();
          });
          break;
        case DrawerIndex.AboutRam:
          setState(() {
            screenView = aboutRam();
          });
          break;
        default:
          break;
      }
    }
  }
}
