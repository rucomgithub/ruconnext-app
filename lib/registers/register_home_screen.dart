import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/models/tabIcon_data.dart';
import 'package:th.ac.ru.uSmart/providers/mr30_provider.dart';
import 'package:th.ac.ru.uSmart/registers/register_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/widget/ru_bottom_bar.dart';
import '../login_page.dart';
import '../fitness_app/fitness_app_theme.dart';
import '../providers/authenprovider.dart';
import '../providers/register_provider.dart';

String? tokenRegis;

class RegisterHomeScreen extends StatefulWidget {
  @override
  _RegisterHomeScreenState createState() => _RegisterHomeScreenState();
}

class _RegisterHomeScreenState extends State<RegisterHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    tabBody = RegisterListScreen(animationController: animationController);

    super.initState();
    Provider.of<AuthenProvider>(context, listen: false).getProfile();
    Provider.of<RegisterProvider>(context, listen: false).getAllRegister();
    Provider.of<RegisterProvider>(context, listen: false).getRegisterAll();
    Provider.of<MR30Provider>(context, listen: false).getYearSemesterLatest();
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
      color: AppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              //print('register : ${authen.profile.accessToken}');
              return authen.profile.accessToken != null
                  ? Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        tabBody,
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
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
