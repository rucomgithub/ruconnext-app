import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/models/tabIcon_data.dart';
import 'package:th.ac.ru.uSmart/login_page.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/master/pages/master_profile_list.dart';
import 'package:th.ac.ru.uSmart/providers/authenprovider.dart';

class MasterProfileScreen extends StatefulWidget {
  @override
  _MasterProfileScreenState createState() => _MasterProfileScreenState();
}

class _MasterProfileScreenState extends State<MasterProfileScreen>
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

    tabBody = MasterProfileList(animationController: animationController);
    super.initState();
    Provider.of<AuthenProvider>(context, listen: false).getProfile();
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
              //print('grade : ${authen.profile.accessToken}');
              return (authen.profile.accessToken != null)
                  ? Stack(
                      children: <Widget>[
                        tabBody,
                        //  bottomBar(),
                      ],
                    )
                  : LoginPage();
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
