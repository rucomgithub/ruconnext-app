import 'package:th.ac.ru.uSmart/affairs/affairs_home_screen.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_home_screen.dart';
import 'package:th.ac.ru.uSmart/grade/grade_app_home_screen.dart';
import 'package:th.ac.ru.uSmart/master/pages/grade/master_grade_app_home_screen.dart';
import 'package:th.ac.ru.uSmart/master/pages/master_profile_screen.dart';
import 'package:th.ac.ru.uSmart/master/pages/register/master_register_home_screen.dart';
import 'package:th.ac.ru.uSmart/model/access_rule.dart';
import 'package:th.ac.ru.uSmart/mr30/mr30_home_screen.dart';
import 'package:th.ac.ru.uSmart/pages/aboutRam_screen.dart';
import 'package:th.ac.ru.uSmart/pages/profile_home_screen.dart';
import 'package:th.ac.ru.uSmart/registers/register_home_screen.dart';
import 'package:th.ac.ru.uSmart/registers/course_home_screen.dart';
import 'package:th.ac.ru.uSmart/ruregionApp/ruregion_other_home_screen.dart';
import 'package:th.ac.ru.uSmart/schedule/schedule_home_screen.dart';
import 'package:th.ac.ru.uSmart/screens/runewsScreen.dart';
import 'package:th.ac.ru.uSmart/screens/splash_screen.dart';
import 'package:th.ac.ru.uSmart/today/today_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var stdcode;

class HomeList {
  HomeList(
      {this.navigateScreen,
      this.imagePath = '',
      this.iconsData,
      this.color,
      this.roles});

  Widget? navigateScreen;
  String imagePath;
  IconData? iconsData;
  MaterialColor? color;
  List<UserRole>? roles;

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    //check token มีจริงม้ย หรือหมดอายุหรือไม่
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
  }

  static List<HomeList> homeList = [
    HomeList(
        imagePath: 'assets/fitness_app/A18.png',
        iconsData: Icons.abc,
        color: Colors.purple,
        navigateScreen: aboutRam(),
        roles: [
          UserRole.Guest,
          UserRole.Bachelor,
          UserRole.Master,
          UserRole.Doctor
        ]),
    HomeList(
      imagePath: 'assets/fitness_app/A14.png',
      iconsData: Icons.newspaper,
      color: Colors.brown,
      navigateScreen: RunewsScreen(),
      roles: [
        UserRole.Guest,
        UserRole.Bachelor,
        UserRole.Master,
        UserRole.Doctor
      ],
    ),
    HomeList(
      imagePath: 'assets/fitness_app/A20.png',
      iconsData: Icons.calendar_month,
      color: Colors.brown,
      navigateScreen: ScheduleHomeScreen(),
      roles: [
        UserRole.Guest,
        UserRole.Bachelor,
      ],
    ),
    HomeList(
      imagePath: 'assets/fitness_app/A1.png',
      iconsData: Icons.account_box,
      color: Colors.pink,
      navigateScreen: ProfileHomeScreen(),
      roles: [UserRole.Bachelor],
    ),
    HomeList(
      imagePath: 'assets/fitness_app/A9.png',
      iconsData: Icons.abc,
      color: Colors.yellow,
      navigateScreen: GradeAppHomeScreen(),
      roles: [UserRole.Bachelor],
    ),
    HomeList(
      imagePath: 'assets/fitness_app/A2.png',
      iconsData: Icons.app_registration,
      color: Colors.brown,
      navigateScreen: RegisterHomeScreen(),
      roles: [UserRole.Bachelor],
    ),
    HomeList(
      imagePath: 'assets/fitness_app/A7.png',
      iconsData: Icons.book,
      color: Colors.orange,
      navigateScreen: Mr30HomeScreen(),
      roles: [UserRole.Guest, UserRole.Bachelor],
    ),
    HomeList(
      imagePath: 'assets/fitness_app/A13.png',
      iconsData: Icons.today,
      color: Colors.grey,
      navigateScreen: TodayHomeScreen(),
      roles: [UserRole.Guest, UserRole.Bachelor],
    ),
    HomeList(
      imagePath: 'assets/fitness_app/AF0.png',
      iconsData: Icons.app_registration,
      color: Colors.brown,
      navigateScreen: AffairsHomeScreen(),
      roles: [UserRole.Guest, UserRole.Bachelor],
    ),
    HomeList(
      imagePath: 'assets/fitness_app/A1.png',
      iconsData: Icons.account_box,
      color: Colors.pink,
      navigateScreen: MasterProfileScreen(),
      roles: [UserRole.Master, UserRole.Doctor],
    ),
    HomeList(
      imagePath: 'assets/fitness_app/A9.png',
      iconsData: Icons.abc,
      color: Colors.yellow,
      navigateScreen: MasterGradeAppHomeScreen(),
      roles: [UserRole.Master, UserRole.Doctor],
    ),
    HomeList(
      imagePath: 'assets/fitness_app/A2.png',
      iconsData: Icons.app_registration,
      color: Colors.brown,
      navigateScreen: MasterRegisterHomeScreen(),
      roles: [UserRole.Master, UserRole.Doctor],
    ),
    HomeList(
      imagePath: 'assets/fitness_app/REGION.png',
      iconsData: Icons.vertical_shades_rounded,
      color: Colors.purple,
      // navigateScreen:  RuRegisHomeScreen(),
      navigateScreen: RuRegionOtherHomeScreen(),
      roles: [
        UserRole.Guest,
        UserRole.Bachelor,
      ],
    ),
  ];
}
