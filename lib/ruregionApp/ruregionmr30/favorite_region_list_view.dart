import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_mr30_provider.dart';

import '../../model/ruregion_mr30_model.dart';
import '../../fitness_app/models/grade_list_data.dart';
import '../../providers/mr30_provider.dart';

class RuregionFavoriteListView extends StatefulWidget {
  const RuregionFavoriteListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _RuregionFavoriteListViewState createState() =>
      _RuregionFavoriteListViewState();
}

class _RuregionFavoriteListViewState extends State<RuregionFavoriteListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<GradeListData> gradeListData = GradeListData.tabIconsList;

  @override
  void initState() {
    Provider.of<MR30Provider>(context, listen: false).getRecordMr30();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 600));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mr30 = context.watch<RUREGISMR30Provider>().mr30ruregionrec;

    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: SizedBox(
              height: 60, // สูงพอดี 1-2 บรรทัด
              child: mr30.isEmpty
                  ? Center(
                      child: Text(
                        'กรุณาค้นหาและเลือกวิชาลงตะกร้า ',
                        style: TextStyle(
                          fontFamily: AppTheme.ruFontKanit,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: mr30.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Animation<double> animation =
                            Tween<double>(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                    parent: animationController!,
                                    curve: Interval(
                                        (1 / mr30.length) * index, 1.0,
                                        curve: Curves.fastOutSlowIn)));
                        animationController?.forward();
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Mr30ItemView(
                            mr30Data: mr30[index],
                            animation: animation,
                            animationController: animationController!,
                          ),
                        );
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}

class Mr30ItemView extends StatelessWidget {
  const Mr30ItemView(
      {Key? key, this.mr30Data, this.animationController, this.animation})
      : super(key: key);

  final ResultsMr30? mr30Data;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    var ruregionprov = context.watch<RUREGISMR30Provider>();

    void removeToCart(String? c) {
      if (c != null) {
        ruregionprov.removeRuregionPref(c);
      }
    }

    if (mr30Data == null) {
      return SizedBox.shrink(); // ถ้า null ไม่แสดงอะไร
    }

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                50 * (1.0 - animation!.value), 0.0, 0.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 214, 234, 251),
                    HexColor("#65ADFF")
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.2), // เงาอ่อน
                    offset: Offset(0, 4),
                    blurRadius: 8,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${mr30Data!.cOURSENO} (${mr30Data!.cREDIT})',
                    style: TextStyle(
                        fontFamily: AppTheme.ruFontKanit,
                        fontSize: 14,
                        color: AppTheme.nearlyBlack,
                        fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      removeToCart(mr30Data!.cOURSENO);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Icon(Icons.close,
                          color: Color.fromARGB(179, 238, 18, 18), size: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
