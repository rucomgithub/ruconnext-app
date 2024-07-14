import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/fitness_app/bottom_navigation_view/bottom_bar_view.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/models/tabIcon_data.dart';
import 'package:th.ac.ru.uSmart/home_screen.dart';
import 'package:th.ac.ru.uSmart/pages/flipcard_screen.dart';
import 'package:th.ac.ru.uSmart/providers/home_provider.dart';
import 'package:th.ac.ru.uSmart/ru_home_screen.dart';
import 'package:th.ac.ru.uSmart/screens/runewsScreen.dart';
import 'package:th.ac.ru.uSmart/today/ru_today_screen.dart';
import 'package:th.ac.ru.uSmart/today/today_home_screen.dart';

class RuBottomBar extends StatefulWidget {
  const RuBottomBar({super.key});

  @override
  State<RuBottomBar> createState() => _RuBottomBarState();
}

class _RuBottomBarState extends State<RuBottomBar>
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

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyHomePage();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //int id = Provider.of<HomeProvider>(context, listen: false).currentIndex;
    //tabIconsList[id].isSelected = true;
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                Provider.of<HomeProvider>(context, listen: false)
                    .setIndex(index);
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                Provider.of<HomeProvider>(context, listen: false)
                    .setIndex(index);
              });
            } else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                Provider.of<HomeProvider>(context, listen: false)
                    .setIndex(index);
              });
            } else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                Provider.of<HomeProvider>(context, listen: false)
                    .setIndex(index);
              });
            }
          },
        ),
      ],
    );
  }
}
