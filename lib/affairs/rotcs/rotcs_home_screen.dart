import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/affairs/rotcs/rotcs_list_screen.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/models/tabIcon_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:th.ac.ru.uSmart/login_page.dart';
import 'package:th.ac.ru.uSmart/providers/authenprovider.dart';
import 'package:th.ac.ru.uSmart/store/authen.dart';

String? tokenMr30;

class RotcsHomeScreen extends StatefulWidget {
  @override
  _RotcsHomeScreenState createState() => _RotcsHomeScreenState();
}

class _RotcsHomeScreenState extends State<RotcsHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  String? accessToken;

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
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        iconTheme: IconThemeData(
          color: AppTheme.nearlyWhite,
        ),
        title: Text(
          'นักศึกษาวิชาทหาร',
          style: TextStyle(
            fontSize: baseFontSize,
            fontFamily: AppTheme.ruFontKanit,
            color: AppTheme.nearlyWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.ru_dark_blue,
      ),
      backgroundColor:
          isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return accessToken != null ? tabBody : LoginPage();
          }
        },
      ),
    );
  }

  Future<bool> getData() async {
    accessToken = await AuthenStorage.getAccessToken();
    await Future<dynamic>.delayed(const Duration(milliseconds: 300));
    return true;
  }
}
