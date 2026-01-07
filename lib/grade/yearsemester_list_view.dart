import 'package:get/get.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/widget/ru_wallpaper.dart';
import '../providers/grade_provider.dart';
import '../fitness_app/models/grade_list_data.dart';
import '../fitness_app/ui_view/gradeyear_screen.dart';

// Full screen with AppBar
class YearSemesterScreen extends StatefulWidget {
  const YearSemesterScreen({Key? key}) : super(key: key);

  @override
  _YearSemesterScreenState createState() => _YearSemesterScreenState();
}

class _YearSemesterScreenState extends State<YearSemesterScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animationController?.forward();
    Provider.of<GradeProvider>(context, listen: false).getAllGrade();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        iconTheme: IconThemeData(
          color: AppTheme.nearlyWhite,
        ),
        title: Text(
          'เกรดแยกตามปี/ภาค',
          style: TextStyle(
            fontSize: baseFontSize,
            fontFamily: AppTheme.ruFontKanit,
            color: AppTheme.nearlyWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.ru_dark_blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.help,
              color: AppTheme.nearlyWhite,
            ),
            onPressed: () {
              Get.toNamed("/gradehelp");
            },
          ),
        ],
      ),
      backgroundColor:
          isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
      body: Stack(
        children: [
          RuWallpaper(),
          YearSemesterListView(
            mainScreenAnimationController: animationController,
            mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animationController!,
                curve: Curves.fastOutSlowIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Component widget (used in other screens)
class YearSemesterListView extends StatefulWidget {
  const YearSemesterListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _YearSemesterListViewState createState() => _YearSemesterListViewState();
}

class _YearSemesterListViewState extends State<YearSemesterListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<GradeListData> gradeListData = GradeListData.tabIconsList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    var prov = Provider.of<GradeProvider>(context, listen: false);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;

    return (prov.gradeYearSemester.isEmpty ||
            prov.gradeYearSemester[0].grades == null)
        ? SizedBox()
        : AnimatedBuilder(
            animation: widget.mainScreenAnimationController!,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: widget.mainScreenAnimation!,
                child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, right: 8, left: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isLightMode
                              ? [
                                  AppTheme.nearlyWhite,
                                  AppTheme.nearlyWhite.withValues(alpha: 0.95)
                                ]
                              : [
                                  AppTheme.ru_grey,
                                  AppTheme.ru_grey.withValues(alpha: 0.9)
                                ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color:
                                  AppTheme.ru_dark_blue.withValues(alpha: 0.12),
                              offset: const Offset(0, 4),
                              blurRadius: 12.0,
                              spreadRadius: 0),
                        ],
                      ),
                      height: screenHeight * 0.28,
                      width: double.infinity,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemCount: prov.gradeYearSemester.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final int count = prov.gradeYearSemester.length > 10
                              ? 10
                              : prov.gradeYearSemester.length;
                          final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                      parent: animationController!,
                                      curve: Interval((1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn)));
                          animationController?.forward();

                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 18.0, bottom: 12.0, right: 4.0),
                            child: YearSemesterView(
                              gradeListData: prov.gradeYearSemester[index],
                              animation: animation,
                              animationController: animationController!,
                            ),
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

class YearSemesterView extends StatefulWidget {
  const YearSemesterView(
      {Key? key, this.gradeListData, this.animationController, this.animation})
      : super(key: key);

  final GradeListData? gradeListData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  State<YearSemesterView> createState() => _YearSemesterViewState();
}

