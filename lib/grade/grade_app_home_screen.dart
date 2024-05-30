import 'package:provider/provider.dart';
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
              print('grade : ${authen.profile.accessToken}');
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
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    tokenGrade = prefs.getString('profile');
    print(tokenGrade);
    await Future<dynamic>.delayed(const Duration(milliseconds: 600));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0 || index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyGradeScreen(animationController: animationController);
                });
              });
            } else if (index == 1 || index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      TrainingScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
