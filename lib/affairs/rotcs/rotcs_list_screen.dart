import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/affairs/rotcs/rotcs_extend_list_view.dart';
import 'package:th.ac.ru.uSmart/affairs/rotcs/rotcs_register_list_view.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/mr30/titlenone_view.dart';
import 'package:th.ac.ru.uSmart/providers/authenprovider.dart';
import 'package:th.ac.ru.uSmart/widget/head_logo_view.dart';
import 'package:th.ac.ru.uSmart/widget/info_view.dart';
import 'package:th.ac.ru.uSmart/widget/ru_wallpaper.dart';

class RotcsListScreen extends StatefulWidget {
  const RotcsListScreen({Key? key, this.animationController, this.token})
      : super(key: key);

  final AnimationController? animationController;
  final String? token;
  @override
  _RotcsListScreenState createState() => _RotcsListScreenState();
}

class _RotcsListScreenState extends State<RotcsListScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    Provider.of<AuthenProvider>(context, listen: false).getProfile();
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();
    super.initState();
  }

  void addAllListData() {
    const int count = 9;

    listViews.add(
      HeadLogoView(
          logo: 'assets/rotcs/rotcs_2.jpg',
          caption: 'งานนักศึกษาวิชาทหาร',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController!,
                  curve: Interval((1 / count) * 8, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController!),
    );

    // listViews.add(
    //   InfoButtonView(
    //       callback: () {
    //         Get.toNamed('/webpage', arguments: {
    //           'title': 'ระบบสารสนเทศด้านกิจการทหาร',
    //           'url': 'https://fis.ru.ac.th/rotcs/index.php?r=site/protected',
    //         });
    //       },
    //       imagePath: 'assets/fitness_app/AF1.png',
    //       caption: 'เชื่อมต่อระบบสารสนเทศด้านกิจการทหาร',
    //       animation: Tween<double>(begin: 0.0, end: 1.0).animate(
    //           CurvedAnimation(
    //               parent: topBarAnimation!,
    //               curve: Interval((1 / count) * 2, 1.0,
    //                   curve: Curves.fastOutSlowIn))),
    //       animationController: widget.animationController!),
    // );

    listViews.add(
      TitleNoneView(
        titleTxt: 'การฝึกเรียนวิชาหทาร',
        subTxt: 'รายละเอียดรายการการฝึกเรียนวิชาหทาร.',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: topBarAnimation!,
            curve:
                Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      RotcsRegisterListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: Interval((1 / count) * 8, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );

    listViews.add(
      TitleNoneView(
        titleTxt: 'การผ่อนผันการเกณฑ์ทหาร',
        subTxt: 'รายละเอียดรายการผ่อนผันการเกณฑ์ทหาร.',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      RotcsExtendListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: Interval((1 / count) * 8, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );

    listViews.add(
      InfoView(
          caption:
              'ข้อมูลนักศึกษาวิชาทหาร จะทำการอัปเดตทุกวันที่ 1 ของเดือน โดยกองกิจการนักศึกษา',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController!,
                  curve: Interval((1 / count) * 8, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController!),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            RuWallpaper(),
            getMainListViewUI(),
            getAppBarUI(),
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: 16,
              bottom: 16 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: topBarAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          Get.toNamed('/webpage', arguments: {
                            'title': 'ระบบสารสนเทศด้านกิจการทหาร',
                            'url':
                                'https://fis.ru.ac.th/rotcs/index.php?r=site/protected',
                          });
                        },
                        child: Card(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppTheme.ru_dark_blue.withValues(alpha: 0.4),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(1.1, 4.4),
                                  ),
                                ],
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/fitness_app/AF1.png'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(16)),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      colors: [
                                        AppTheme.nearlyWhite.withValues(alpha: 0.8),
                                        Colors.transparent
                                      ])),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
