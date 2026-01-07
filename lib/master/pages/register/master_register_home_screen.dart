import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/fitness_app/models/tabIcon_data.dart';
import 'package:th.ac.ru.uSmart/master/pages/register/master_register_list_screen.dart';
import 'package:th.ac.ru.uSmart/master/providers/master_register_provider.dart';
import 'package:flutter/material.dart';
import '../../../fitness_app/fitness_app_theme.dart';
import '../../../providers/authenprovider.dart';

String? tokenRegis;

class MasterRegisterHomeScreen extends StatefulWidget {
  @override
  _MasterRegisterHomeScreenState createState() =>
      _MasterRegisterHomeScreenState();
}

class _MasterRegisterHomeScreenState extends State<MasterRegisterHomeScreen>
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
    tabBody =
        MasterRegisterListScreen(animationController: animationController);
    super.initState();

    Provider.of<AuthenProvider>(context, listen: false).getProfile();
    Provider.of<MasterRegisterProvider>(context, listen: false)
        .getAllRegister();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
