import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/model/mr30_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../fitness_app/fitness_app_theme.dart';
import '../providers/mr30_provider.dart';

class Mr30ListView extends StatefulWidget {
  const Mr30ListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _Mr30ListViewState createState() => _Mr30ListViewState();
}

class _Mr30ListViewState extends State<Mr30ListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<String> areaListData = <String>[
    'assets/fitness_app/area1.png',
    'assets/fitness_app/area2.png',
    'assets/fitness_app/area3.png',
    'assets/fitness_app/area1.png',
  ];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  // Pagination state
  int _displayedItemCount = 20;
  static const int _itemsPerPage = 20;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    // Reset to show first 20 items
    setState(() {
      _displayedItemCount = _itemsPerPage;
    });
    await getData();
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  void _onLoading() async {
    // Load more items
    await Future.delayed(const Duration(milliseconds: 500));

    var mr30 = Provider.of<MR30Provider>(context, listen: false);
    int totalItems = mr30.mr30filter.rECORD?.length ?? 0;

    setState(() {
      if (_displayedItemCount < totalItems) {
        _displayedItemCount = (_displayedItemCount + _itemsPerPage).clamp(0, totalItems);
        _refreshController.loadComplete();
      } else {
        _refreshController.loadNoData();
      }
    });
  }

  Future<bool> getData() async {
    Provider.of<MR30Provider>(context, listen: false).getAllMR30Year();
    Provider.of<MR30Provider>(context, listen: false).getAllMR30();
    await Future<dynamic>.delayed(const Duration(milliseconds: 600));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var mr30 = context.watch<MR30Provider>();
    if (mr30.isLoading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
        ],
      );
    } else {
      return AnimatedBuilder(
        animation: widget.mainScreenAnimationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: widget.mainScreenAnimation!,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: const WaterDropHeader(),
                    footer: CustomFooter(
                      builder: (BuildContext context, LoadStatus? mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_upward_rounded,
                                size: 16,
                                color: AppTheme.ru_dark_blue.withValues(alpha: 0.5),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "ดึงขึ้นเพื่อโหลดเพิ่มเติม",
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontSize: 14,
                                  color: AppTheme.dark_grey,
                                ),
                              ),
                            ],
                          );
                        } else if (mode == LoadStatus.loading) {
                          body = Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      AppTheme.ru_dark_blue),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "กำลังโหลด...",
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontSize: 14,
                                  color: AppTheme.ru_dark_blue,
                                ),
                              ),
                            ],
                          );
                        } else if (mode == LoadStatus.failed) {
                          body = Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline_rounded,
                                size: 18,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "โหลดไม่สำเร็จ แตะเพื่อลองใหม่",
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          );
                        } else if (mode == LoadStatus.canLoading) {
                          body = Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_downward_rounded,
                                size: 16,
                                color: AppTheme.ru_yellow,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "ปล่อยเพื่อโหลดเพิ่ม",
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontSize: 14,
                                  color: AppTheme.ru_dark_blue,
                                ),
                              ),
                            ],
                          );
                        } else {
                          body = Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle_outline_rounded,
                                size: 18,
                                color: AppTheme.ru_dark_blue.withValues(alpha: 0.5),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "แสดงครบทั้งหมดแล้ว",
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontSize: 14,
                                  color: AppTheme.dark_grey,
                                ),
                              ),
                            ],
                          );
                        }
                        return Container(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: ListView(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 16),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: List<Widget>.generate(
                        _displayedItemCount.clamp(
                            0, mr30.mr30filter.rECORD?.length ?? 0),
                        (int index) {
                          final int count = _displayedItemCount;
                          final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn),
                            ),
                          );
                          animationController?.forward();
                          return Mr30ItemView(
                            index: index,
                            course: mr30.mr30filter.rECORD?.elementAt(index),
                            animation: animation,
                            animationController: animationController!,
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
          Icons.star,
          color: Color.fromARGB(255, 255, 208, 0),
          size: 25,
        )
      : Icon(
          Icons.star_border_outlined,
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
  final RECORD? course;
  final AnimationController? animationController;
  final Animation<double>? animation;

  Color _getDayColor(String? dayName) {
    switch (dayName) {
      case 'M':
        return Color(0xFFFFC107); // Amber
      case 'TU':
        return Color(0xFFE91E63); // Pink
      case 'W':
        return Color(0xFF4CAF50); // Green
      case 'TH':
        return Color(0xFFFF9800); // Orange
      case 'F':
        return Color(0xFF2196F3); // Blue
      case 'SAT':
        return Color(0xFF9C27B0); // Purple
      case 'SU':
        return Color(0xFFF44336); // Red
      default:
        return AppTheme.dark_grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    var mr30prov = Provider.of<MR30Provider>(context, listen: false);
    Color dayColor = _getDayColor(course?.dayNameS);
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 6, bottom: 6),
          child: FadeTransition(
            opacity: animation!,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 50 * (1.0 - animation!.value), 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.nearlyWhite,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.ru_dark_blue.withValues(alpha: 0.12),
                        offset: const Offset(0, 4),
                        blurRadius: 12.0,
                        spreadRadius: 0),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.0),
                    splashColor: AppTheme.ru_dark_blue.withValues(alpha: 0.1),
                    onTap: () {
                      mr30prov.addMR30(course!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header: Course No + Favorite
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppTheme.ru_dark_blue
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      Icons.school_rounded,
                                      color: AppTheme.ru_dark_blue,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    '${course?.courseNo}',
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.ru_dark_blue,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  course!.favorite!
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: course!.favorite!
                                      ? AppTheme.ru_yellow
                                      : AppTheme.dark_grey,
                                  size: 28,
                                ),
                                onPressed: () {
                                  mr30prov.addMR30(course!);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Day & Time
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: dayColor.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: dayColor.withValues(alpha: 0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.calendar_today_rounded,
                                      color: dayColor,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${course?.dayNameS}',
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: dayColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color:
                                      AppTheme.dark_grey.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.access_time_rounded,
                                      color: AppTheme.dark_grey,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${course?.timePeriod}',
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: 13,
                                        color: AppTheme.dark_grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Bottom Info
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppTheme.ru_yellow
                                      .withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${course?.courseSemester}/${course?.courseYear}',
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.ru_dark_blue,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppTheme.ru_dark_blue
                                      .withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${course?.courseExamdate}',
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 12,
                                    color: AppTheme.dark_grey,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color:
                                      AppTheme.ru_yellow.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppTheme.ru_yellow,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${course?.courseCredit}',
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.ru_dark_blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
