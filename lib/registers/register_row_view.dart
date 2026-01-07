import 'package:get/get.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/model/register_model.dart';
import 'package:th.ac.ru.uSmart/providers/mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/register_provider.dart';
import 'package:th.ac.ru.uSmart/widget/card/card_book.dart';

class RegisterRowView extends StatefulWidget {
  const RegisterRowView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _RegisterRowViewState createState() => _RegisterRowViewState();
}

class _RegisterRowViewState extends State<RegisterRowView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    Provider.of<RegisterProvider>(context, listen: false).getAllRegisterYear();
    Provider.of<RegisterProvider>(context, listen: false).getAllMr30Catalog();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
    return true;
  }

  Future<void> loadData(BuildContext context) async {
    //print("call provider");
    Provider.of<RegisterProvider>(context, listen: false).getAllRegisterYear();
    Provider.of<RegisterProvider>(context, listen: false).getAllMr30Catalog();
  }

  Future<void> refreshData(BuildContext context) async {
    //print("refresh register");
    await loadData(context);
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
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
            child: CircularProgressIndicator(),
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
                  child: prov.listGroupCourse.isEmpty
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
                                    Icons.inbox_rounded,
                                    size: 64,
                                    color: AppTheme.ru_dark_blue
                                        .withValues(alpha: 0.3),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'ไม่พบข้อมูลลงทะเบียน',
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.ru_dark_blue,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'กรุณาเลือกปีการศึกษาด้านบน',
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: 14,
                                      color: AppTheme.dark_grey,
                                    ),
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
                            height: (prov.listGroupCourse.length * 320) + 16,
                            width: double.infinity,
                            child: ListView.builder(
                              itemCount: prov.listGroupCourse.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                final int count =
                                    prov.listGroupCourse.length > 4
                                        ? 10
                                        : prov.listGroupCourse.length;
                                final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                        CurvedAnimation(
                                            parent: animationController!,
                                            curve: Interval(
                                                (1 / count) * index, 1.0,
                                                curve: Curves.fastOutSlowIn)));
                                animationController?.forward();
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 8, right: 8, top: 12, bottom: 8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 14),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppTheme.ru_dark_blue,
                                            AppTheme.ru_dark_blue
                                                .withValues(alpha: 0.85),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: AppTheme.ru_dark_blue
                                                  .withValues(alpha: 0.3),
                                              offset: Offset(0, 2),
                                              blurRadius: 8.0),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: AppTheme.ru_yellow
                                                      .withValues(alpha: 0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Icon(
                                                  Icons.book_rounded,
                                                  color: AppTheme.ru_yellow,
                                                  size: 20,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                'ภาคเรียนที่ ${prov.listGroupCourse.entries.elementAt(index).key}',
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppTheme.nearlyWhite,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: AppTheme.ru_yellow,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              '${prov.listGroupCourse.entries.elementAt(index).value.length} วิชา',
                                              style: TextStyle(
                                                fontFamily:
                                                    AppTheme.ruFontKanit,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: AppTheme.ru_dark_blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListRegisterListValueView(
                                      listData: prov.listGroupCourse.entries
                                          .elementAt(index)
                                          .value,
                                      animation: animation,
                                      animationController: animationController!,
                                    ),
                                  ],
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
      }),
    );
  }
}

class ListRegisterListValueView extends StatelessWidget {
  const ListRegisterListValueView(
      {Key? key, this.listData, this.animationController, this.animation})
      : super(key: key);
  final List<REGISTERECORDVIEW>? listData;
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
                          //icondata: Icons.book,
                          title: listData![index].courseNo,
                          content: '${listData![index].credit} หน่วยกิต ',
                          callback: () {
                            Get.toNamed('/ondemand', arguments: {
                              'course': '${listData![index].courseNo}',
                              'semester':
                                  '${mr30Prov.yearsemester.semester.toString()}',
                              'year':
                                  '${mr30Prov.yearsemester.year.toString().substring(2, 4)}'
                            });
                          },
                          animation: animation,
                          animationController: animationController!,
                        ),
                      )
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
