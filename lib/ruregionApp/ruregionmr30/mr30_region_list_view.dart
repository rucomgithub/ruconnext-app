import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/model/ruregion_mr30_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregion_check_cart.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_mr30_provider.dart';

import '../../fitness_app/fitness_app_theme.dart';

class RuregionMr30ListView extends StatefulWidget {
  const RuregionMr30ListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _RuregionMr30ListViewState createState() => _RuregionMr30ListViewState();
}

class _RuregionMr30ListViewState extends State<RuregionMr30ListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();

    Provider.of<RUREGISMR30Provider>(context, listen: false)
        .fetchMR30RUREGIONAPP();
    print('get data');
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    getData();
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  void _onLoading() async {
    getData();
    _refreshController.loadComplete();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 600));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var err = context.watch<RUREGISMR30Provider>().error;
    var mr30ruregion = context.watch<RUREGISMR30Provider>().mr30filterApp;
    var loading = context.watch<RUREGISMR30Provider>().isLoadingMr30;

    if (loading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(err),
          const CircularProgressIndicator(),
        ],
      );
    } else {
      return err != ''
          ? Text(err)
          : AnimatedBuilder(
              animation: widget.mainScreenAnimationController!,
              builder: (BuildContext context, Widget? child) {
                return FadeTransition(
                  opacity: widget.mainScreenAnimation!,
                  child: Transform(
                    transform: Matrix4.translationValues(0.0,
                        30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: false,
                          header: const WaterDropHeader(),
                          footer: CustomFooter(
                            builder: (BuildContext context, LoadStatus? mode) {
                              Widget body;
                              if (mode == LoadStatus.idle) {
                                body = const Text("กำลังโหลดข้อมูล...");
                              } else if (mode == LoadStatus.loading) {
                                body = const CircularProgressIndicator();
                              } else if (mode == LoadStatus.failed) {
                                body = const Text(
                                    "ไม่สามารถโหลดข้อมูลได้ กรุณาลองอีกครั้ง");
                              } else if (mode == LoadStatus.canLoading) {
                                body = const Text("release to load more");
                              } else {
                                body = const Text("ไม่พบข้อมูลแล้ว...");
                              }
                              return SizedBox(
                                height: 55.0,
                                child: Center(child: body),
                              );
                            },
                          ),
                          controller: _refreshController,
                          onRefresh: _onRefresh,
                          onLoading: _onLoading,
                          // 👇 ส่วนนี้คือจุดที่เพิ่มการตรวจสอบข้อมูล
                          child: (mr30ruregion.results == null ||
                                  mr30ruregion.results!.isEmpty)
                              ? Center(
                                  child: Text(
                                    'นักศึกษาไม่สามารถลงทะเบียนเรียนได้',
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: 16,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                )
                              : ListView(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 16, bottom: 16),
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  children: List<Widget>.generate(
                                    mr30ruregion.results!.length > 20
                                        ? 20
                                        : mr30ruregion.results!.length,
                                    (int index) {
                                      final int count =
                                          mr30ruregion.results!.length > 20
                                              ? 20
                                              : mr30ruregion.results!.length;
                                      final Animation<double> animation =
                                          Tween<double>(begin: 0.0, end: 1.0)
                                              .animate(
                                        CurvedAnimation(
                                          parent: animationController!,
                                          curve: Interval(
                                              (1 / count) * index, 1.0,
                                              curve: Curves.fastOutSlowIn),
                                        ),
                                      );
                                      animationController?.forward();
                                      return Mr30ItemView(
                                        index: index,
                                        course: mr30ruregion.results
                                            ?.elementAt(index),
                                        animation: animation,
                                        animationController:
                                            animationController!,
                                      );
                                    },
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
    }
  }
}

Icon IconFavorite(bool favorite) {
  return favorite
      ? Icon(
          Icons.add_circle_outline_rounded,
          color: Color.fromARGB(255, 143, 117, 0),
          size: 25,
        )
      : Icon(
          Icons.add_box,
          color: Color.fromARGB(255, 19, 19, 19),
          size: 25,
        );
}

class Mr30ItemView extends StatelessWidget {
  const Mr30ItemView({
    Key? key,
    this.index,
    this.course,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final int? index;
  final ResultsMr30? course;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    var ruregionprov = context.watch<RUREGISMR30Provider>();
    var regionProv = context.watch<RuregionCheckCartProvider>();

    void addToCart(ResultsMr30 course) {
      print('add to cart $course');
      ruregionprov.addRuregisAppMR30(context, course);
      regionProv.getCalPayRegionApp();
    }

    EdgeInsets listItemPadding =
        const EdgeInsets.only(left: 0, bottom: 4, top: 4, right: 0);
    Color favColor = AppTheme.ru_text_ocean_blue;

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 แสดงชื่อภาคเรียนแค่ครั้งเดียว (ด้านบนสุด)
            if (index == 0)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 0, bottom: 8),
                child: Text(
                  'ปีภาค ${course?.rEGISSEMESTER}/${course?.rEGISYEAR}',
                  style: TextStyle(
                    fontFamily: AppTheme.ruFontKanit,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ),

            Padding(
              padding: listItemPadding,
              child: FadeTransition(
                opacity: animation!,
                child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 50 * (1.0 - animation!.value), 0.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: FitnessAppTheme.nearlyWhite
                              .withValues(alpha: 0.9),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color:
                                  FitnessAppTheme.grey.withValues(alpha: 0.4),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor:
                                AppTheme.dark_grey.withValues(alpha: 0.2),
                            onTap: () {
                              addToCart(course!);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 16, right: 8),
                                  child: Text(
                                    '${course?.cOURSENO} (${course?.cREDIT}) ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: 16,
                                      color: favColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${course?.eXAMDATE}   ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '${course?.eXAMPERIOD} ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 14,
                                          color: AppTheme.ru_text_grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 244, 237, 237)
                                            .withValues(alpha: 0.9),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8.0)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: FitnessAppTheme.grey
                                            .withValues(alpha: 0.4),
                                        offset: const Offset(1.1, 1.1),
                                        blurRadius: 10.0,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: IconFavorite(true),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
