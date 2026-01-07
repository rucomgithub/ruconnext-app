import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';

class MasterGradeYearListView extends StatefulWidget {
  const MasterGradeYearListView(
      {Key? key,
      this.mainScreenAnimationController,
      this.mainScreenAnimation,
      this.yearSemester,
      this.grades})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  final List<String>? grades;
  final String? yearSemester;
  @override
  _MasterGradeYearListViewState createState() =>
      _MasterGradeYearListViewState();
}

class _MasterGradeYearListViewState extends State<MasterGradeYearListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<String> areaListData = <String>[
    'assets/fitness_app/area1.png',
    'assets/fitness_app/area2.png',
    'assets/fitness_app/area3.png',
    'assets/fitness_app/area1.png',
  ];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 100 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: List<Widget>.generate(
                    widget.grades!.length,
                    (int index) {
                      final int count = widget.grades!.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController!,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      animationController?.forward();
                      return AreaView(
                        index: index,
                        course: widget.grades![index],
                        animation: animation,
                        animationController: animationController!,
                      );
                    },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AreaView extends StatelessWidget {
  const AreaView({
    Key? key,
    this.index,
    this.course,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final int? index;
  final String? course;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        List<String> parts = this.course.toString().split(',');
        final bool isFailed = parts[1].contains("F");
        final Color gradeColor = isFailed
            ? Colors.red.shade400
            : AppTheme.ru_text_light_blue;
        final Color cardColor = isFailed
            ? Colors.red.shade50
            : Colors.white;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: FadeTransition(
            opacity: animation!,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 80 * (1.0 - animation!.value), 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16.0),
                  border: isFailed
                      ? Border.all(color: Colors.red.shade200, width: 2)
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: isFailed
                          ? Colors.red.withOpacity(0.2)
                          : Colors.grey.withOpacity(0.15),
                      offset: const Offset(0, 4),
                      blurRadius: 12.0,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.0),
                    splashColor: gradeColor.withOpacity(0.1),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isFailed
                                    ? [Colors.red.shade300, Colors.red.shade500]
                                    : [
                                        AppTheme.ru_text_light_blue,
                                        AppTheme.ru_dark_blue
                                      ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  color: gradeColor.withOpacity(0.3),
                                  offset: const Offset(0, 2),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.book,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  parts[0],
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.ru_dark_blue,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.credit_card,
                                      size: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${parts[2]}.0 หน่วยกิต',
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: gradeColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: gradeColor.withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              parts[1],
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: gradeColor,
                              ),
                            ),
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
