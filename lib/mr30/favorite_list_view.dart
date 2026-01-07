import 'package:get/get.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:th.ac.ru.uSmart/model/mr30_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../fitness_app/models/grade_list_data.dart';
import '../providers/mr30_provider.dart';
import '../registers/register_list_view.dart';

class FavoriteListView extends StatefulWidget {
  const FavoriteListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _FavoriteListViewState createState() => _FavoriteListViewState();
}

class _FavoriteListViewState extends State<FavoriteListView>
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
    var mr30 = context.watch<MR30Provider>().mr30record;

    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: Container(
              height: mr30.length > 0 ? 240 : 10,
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

  final RECORD? mr30Data;
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
    Color dayColor = _getDayColor(mr30Data?.dayNameS);

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 12, bottom: 8, top: 8),
              child: Container(
                width: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.ru_dark_blue,
                      AppTheme.ru_dark_blue.withValues(alpha: 0.85),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppTheme.ru_dark_blue.withValues(alpha: 0.3),
                      offset: const Offset(0, 4),
                      blurRadius: 12.0,
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.0),
                    splashColor: AppTheme.ru_yellow.withValues(alpha: 0.2),
                    onTap: () {
                      Get.toNamed('/ondemand', arguments: {
                        'course': '${mr30Data!.courseNo}',
                        'semester': '${mr30Data!.courseSemester.toString()}',
                        'year': '${mr30Data!.courseYear.toString().substring(2, 4)}'
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header with course number and bookmark
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppTheme.ru_yellow
                                            .withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.school_rounded,
                                        color: AppTheme.ru_yellow,
                                        size: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        '${mr30Data!.courseNo}',
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.nearlyWhite,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                icon: Icon(
                                  Icons.bookmark,
                                  color: AppTheme.ru_yellow,
                                  size: 28,
                                ),
                                onPressed: () {
                                  mr30prov.addMR30(mr30Data!);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Day and Time chips
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: dayColor.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: dayColor.withValues(alpha: 0.4),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.calendar_today_rounded,
                                      color: dayColor,
                                      size: 12,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${mr30Data?.dayNameS}',
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: dayColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppTheme.nearlyWhite
                                        .withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.access_time_rounded,
                                        color: AppTheme.nearlyWhite
                                            .withValues(alpha: 0.8),
                                        size: 12,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          '${mr30Data?.timePeriod}',
                                          style: TextStyle(
                                            fontFamily: AppTheme.ruFontKanit,
                                            fontSize: 11,
                                            color: AppTheme.nearlyWhite
                                                .withValues(alpha: 0.9),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Room info
                          if (mr30Data!.courseRoom != null &&
                              mr30Data!.courseRoom!.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppTheme.nearlyWhite
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.room_rounded,
                                    color: AppTheme.ru_yellow,
                                    size: 12,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'ห้อง ${mr30Data!.courseRoom}',
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: 11,
                                      color:
                                          AppTheme.nearlyWhite.withValues(alpha: 0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const Spacer(),
                          // Bottom section: Semester and Credits
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color:
                                      AppTheme.ru_yellow.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${mr30Data!.courseSemester}/${mr30Data!.courseYear}',
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.ru_yellow,
                                  ),
                                ),
                              ),
                              if (mr30Data!.courseCredit.toString() != '0')
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppTheme.ru_yellow,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.star_rounded,
                                        color: AppTheme.ru_dark_blue,
                                        size: 14,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${mr30Data!.courseCredit} หน่วยกิต',
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 11,
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
