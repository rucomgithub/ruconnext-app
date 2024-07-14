import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/affairs/rotcs/rotcs_list_screen.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/models/tabIcon_data.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/hotel_app_theme.dart';
import 'package:th.ac.ru.uSmart/login_page.dart';
import 'package:th.ac.ru.uSmart/providers/authenprovider.dart';

String? tokenMr30;

class RotcsHomeScreen extends StatefulWidget {
  @override
  _RotcsHomeScreenState createState() => _RotcsHomeScreenState();
}

class _RotcsHomeScreenState extends State<RotcsHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    Provider.of<AuthenProvider>(context, listen: false).getProfile();
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = RotcsListScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    var authen = context.watch<AuthenProvider>();
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          backgroundColor: AppTheme.white,
          body: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return SizedBox();
              } else {
                // return Stack(
                //   children: <Widget>[
                //     tabBody,
                //   ],
                // );

                return authen.profile.accessToken != null
                    ? Stack(
                        children: <Widget>[
                          tabBody,
                        ],
                      )
                    : LoginPage();
              }
            },
          ),
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 300));
    return true;
  }
}
