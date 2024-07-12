import 'package:get/get.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';

import 'package:th.ac.ru.uSmart/model/mr30_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregion_mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_mr30_provider.dart';

import '../../main.dart';
import '../../model/ruregion_mr30_model.dart';
import '../../providers/grade_provider.dart';
import '../../fitness_app/models/grade_list_data.dart';
import '../../fitness_app/ui_view/gradeyear_screen.dart';
import '../../providers/mr30_provider.dart';
import '../../providers/ondemand_provider.dart';
import '../../registers/register_list_view.dart';

class RuregisFavoriteListView extends StatefulWidget {
  const RuregisFavoriteListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _RuregisFavoriteListViewState createState() =>
      _RuregisFavoriteListViewState();
}

class _RuregisFavoriteListViewState extends State<RuregisFavoriteListView>
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
            child: Container(
              height: mr30.length > 0 ? 198 : 10,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: mr30.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = mr30.length > 10 ? 10 : mr30.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();
                  return Mr30ItemView(
                    mr30Data: mr30[index],
                    animation: animation,
                    animationController: animationController!,
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
    //var ondemand = context.read<OndemandProvider>();
    var ruregionprov = context.watch<RuregionProvider>();
    void removeToCart(c) {
      print('remove $c');
      ruregionprov.removeRuregisPref(c);
    }

    var mr30prov = Provider.of<MR30Provider>(context, listen: false);
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: InkWell(
              highlightColor: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              onTap: () {
                // Get.toNamed('/ondemand', arguments: {
                //   'course': '${mr30Data!.cOURSENO}',
                //   'semester': '${mr30Data!.rEGISSEMESTER.toString()}',
                //   'year': '${mr30Data!.rEGISYEAR.toString().substring(2, 4)}'
                // });
                // ondemand.ondemand.rECORD.detail.isEmpty
                // print(ondemand.error);
              },
              child: SizedBox(
                width: 130,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 32, left: 8, right: 8, bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: HexColor('#000000').withOpacity(0.6),
                                offset: const Offset(1.1, 4.0),
                                blurRadius: 8.0),
                          ],
                          gradient: LinearGradient(
                            colors: <HexColor>[
                              HexColor('#1489EB'),
                              HexColor('#1483EB'),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            topLeft: Radius.circular(48.0),
                            topRight: Radius.circular(8.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 54, left: 16, right: 16, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${mr30Data!.cOURSENO!.toString()}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 0.2,
                                  color: AppTheme.white,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: SingleChildScrollView(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 100.0,
                                          width: 80.0,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${mr30Data?.eXAMDATE?.toString()} (${mr30Data!.eXAMPERIOD!})',
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10,
                                                  letterSpacing: 0.2,
                                                  color: AppTheme.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              mr30Data!.cREDIT.toString() != '0'
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          mr30Data!.cREDIT.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.ruFontKanit,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            letterSpacing: 0.2,
                                            color: AppTheme.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, bottom: 0),
                                          child: Text(
                                            'หน่วยกิต',
                                            style: TextStyle(
                                              fontFamily: AppTheme.ruFontKanit,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              letterSpacing: 0.2,
                                              color: AppTheme.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        color: AppTheme.nearlyWhite,
                                        shape: BoxShape.circle,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: AppTheme.nearlyBlack
                                                  .withOpacity(0.4),
                                              offset: Offset(8.0, 8.0),
                                              blurRadius: 8.0),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Icon(
                                          Icons.add,
                                          color: HexColor('#FFB295'),
                                          size: 24,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 30,
                      right: 10,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppTheme.nearlyWhite.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 30,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          print('tap ${mr30Data!.cOURSENO}');
                          // Your onTap logic here

                          removeToCart(mr30Data!.cOURSENO);
                          // You can also call a function or navigate to another screen
                        },
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.close,
                            color: HexColor('#FFB295'),
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 35,
                      right: 80,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: InkWell(
                          onTap: () {
                            // mr30prov.addMR30(mr30Data!);
                          },
                          // child: IconFavorite(mr30Data!.favorite!),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 70,
                      left: 25,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Text(
                          '${mr30Data!.rEGISSEMESTER.toString()}/${mr30Data!.rEGISYEAR.toString()}',
                          style: TextStyle(
                            fontFamily: AppTheme.ruFontKanit,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: AppTheme.white,
                          ),
                        ),
                      ),
                    )
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
