import 'package:get/get.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
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

  @override
  void initState() {
    Provider.of<RegisterProvider>(context, listen: false).getAllRegisterYear();
    Provider.of<RegisterProvider>(context, listen: false).getAllMr30Catalog();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
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
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, right: 8, left: 8),
                              decoration: BoxDecoration(
                                // image: DecorationImage(
                                //   image: AssetImage('assets/images/ID.png'),
                                //   fit: BoxFit.cover,
                                //   opacity: isLightMode ? 0.6 : 0.2,
                                // ),
                                color: isLightMode
                                    ? AppTheme.nearlyWhite
                                    : AppTheme.ru_grey,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    bottomLeft: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0),
                                    topRight: Radius.circular(40.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: AppTheme.ru_grey.withOpacity(0.2),
                                      offset: const Offset(1.1, 1.1),
                                      blurRadius: 10.0),
                                ],
                              ),
                              child: Text('ไม่พบข้อมูลลงทะเบียน')),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, right: 16, left: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              // image: DecorationImage(
                              //   image: AssetImage('assets/images/ID.png'),
                              //   fit: BoxFit.cover,
                              //   opacity: isLightMode ? 0.6 : 0.2,
                              // ),
                              color: isLightMode
                                  ? AppTheme.nearlyWhite
                                  : AppTheme.ru_grey,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0),
                                  topRight: Radius.circular(40.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppTheme.ru_grey.withOpacity(0.2),
                                    offset: const Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),
                            height:
                                prov.listMr30CatalogPercentage.length * 290 + 8,
                            width: double.infinity,
                            child: ListView.builder(
                              itemCount: prov.listMr30CatalogPercentage.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                final int count =
                                    prov.listMr30CatalogPercentage.length > 4
                                        ? 10
                                        : prov.listMr30CatalogPercentage.length;
                                final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                        CurvedAnimation(
                                            parent: animationController!,
                                            curve: Interval(
                                                (1 / count) * index, 1.0,
                                                curve: Curves.fastOutSlowIn)));
                                animationController?.forward();
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: isLightMode
                                            ? AppTheme.nearlyWhite
                                            : AppTheme.ru_grey,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0),
                                            topRight: Radius.circular(68.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: isLightMode
                                                  ? AppTheme.ru_grey
                                                  : AppTheme.nearlyWhite,
                                              offset: Offset(0, 4),
                                              blurRadius: 8.0),
                                        ],
                                      ),
                                      height: 50,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                              top: 8.0,
                                              right: 24.0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.book,
                                                      color:
                                                          AppTheme.ru_dark_blue,
                                                      size: 16,
                                                    ),
                                                    Text(
                                                      '${prov.listMr30CatalogPercentage.entries.elementAt(index).key}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppTheme.body2,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '${prov.listMr30CatalogPercentage.entries.elementAt(index).value.listcoursetype.length} วิชา',
                                                  textAlign: TextAlign.center,
                                                  style: AppTheme.body2,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  right: 8.0,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'เคยลงทะเบียนใกล้เคียงความถนัดนี้ ตรงกัน ${prov.listMr30CatalogPercentage.entries.elementAt(index).value.percent.toStringAsFixed(2)}%',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppTheme.caption,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Mr30CatalogListValueView(
                                      listData: prov
                                          .listMr30CatalogPercentage.entries
                                          .elementAt(index)
                                          .value
                                          .listcoursetype,
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
