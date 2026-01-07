import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/fitness_app/models/tabIcon_data.dart';
import 'package:th.ac.ru.uSmart/providers/authen_regis.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/ruregionApp/ruregioncart/register_region_list_screen.dart';
import '../../fitness_app/fitness_app_theme.dart';
import '../../providers/authenprovider.dart';
import '../../providers/register_provider.dart';

String? tokenRegis;

class RuRegionAppCartHomeScreen extends StatefulWidget {
  @override
  _RuRegionAppCartHomeScreenState createState() =>
      _RuRegionAppCartHomeScreenState();
}

class _RuRegionAppCartHomeScreenState extends State<RuRegionAppCartHomeScreen>
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
    tabBody = RuregionCartListScreen(animationController: animationController);
    super.initState();
    Provider.of<AuthenRuRegionAppProvider>(context, listen: false).getProfile();
    Provider.of<RegisterProvider>(context, listen: false).getAllRegister();
    getData();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
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
              print('registers : ${authen.profile.accessToken}');
              return Stack(
                children: <Widget>[
                  tabBody,
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 600));
    return true;
  }
}
