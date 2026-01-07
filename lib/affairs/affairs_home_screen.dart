import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/affairs/affairs_list_view.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/model/affairs_list_data.dart';
import 'package:th.ac.ru.uSmart/providers/authenprovider.dart';
import 'package:th.ac.ru.uSmart/providers/insurance_provider.dart';
import 'package:th.ac.ru.uSmart/providers/rotcs_provider.dart';
import 'package:th.ac.ru.uSmart/providers/sch_provider.dart';
import 'package:th.ac.ru.uSmart/ruconnext_app_theme.dart';
import 'package:th.ac.ru.uSmart/widget/ru_wallpaper.dart';

class AffairsHomeScreen extends StatefulWidget {
  @override
  _AffairsHomeScreenState createState() => _AffairsHomeScreenState();
}

class _AffairsHomeScreenState extends State<AffairsHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<AffairsListData> affairsList = AffairsListData.affairsList;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {
    print('profile affairs');
    Provider.of<AuthenProvider>(context, listen: false).getProfile();
    Provider.of<InsuranceProvider>(context, listen: false).getInsuracneAll();
    Provider.of<RotcsProvider>(context, listen: false).getAllRegister();
    Provider.of<RotcsProvider>(context, listen: false).getAllExtend();
    Provider.of<SchProvider>(context, listen: false).getScholarShip();

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
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
          'กองกิจการนักศึกษา',
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
          getListUI(),
        ],
      ),
    );
  }

  Widget getListUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        var authen = context.watch<AuthenProvider>();
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            padding: EdgeInsets.only(
              top: 16,
              bottom: 16 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: affairsList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              final int count =
                  affairsList.length > 10 ? 10 : affairsList.length;
              final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animationController!,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn)));
              animationController?.forward();

              return AffairsListView(
                callback: () {
                  if (affairsList[index].url == "") {
                    Get.toNamed(affairsList[index].navigateScreen);
                  } else {
                    Get.toNamed('/webpage', arguments: {
                      'title': affairsList[index].titleTxt,
                      'url': affairsList[index].url +
                          authen.profile.accessToken.toString(),
                    });
                  }
                },
                affairsData: affairsList[index],
                animation: animation,
                animationController: animationController!,
              );
            },
          );
        }
      },
    );
  }

}
