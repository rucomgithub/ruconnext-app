import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/fitness_app/models/tabIcon_data.dart';
import 'package:th.ac.ru.uSmart/fitness_app/training/training_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/providers/authenprovider.dart';
import '../app_theme.dart';
import '../hotel_booking/hotel_app_theme.dart';
import '../login_page.dart';
import '../fitness_app/bottom_navigation_view/bottom_bar_view.dart';
import '../fitness_app/fitness_app_theme.dart';
import '../providers/mr30_provider.dart';
import 'mr30_list_screen.dart';

String? tokenMr30;

class Mr30Home2Screen extends StatefulWidget {
  @override
  _Mr30Home2ScreenState createState() => _Mr30Home2ScreenState();
}

class _Mr30Home2ScreenState extends State<Mr30Home2Screen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = Mr30ListScreen(animationController: animationController);
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
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          backgroundColor:
              isLightMode == true ? AppTheme.white : AppTheme.nearlyBlack,
          body: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                      ],
                    ),
                  ],
                );
              } else {
                return Stack(
                  children: <Widget>[
                    tabBody,
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 600));
    return true;
  }
}
