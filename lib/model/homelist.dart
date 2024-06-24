import 'package:th.ac.ru.uSmart/design_course/home_design_course.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_home_screen.dart';
import 'package:th.ac.ru.uSmart/grade/grade_app_home_screen.dart';
import 'package:th.ac.ru.uSmart/home/homescreen.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/hotel_home_screen.dart';
import 'package:th.ac.ru.uSmart/introduction_animation/introduction_animation_screen.dart';
import 'package:th.ac.ru.uSmart/mr30/mr30_home_screen.dart';
import 'package:th.ac.ru.uSmart/other/other_home_screen.dart';
import 'package:th.ac.ru.uSmart/pages/aboutRam_screen.dart';
import 'package:th.ac.ru.uSmart/pages/flipcard_screen.dart';
import 'package:th.ac.ru.uSmart/pages/mr30_catalog.dart';
import 'package:th.ac.ru.uSmart/pages/order_traking_page.dart';
import 'package:th.ac.ru.uSmart/pages/ru_map.dart';
import 'package:th.ac.ru.uSmart/registers/register_home_screen.dart';
import 'package:th.ac.ru.uSmart/rotcs/rotcs_home_screen.dart';
import 'package:th.ac.ru.uSmart/ruregionApp/ruregion_other_home_screen.dart';
import 'package:th.ac.ru.uSmart/ruregis/ruregion_login.dart';


import 'package:th.ac.ru.uSmart/ruregisApp/ruregis_other_home_screen.dart';

import 'package:th.ac.ru.uSmart/schedule/schedule_home_screen.dart';
import 'package:th.ac.ru.uSmart/screens/runewsScreen.dart';
// import 'package:th.ac.ru.uSmart/registers/register1_screen.dart';

import 'package:th.ac.ru.uSmart/screens/today/today_screen.dart';
import 'package:th.ac.ru.uSmart/today/study_home_screen.dart';
import 'package:th.ac.ru.uSmart/today/today_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_page.dart';

var stdcode;

class HomeList {
  HomeList(
      {this.navigateScreen, this.imagePath = '', this.iconsData, this.color});

  Widget? navigateScreen;
  String imagePath;
  IconData? iconsData;
  MaterialColor? color;

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    //check token มีจริงม้ย หรือหมดอายุหรือไม่
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
  }

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/fitness_app/A1.png',
      iconsData: Icons.account_box,
      color: Colors.pink,
      navigateScreen: FlipCardPage(),
    ),
    HomeList(
      imagePath: 'assets/fitness_app/A9.png',
      iconsData: Icons.abc,
      color: Colors.yellow,
      navigateScreen: GradeAppHomeScreen(),
    ),
    HomeList(
      imagePath: 'assets/fitness_app/A2.png',
      iconsData: Icons.app_registration,
      color: Colors.brown,
      navigateScreen: RegisterHomeScreen(),
    ),
    HomeList(
      imagePath: 'assets/fitness_app/A7.png',
      iconsData: Icons.book,
      color: Colors.orange,
      navigateScreen: Mr30HomeScreen(),
    ),
    HomeList(
      imagePath: 'assets/fitness_app/A13.png',
      iconsData: Icons.today,
      color: Colors.grey,
      navigateScreen: TodayHomeScreen(),
    ),
    HomeList(
      imagePath: 'assets/fitness_app/A20.png',
      iconsData: Icons.app_registration,
      color: Colors.brown,
      navigateScreen: ScheduleHomeScreen(),
    ),
    HomeList(
      imagePath: 'assets/fitness_app/A14.png',
      iconsData: Icons.app_registration,
      color: Colors.brown,
      navigateScreen: RunewsScreen(),
    ),
    HomeList(
      imagePath: 'assets/fitness_app/A15.png',
      iconsData: Icons.app_registration,
      color: Colors.brown,
      navigateScreen: OtherHomeScreen(),
    ),
    HomeList(
      imagePath: 'assets/fitness_app/A18.png',
      iconsData: Icons.vertical_shades_rounded,
      color: Colors.purple,
      navigateScreen: aboutRam(),
    ),
    HomeList(
      imagePath: 'assets/fitness_app/ruregion.png',
      iconsData: Icons.vertical_shades_rounded,
      color: Colors.purple,
      // navigateScreen:  RuRegisHomeScreen(),
      navigateScreen: RuRegionOtherHomeScreen(),
    ),
    HomeList(
      imagePath: 'assets/fitness_app/ruregis.png',
      iconsData: Icons.vertical_shades_rounded,
      color: Colors.purple,
      // navigateScreen:  RuRegisHomeScreen(),
      navigateScreen: RuRegisOtherHomeScreen(),
    ),
  ];
}
