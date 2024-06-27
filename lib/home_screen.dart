import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/pages/home_image_slider.dart';
import 'package:th.ac.ru.uSmart/providers/grade_provider.dart';
import 'package:th.ac.ru.uSmart/providers/mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/register_provider.dart';
import 'package:th.ac.ru.uSmart/providers/student_provider.dart';
import 'package:th.ac.ru.uSmart/services/studentservice.dart';
import 'package:th.ac.ru.uSmart/today/today_home_screen.dart';
import 'package:th.ac.ru.uSmart/today/today_list_view.dart';
import 'package:th.ac.ru.uSmart/utils/custom_functions.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'package:flutter/material.dart';
import 'model/homelist.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/schedule_provider.dart';
import 'schedule/schedule_home_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String? token;

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<HomeList> homeList = HomeList.homeList;
  AnimationController? animationController;
  bool multiple = true;

  @override
  void initState() {
    Provider.of<GradeProvider>(context, listen: false).getAllGrade();
    Provider.of<RegisterProvider>(context, listen: false).getAllRegister();
    Provider.of<RegisterProvider>(context, listen: false).getRegisterAll();

    Provider.of<RegisterProvider>(context, listen: false).getAllRegisterYear();
    Provider.of<RegisterProvider>(context, listen: false).getAllMr30Catalog();

    //Provider.of<RegisterProvider>(context, listen: false).getMR30Register();

    // Provider.of<StudentProvider>(context, listen: false).getMr30Catalog();

    Provider.of<MR30Provider>(context, listen: false).getAllMR30();
    Provider.of<MR30Provider>(context, listen: false).getAllMR30Year();

    Provider.of<ScheduleProvider>(context, listen: false).fetchSchedules();

    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    super.initState();
  }

  Future<bool> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('profile');
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<MR30Provider>().getHaveToday();
    context.read<MR30Provider>().filterTimeCourseStudy();
    // context.read<RegisterProvider>().getHaveTodayRegister();
    var brightness = MediaQuery.of(context).platformBrightness;
    var mr30 = context.watch<MR30Provider>();
    // var mr30catalogs = context.watch<StudentProvider>();
    var scheduleProv = context.watch<ScheduleProvider>();
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            final Animation<double> animationForImage =
                Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animationController!,
                curve: Interval((1 / 7) * 2, 1.0, curve: Curves.fastOutSlowIn),
              ),
            );
            late final AnimationController _controller = AnimationController(
              duration: const Duration(seconds: 3),
              vsync: this,
            )..repeat(reverse: true);
            late final Animation<double> _animation = CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOutCubic,
            );
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(color: AppTheme.ru_dark_blue, child: appBar()),
                  // Text('$')
                  FadeTransition(
                      opacity: animationForImage, child: homeImageSlider()),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      children: [
                        Icon(Icons.list,
                            color: Color.fromARGB(255, 15, 0, 84), size: 18.0),
                        Text(
                          'กิจกรรมวันนี้',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: AppTheme.ruFontKanit,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),

                  ListView.builder(
                    padding: const EdgeInsets.all(1),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: mr30.havetodayNow.length > 0 ? 1 : 0,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: ListTile(
                            title: Text(
                              '${mr30.havetodayNow[index].courseNo}',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            trailing: Text(
                                '${StringTimeStudy((mr30.havetodayNow[index].timePeriod).toString())}'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TodayHomeScreen()),
                              );
                            },
                            leading: Icon(Icons.bookmarks_rounded),
                          ),
                        ),
                      );
                    },
                  ),

                  //schedule
                  ListView.builder(
                    padding: const EdgeInsets.all(1),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: scheduleProv.schedules.length > 0 ? 1 : 0,
                    itemBuilder: (context, index) {
                      return scheduleProv.isLoading
                          ? Text('')
                          : Card(
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: ListTile(
                                  title: Text(
                                    '${formatDate(scheduleProv.schedules[0].startDate)} - ${formatDate(scheduleProv.schedules[0].endDate)}',
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      color: AppTheme.ru_dark_blue,
                                      fontSize: 13,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${scheduleProv.schedules[0].eventName}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: AppTheme.ruFontKanit,
                                      color: AppTheme.ru_text_grey,
                                    ),
                                  ),
                                  // trailing: Text(
                                  //   ' ${commingTime(DateTime.parse(scheduleProv.schedules[0].startDate), DateTime.now(), DateTime.parse(scheduleProv.schedules[0].endDate))}',
                                  //   style: TextStyle(
                                  //       color: Colors.redAccent,
                                  //       fontSize: 12,
                                  //       fontStyle: FontStyle.italic),
                                  // ),
                                  trailing: BlinkText(
                                      '${commingTimeNewLine(DateTime.parse(scheduleProv.schedules[0].startDate), DateTime.now(), DateTime.parse(scheduleProv.schedules[0].endDate))}',
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontStyle: FontStyle.italic),
                                      beginColor: Colors.redAccent,
                                      endColor: Colors.red
                                          .shade50), //                             trailing: BlinkText(

                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ScheduleHomeScreen()),
                                    );
                                  },
                                  leading: Icon(
                                    Icons.timer,
                                    // color: Colors.lightBlue,
                                  ),
                                ),
                              ),
                            );
                    },
                  ),

                  Expanded(
                    child: FutureBuilder<bool>(
                      future: getData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        } else {
                          return
                              //   token == null ?
                              // LoginPage():

                              GridView(
                            padding: const EdgeInsets.only(
                                top: 0, left: 12, right: 12),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: List<Widget>.generate(
                              homeList.length,
                              (int index) {
                                final int count = homeList.length;
                                final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                    parent: animationController!,
                                    curve: Interval((1 / count) * index, 1.0,
                                        curve: Curves.fastOutSlowIn),
                                  ),
                                );
                                animationController?.forward();
                                return HomeListView(
                                  animation: animation,
                                  animationController: animationController,
                                  listData: homeList[index],
                                  callBack: () {
                                    Navigator.push<dynamic>(
                                      context,
                                      MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) =>
                                            homeList[index].navigateScreen!,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: multiple ? 4 : 3,
                              mainAxisSpacing: 6.0,
                              crossAxisSpacing: 6.0,
                              childAspectRatio: 1.0,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget appBar() {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'RU ConneXt',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: AppTheme.ruFontKanit,
                    color: AppTheme.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: AppTheme.ru_dark_blue,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    multiple ? Icons.dashboard : Icons.view_agenda,
                    color: AppTheme.white,
                  ),
                  onTap: () {
                    setState(() {
                      multiple = !multiple;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeListView extends StatelessWidget {
  const HomeListView(
      {Key? key,
      this.listData,
      this.callBack,
      this.animationController,
      this.animation})
      : super(key: key);

  final HomeList? listData;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.asset(
                        listData!.imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),

                    // Positioned.fill(
                    //   child: Icon(listData!.iconsData,
                    //               size: 120,
                    //               color: listData!.color,
                    //               ),
                    // ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        onTap: callBack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
