import 'package:get/get.dart';
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

class Mr30HomeScreen extends StatefulWidget {
  @override
  _Mr30HomeScreenState createState() => _Mr30HomeScreenState();
}

class _Mr30HomeScreenState extends State<Mr30HomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  _renderBg() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppTheme.nearlyWhite, // Change back arrow color to white
        ),
        title: Text(
          'มร.30',
          style: AppTheme.headline,
        ),
        centerTitle: true, // Centers the title
        backgroundColor:
            AppTheme.ru_dark_blue, // Background color of the AppBar
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.help,
              color: AppTheme.nearlyWhite,
            ),
            onPressed: () {
              Get.toNamed("/mr30help");
            },
          ),
        ],
      ),
      backgroundColor:
          isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
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
                    const SizedBox(),
                  ],
                ),
              ],
            );
          } else {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                _renderBg(),
                tabBody,
              ],
            );
          }
        },
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
