import 'package:get/get.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/model/coursetype.dart';
import 'package:th.ac.ru.uSmart/providers/mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/register_provider.dart';
import 'package:th.ac.ru.uSmart/widget/card/card_book.dart';

class Mr30CatalogRowView extends StatefulWidget {
  const Mr30CatalogRowView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _Mr30CatalogRowViewState createState() => _Mr30CatalogRowViewState();
}

class _Mr30CatalogRowViewState extends State<Mr30CatalogRowView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  TextEditingController _filterController = TextEditingController();
  String _filterText = '';

  @override
  void initState() {
    Provider.of<RegisterProvider>(context, listen: false).getAllRegisterYear();
    Provider.of<RegisterProvider>(context, listen: false).getAllMr30Catalog();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _filterController.addListener(() {
      setState(() {
        _filterText = _filterController.text.toLowerCase();
      });
    });
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<void> loadData(BuildContext context) async {
    //print("call provider");
    Provider.of<RegisterProvider>(context, listen: false).getAllRegisterYear();
    Provider.of<RegisterProvider>(context, listen: false).getAllMr30Catalog();
  }

  Future<void> refreshData(BuildContext context) async {
    print("refresh catalog");
    await loadData(context);
  }

  @override
  void dispose() {
    animationController?.dispose();
    _filterController.dispose();
    super.dispose();
  }

  // Filter courses based on courseno or course name
  List<CourseType> _getFilteredCourses(List<CourseType> courses) {
    if (_filterText.isEmpty) {
      return courses;
    }

    return courses
        .where((course) =>
            course.courseno!.toLowerCase().contains(_filterText) ||
            course.cname!.toLowerCase().contains(_filterText))
        .toList();
  }

  // Check if a skill category has any matching courses
  bool _hasMatchingCourses(List<CourseType> courses) {
    if (_filterText.isEmpty) {
      return true;
    }

    return courses.any((course) =>
        course.courseno!.toLowerCase().contains(_filterText) ||
        course.cname!.toLowerCase().contains(_filterText));
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<RegisterProvider>(context, listen: false);
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return RefreshIndicator(
      onRefresh: () => refreshData(context),
      child: Consumer<RegisterProvider>(builder: (context1, provider, _) {
        if (provider.isLoading) {
          return Center(
            child: SizedBox(),
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
                  child: prov.listMr30CatalogPercentage.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, right: 16, left: 16),
                          child: Container(
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: isLightMode
                                    ? AppTheme.nearlyWhite
                                    : AppTheme.ru_grey,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: AppTheme.ru_dark_blue
                                          .withValues(alpha: 0.1),
                                      offset: const Offset(0, 4),
                                      blurRadius: 12.0),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.lightbulb_outline_rounded,
                                    size: 64,
                                    color: AppTheme.ru_yellow
                                        .withValues(alpha: 0.5),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'ไม่พบข้อมูลแนะนำวิชา',
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.ru_dark_blue,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'ระบบจะแนะนำวิชาตามความถนัดของคุณ',
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: 14,
                                      color: AppTheme.dark_grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, right: 16, left: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isLightMode
                                  ? AppTheme.nearlyWhite
                                  : AppTheme.ru_grey,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppTheme.ru_dark_blue
                                        .withValues(alpha: 0.1),
                                    offset: const Offset(0, 4),
                                    blurRadius: 12.0),
                              ],
                            ),
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Column(
                              children: [
                                // Filter TextField
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: TextField(
                                    controller: _filterController,
                                    decoration: InputDecoration(
                                      hintText: 'ค้นหารหัสวิชาหรือชื่อวิชา...',
                                      hintStyle: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: 14,
                                        color: AppTheme.dark_grey,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: AppTheme.ru_dark_blue,
                                      ),
                                      suffixIcon: _filterText.isNotEmpty
                                          ? IconButton(
                                              icon: Icon(
                                                Icons.clear,
                                                color: AppTheme.ru_dark_blue,
                                              ),
                                              onPressed: () {
                                                _filterController.clear();
                                              },
                                            )
                                          : null,
                                      filled: true,
                                      fillColor: isLightMode
                                          ? AppTheme.white
                                          : AppTheme.nearlyBlack
                                              .withValues(alpha: 0.3),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: AppTheme.ru_dark_blue
                                              .withValues(alpha: 0.2),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: AppTheme.ru_dark_blue
                                              .withValues(alpha: 0.2),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: AppTheme.ru_dark_blue,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: 14,
                                      color: isLightMode
                                          ? AppTheme.darkerText
                                          : AppTheme.nearlyWhite,
                                    ),
                                  ),
                                ),
                                // Filtered List
                                Expanded(
                                  child: Builder(
                                    builder: (context) {
                                      // Create a filtered list of entries with matching courses
                                      final filteredEntries = prov
                                          .listMr30CatalogPercentage.entries
                                          .where((entry) => _hasMatchingCourses(
                                              entry.value.listcoursetype))
                                          .toList();

                                      if (filteredEntries.isEmpty &&
                                          _filterText.isNotEmpty) {
                                        return Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(32.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.search_off,
                                                  size: 64,
                                                  color: AppTheme.dark_grey
                                                      .withValues(alpha: 0.5),
                                                ),
                                                const SizedBox(height: 16),
                                                Text(
                                                  'ไม่พบวิชาที่ค้นหา',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.ruFontKanit,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppTheme.dark_grey,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'ลองค้นหาด้วยคำอื่น',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.ruFontKanit,
                                                    fontSize: 14,
                                                    color: AppTheme.dark_grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }

                                      return ListView.builder(
                                        itemCount: filteredEntries.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final int count =
                                              filteredEntries.length > 4
                                                  ? 10
                                                  : filteredEntries.length;
                                          final Animation<double>
                                              animation = Tween<double>(
                                                      begin: 0.0, end: 1.0)
                                                  .animate(CurvedAnimation(
                                                      parent:
                                                          animationController!,
                                                      curve: Interval(
                                                          (1 / count) * index,
                                                          1.0,
                                                          curve: Curves
                                                              .fastOutSlowIn)));
                                          animationController?.forward();

                                          final entry = filteredEntries[index];
                                          final skillName = entry.key;
                                          final skillData = entry.value;
                                          final filteredCourses =
                                              _getFilteredCourses(
                                                  skillData.listcoursetype);

                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                    top: 12,
                                                    bottom: 8),
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      AppTheme.ru_yellow,
                                                      AppTheme.ru_yellow
                                                          .withValues(
                                                              alpha: 0.85),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                        color: AppTheme
                                                            .ru_yellow
                                                            .withValues(
                                                                alpha: 0.4),
                                                        offset: Offset(0, 2),
                                                        blurRadius: 8.0),
                                                  ],
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppTheme
                                                                      .ru_dark_blue
                                                                      .withValues(
                                                                          alpha:
                                                                              0.15),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                child: Icon(
                                                                  Icons
                                                                      .lightbulb_rounded,
                                                                  color: AppTheme
                                                                      .ru_dark_blue,
                                                                  size: 20,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 12),
                                                              Expanded(
                                                                child: Text(
                                                                  skillName,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        AppTheme
                                                                            .ruFontKanit,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppTheme
                                                                        .ru_dark_blue,
                                                                  ),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 6),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppTheme
                                                                .ru_dark_blue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          child: Text(
                                                            '${filteredCourses.length} วิชา',
                                                            style: TextStyle(
                                                              fontFamily: AppTheme
                                                                  .ruFontKanit,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppTheme
                                                                  .ru_yellow,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 12),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 12,
                                                          vertical: 8),
                                                      decoration: BoxDecoration(
                                                        color: AppTheme
                                                            .ru_dark_blue
                                                            .withValues(
                                                                alpha: 0.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .trending_up_rounded,
                                                            color: AppTheme
                                                                .ru_dark_blue,
                                                            size: 16,
                                                          ),
                                                          const SizedBox(
                                                              width: 6),
                                                          Text(
                                                            'ความถนัดตรงกัน ${skillData.percent.toStringAsFixed(0)}%',
                                                            style: TextStyle(
                                                              fontFamily: AppTheme
                                                                  .ruFontKanit,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppTheme
                                                                  .ru_dark_blue,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Mr30CatalogListValueView(
                                                listData: filteredCourses,
                                                animation: animation,
                                                animationController:
                                                    animationController!,
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
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
      }),
    );
  }
}

class Mr30CatalogListValueView extends StatelessWidget {
  const Mr30CatalogListValueView(
      {Key? key, this.listData, this.animationController, this.animation})
      : super(key: key);
  final List<CourseType>? listData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    var mr30Prov = context.watch<MR30Provider>();
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                200 * (1.0 - animation!.value), 0.0, 0.0),
            child: Container(
              height: 240,
              width: double.infinity,
              child: ListView.builder(
                itemCount: listData!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                      listData!.length > 10 ? 10 : listData!.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 8.0, bottom: 8.0, right: 8),
                          child: CardBook(
                            index: index,
                            icondata: listData![index].check!
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            title: listData![index].courseno,
                            content: '${listData![index].cname}',
                            callback: () {
                              Get.toNamed('/ondemand', arguments: {
                                'course':
                                    '${listData![index].courseno} (${listData![index]})',
                                'semester':
                                    '${mr30Prov.yearsemester.semester.toString()}',
                                'year':
                                    '${mr30Prov.yearsemester.year.toString().substring(2, 4)}'
                              });
                            },
                            animation: animation,
                            animationController: animationController!,
                          ))
                    ],
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

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = AppTheme.ru_dark_blue;

    Path path = Path();
    path.moveTo(2, 0); // Start at the top left corner of the triangle
    path.lineTo(size.width,
        size.height); // Move to the bottom right corner of the triangle
    path.lineTo(
        8, size.height); // Move to the bottom left corner of the triangle
    path.close(); // Close the path

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
