import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/models/tabIcon_data.dart';
import 'package:th.ac.ru.uSmart/fitness_app/training/training_screen.dart';
import 'package:th.ac.ru.uSmart/grade/my_grade_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login_page.dart';
import '../fitness_app/bottom_navigation_view/bottom_bar_view.dart';
import '../fitness_app/fitness_app_theme.dart';
import '../providers/authenprovider.dart';

String? tokenGrade;

class GradeAppHomeScreen extends StatefulWidget {
  @override
  _GradeAppHomeScreenState createState() => _GradeAppHomeScreenState();
}

class _GradeAppHomeScreenState extends State<GradeAppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyGradeScreen(animationController: animationController);
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
              //print('register : ${authen.profile.accessToken}');
              return Stack(
                fit: StackFit.expand,
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
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
