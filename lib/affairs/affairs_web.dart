import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/widget/ru_wallpaper.dart';
import 'package:th.ac.ru.uSmart/widget/web_page.dart';

class AffairsWeb extends StatefulWidget {
  @override
  _AffairsWebState createState() => _AffairsWebState();
}

class _AffairsWebState extends State<AffairsWeb> with TickerProviderStateMixin {
  AnimationController? animationController;
  Map<String, dynamic> web = {};

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();

    web = Get.arguments;
  }

  Future<bool> getData() async {
    print('call getData');
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
          'เว็บกองกิจการนักศึกษา',
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
      body: Stack(
        children: <Widget>[
          RuWallpaper(),
          WebPage(),
        ],
      ),
    );
  }
}