class _YearSemesterViewState extends State<YearSemesterView> {
  late ScrollController _scrollController;
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startAutoScroll();
  }

  void _startAutoScroll() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    _autoScroll();
  }

  void _autoScroll() async {
    if (!mounted || _scrollController.hasClients == false) return;

    while (mounted && _scrollController.hasClients) {
      if (_isScrolling) {
        await Future.delayed(const Duration(milliseconds: 100));
        continue;
      }

      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;

      if (maxScroll > 0) {
        // Scroll down
        await _scrollController.animateTo(
          maxScroll,
          duration: Duration(milliseconds: (maxScroll * 30).toInt()),
          curve: Curves.linear,
        );

        await Future.delayed(const Duration(seconds: 2));

        if (!mounted) return;

        // Scroll back to top
        await _scrollController.animateTo(
          0,
          duration: Duration(milliseconds: (maxScroll * 15).toInt()),
          curve: Curves.easeInOut,
        );

        await Future.delayed(const Duration(seconds: 2));
      } else {
        break;
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    return widget.gradeListData!.grades == null
        ? SizedBox()
        : AnimatedBuilder(
            animation: widget.animationController!,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: widget.animation!,
                child: Transform(
                  transform: Matrix4.translationValues(
                      100 * (1.0 - widget.animation!.value), 0.0, 0.0),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GradeYearScreen(
                                animationController:
                                    widget.animationController!,
                                yearSemester:
                                    widget.gradeListData!.yearSemester,
                                grades: widget.gradeListData!.grades),
                          ));
                    },
                    child: SizedBox(
                      width: screenWidth * 0.42,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.ru_dark_blue,
                              AppTheme.ru_dark_blue.withValues(alpha: 0.9),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color:
                                  AppTheme.ru_dark_blue.withValues(alpha: 0.3),
                              offset: const Offset(0, 4),
                              blurRadius: 12.0,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Stack(
                            children: [
                              // Decorative background pattern
                              Positioned(
                                top: -15,
                                right: -15,
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.ru_yellow
                                        .withValues(alpha: 0.06),
                                  ),
                                ),
                              ),
                              // Main content
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Header with icon and badge
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: AppTheme.ru_yellow
                                                .withValues(alpha: 0.2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: AppTheme.ru_yellow
                                                  .withValues(alpha: 0.3),
                                              width: 1,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.school_rounded,
                                            size: 18,
                                            color: AppTheme.ru_yellow,
                                          ),
                                        ),
                                        Flexible(
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(left: 8),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: AppTheme.ru_yellow,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.arrow_forward_rounded,
                                                  size: 10,
                                                  color: AppTheme.ru_dark_blue,
                                                ),
                                                const SizedBox(width: 4),
                                                Flexible(
                                                  child: Text(
                                                    'ดูรายละเอียด',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppTheme.ruFontKanit,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 9,
                                                      color:
                                                          AppTheme.ru_dark_blue,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    // Year/Semester title with underline
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.gradeListData!.yearSemester,
                                          style: TextStyle(
                                            fontFamily: AppTheme.ruFontKanit,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            letterSpacing: 0.3,
                                            color: AppTheme.ru_yellow,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          height: 2,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                AppTheme.ru_yellow,
                                                AppTheme.ru_yellow
                                                    .withValues(alpha: 0),
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    // Grades list with enhanced container and auto-scroll
                                    Expanded(
                                      child: GestureDetector(
                                        onPanDown: (_) {
                                          setState(() {
                                            _isScrolling = true;
                                          });
                                        },
                                        onPanEnd: (_) {
                                          setState(() {
                                            _isScrolling = false;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: Colors.white
                                                .withValues(alpha: 0.1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.white
                                                  .withValues(alpha: 0.2),
                                              width: 1,
                                            ),
                                          ),
                                          child: ListView.builder(
                                            controller: _scrollController,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            itemCount: widget
                                                .gradeListData!.grades!.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 6.0),
                                                child: Text(
                                                  '${index + 1}. ${widget.gradeListData!.grades![index]}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.ruFontKanit,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    height: 1.4,
                                                    letterSpacing: 0.1,
                                                    color: AppTheme.white
                                                        .withValues(
                                                            alpha: 0.95),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    // Credit sum
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppTheme.ru_yellow,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(width: 8),
                                              Text(
                                                'หน่วยกิต',
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: AppTheme.ru_dark_blue,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: AppTheme.ru_dark_blue
                                                  .withValues(alpha: 0.15),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              widget.gradeListData?.creditsum !=
                                                      0
                                                  ? widget
                                                      .gradeListData!.creditsum
                                                      .toString()
                                                  : '0',
                                              style: TextStyle(
                                                fontFamily:
                                                    AppTheme.ruFontKanit,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: AppTheme.ru_dark_blue,
                                              ),
                                            ),
                                          ),
                                        ],
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
                  ),
                ),
              );
            },
          );
  }
}
