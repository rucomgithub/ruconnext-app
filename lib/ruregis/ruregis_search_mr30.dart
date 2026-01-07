import 'package:th.ac.ru.uSmart/fitness_app/models/tabIcon_data.dart';
import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../hotel_booking/hotel_app_theme.dart';
import '../fitness_app/fitness_app_theme.dart';

String? tokenMr30;

class RuregisSearchScreen extends StatefulWidget {
  @override
  _RuregisSearchScreenState createState() => _RuregisSearchScreenState();
}

class _RuregisSearchScreenState extends State<RuregisSearchScreen>
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
