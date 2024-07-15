import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/home_screen.dart';
import 'package:th.ac.ru.uSmart/login_page.dart';
import 'package:th.ac.ru.uSmart/navigation_home_screen.dart';
import 'package:th.ac.ru.uSmart/pages/flipcard_screen.dart';
import 'package:th.ac.ru.uSmart/providers/authenprovider.dart';
import 'package:th.ac.ru.uSmart/screens/runewsScreen.dart';
import 'package:th.ac.ru.uSmart/today/today_home_screen.dart';
import '../fitness_app/fitness_app_theme.dart';

String? tokenGrade;

class ProfileHomeScreen extends StatefulWidget {
  @override
  _ProfileHomeScreenState createState() => _ProfileHomeScreenState();
}

class _ProfileHomeScreenState extends State<ProfileHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = FlipCardPage();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  int _selectedIndex = 1; // Tracks selected bottom bar item

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
    } else if (index == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ProfileHomeScreen()));
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TodayHomeScreen()));
    } else if (index == 3) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RunewsScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var authen = context.watch<AuthenProvider>();
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
              return authen.profile.accessToken != null
                  ? Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        tabBody,
                      ],
                    )
                  : LoginPage();
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: AppTheme.ru_yellow,
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
              child: GNav(
                gap: 8, // Gap between tabs (optional)
                backgroundColor: AppTheme.white, // Adjust color as needed
                activeColor:
                    AppTheme.ru_dark_blue, // Adjust active color as needed
                color: AppTheme.ru_dark_blue
                    .withAlpha(200), // Adjust unselected color as needed
                iconSize: 24, // Icon size (optional)
                padding: EdgeInsets.symmetric(
                    horizontal: 15, vertical: 8), // Padding (optional)
                tabActiveBorder: Border.all(
                    color: AppTheme.ru_dark_blue,
                    width: 1), // Tab border (optional)
                curve: Curves.easeOutExpo, // tab animation curves
                duration: Duration(milliseconds: 600),
                tabs: [
                  GButton(
                      icon: Icons.home,
                      text: 'หน้าแรก',
                      textStyle: TextStyle(
                          fontFamily: AppTheme.ruFontKanit,
                          color: AppTheme.ru_dark_blue)),
                  GButton(
                      icon: Icons.person,
                      text: 'บัตรนักศึกษา',
                      textStyle: TextStyle(
                          fontFamily: AppTheme.ruFontKanit,
                          color: AppTheme.ru_dark_blue)),
                  GButton(
                      icon: Icons.calendar_today,
                      text: 'ตารางเรียนวันนี้',
                      textStyle: TextStyle(
                          fontFamily: AppTheme.ruFontKanit,
                          color: AppTheme.ru_dark_blue)),
                  GButton(
                      icon: Icons.newspaper,
                      text: 'ประชาสัมพันธ์',
                      textStyle: TextStyle(
                          fontFamily: AppTheme.ruFontKanit,
                          color: AppTheme.ru_dark_blue)),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) => _onItemTapped(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
