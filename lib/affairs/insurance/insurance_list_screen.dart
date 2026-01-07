import 'package:th.ac.ru.uSmart/affairs/insurance/insurance_info_view.dart';
import 'package:th.ac.ru.uSmart/affairs/insurance/insurance_list_view.dart';
import 'package:th.ac.ru.uSmart/affairs/insurance/insurance_logo_view.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/mr30/titlenone_view.dart';
import 'package:th.ac.ru.uSmart/widget/Rubar.dart';
import 'package:th.ac.ru.uSmart/widget/ru_wallpaper.dart';

class InsuranceListScreen extends StatefulWidget {
  const InsuranceListScreen({Key? key, this.animationController})
      : super(key: key);

  final AnimationController? animationController;
  @override
  _InsuranceListScreenState createState() => _InsuranceListScreenState();
}

class _InsuranceListScreenState extends State<InsuranceListScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();
    super.initState();
  }

  void addAllListData() {
    const int count = 9;
    //var mr30 = context.watch<MR30Provider>().mr30record;
    listViews.add(
      InsuranceLogoView(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController!,
                  curve: Interval((1 / count) * 8, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController!),
    );
    listViews.add(
      TitleNoneView(
        titleTxt: 'กรมธรรม์ประกันภัยของฉัน',
        subTxt:
            'รายละเอียดรายการกรมธรรม์ประกันภัยที่เกี่ยวกับกิจกรรมต่างๆของนักศึกษา',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      InsuraceListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: Interval((1 / count) * 8, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );

    listViews.add(
      InsuranceInfoView(
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
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            RuWallpaper(),
            getMainListViewUI(),
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
}
