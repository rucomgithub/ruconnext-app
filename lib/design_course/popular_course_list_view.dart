import 'package:th.ac.ru.uSmart/design_course/design_course_app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/mr30_model.dart';
import '../providers/mr30_provider.dart';
import '../providers/grade_provider.dart';

class PopularCourseListView extends StatefulWidget {
  const PopularCourseListView({Key? key, this.callBack}) : super(key: key);

  final VoidCallback? callBack;

  @override
  _PopularCourseListViewState createState() => _PopularCourseListViewState();
}

class _PopularCourseListViewState extends State<PopularCourseListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  late Future<MR30> mr30getall;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();

    Provider.of<MR30Provider>(context, listen: false).getAllMR30();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MR30Provider>(
        builder: (context, mr30prov, child) {
          if (mr30prov.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return GridView(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List<Widget>.generate(
                mr30prov.mr30filter.rECORD!.length,
                (int index) {
                  final int count = mr30prov.mr30filter.rECORD!.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController!,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController?.forward();
                  return CategoryView(
                    callback: widget.callBack,
                    category: mr30prov.mr30filter.rECORD![index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 32.0,
                crossAxisSpacing: 32.0,
                childAspectRatio: 0.8,
              ),
            );
          }
        },
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key? key,
      this.category,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final RECORD? category;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        final mr30prov = context.read<MR30Provider>();
        final registerprov = context.read<GradeProvider>();
        registerprov.getAllGrade();
        print('Call Provider : ${mr30prov.mr30record.length}');
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                print(category!.courseNo);
                mr30prov.addMR30(category!);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext context) =>
                //         CourseInfoScreen(category: category),
                //   ),
                // );
              },
              child: SizedBox(
                height: 140,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor('#F8FAFB'),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                // border: new Border.all(
                                //     color: DesignCourseAppTheme.notWhite),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16, left: 16, right: 16),
                                            child: Text(
                                              '${category!.courseNo.toString()}',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: DesignCourseAppTheme
                                                    .darkerText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8,
                                                left: 16,
                                                right: 16,
                                                bottom: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '${category!.courseRoom.toString()}',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        fontSize: 12,
                                                        letterSpacing: 0.27,
                                                        color:
                                                            DesignCourseAppTheme
                                                                .grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${category!.dayNameS.toString()} ${category!.timePeriod.toString()}',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        fontSize: 10,
                                                        letterSpacing: 0.27,
                                                        color:
                                                            DesignCourseAppTheme
                                                                .grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${category!.courseExamdate.toString()}',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        fontSize: 10,
                                                        letterSpacing: 0.27,
                                                        color:
                                                            DesignCourseAppTheme
                                                                .grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${category!.courseYear.toString()}/${category!.courseSemester.toString()}',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        fontSize: 12,
                                                        letterSpacing: 0.27,
                                                        color:
                                                            DesignCourseAppTheme
                                                                .grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        '${category!.courseCredit.toString()}',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontSize: 18,
                                                          letterSpacing: 0.27,
                                                          color:
                                                              DesignCourseAppTheme
                                                                  .grey,
                                                        ),
                                                      ),
                                                      IconFavorite(
                                                          category!.favorite!),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 0, right: 16, left: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: DesignCourseAppTheme.grey
                                      .withValues(alpha: 0.2),
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 6.0),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(1.0)),
                            child: Text(
                              '${category!.courseComment.toString()}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 10,
                                letterSpacing: 0.27,
                                color: Color.fromARGB(255, 233, 105, 107),
                              ),
                            ),
                          ),
                        ),
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

  Icon IconFavorite(bool favorite) {
    return favorite
        ? Icon(
            Icons.star,
            color: DesignCourseAppTheme.nearlyBlue,
            size: 20,
          )
        : Icon(
            Icons.star_border_outlined,
            color: DesignCourseAppTheme.nearlyBlue,
            size: 20,
          );
  }
}
