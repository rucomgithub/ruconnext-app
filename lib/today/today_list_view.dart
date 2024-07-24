import 'package:get/get.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/hotel_app_theme.dart';
import 'package:th.ac.ru.uSmart/pages/ru_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';
import '../model/mr30_model.dart';
import '../providers/mr30_provider.dart';
import '../utils/custom_functions.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/model/hotel_list_data.dart';
// import 'package:url_launcher/url_launcher.dart';

class TodayListView extends StatelessWidget {
  // _openGoogleMapApp() async{
  //   final Uri url = Uri.parse('https://www.google.com/maps/search/?api=1&query=13.757975908470604,100.620394321302');

  //  // const String url = 'https://www.google.com/maps/search/?api=1&query=13.757975908470604,100.620394321302';
  //   print('google map');
  // if(await canLaunchUrl(url)){
  //   await launchUrl(url);
  // }else{
  //   throw 'not launch $url ';
  // }
  // }
  const TodayListView(
      {Key? key,
      this.index,
      this.record,
      this.hotelData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);
  final int? index;
  final RECORD? record;
  final VoidCallback? callback;
  final HotelListData? hotelData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;
    var havetoday = context.watch<MR30Provider>();
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 4,
                              child: Image.asset(
                                'assets/hotel/${record!.courseRoom.toString().trim().substring(0, 3)}.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              color: HotelAppTheme.buildLightTheme()
                                  .backgroundColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 8, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${record!.courseNo}',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: baseFontSize - 4,
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                  color: AppTheme.ru_dark_blue),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  //hotelData!.subTxt,
                                                  '${record!.dayNameS} ${record!.timePeriod}',
                                                  style: TextStyle(
                                                      fontSize:
                                                          baseFontSize - 6,
                                                      color:
                                                          AppTheme.nearlyBlack),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Icon(
                                                  FontAwesomeIcons.locationDot,
                                                  size: baseFontSize - 6,
                                                  color: HotelAppTheme
                                                          .buildLightTheme()
                                                      .primaryColor,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Get.toNamed('/rumap',
                                                        arguments: {
                                                          'courseroom':
                                                              '${record!.courseRoom}'
                                                        });
                                                    // Navigator.push(
                                                    //   context,
                                                    //   MaterialPageRoute(
                                                    //       builder: (context) =>
                                                    //           RuMap(),  settings: RouteSettings(
                                                    //           arguments: '${record!.courseRoom}',
                                                    //         ),),
                                                    // );
                                                  },

                                                  //        onTap: () {
                                                  // // _openGoogleMapApp();
                                                  // },
                                                  child: Text(
                                                    //'${hotelData!.dist.toStringAsFixed(1)} km to city',
                                                    '${record!.courseRoom}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize:
                                                            baseFontSize - 6,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: AppTheme
                                                            .ruFontKanit,
                                                        color: AppTheme
                                                            .ru_text_ocean_blue),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(
                                                '${record!.courseInstructor}',
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: baseFontSize - 6,
                                                    fontFamily:
                                                        AppTheme.ruFontKanit,
                                                    color:
                                                        AppTheme.nearlyBlack),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Row(
                                                children: <Widget>[
                                                  TimeStudy(record!.timePeriod!,
                                                      baseFontSize - 6),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '${record!.courseYear}/${record!.courseSemester}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: AppTheme.ruFontKanit,
                                              fontSize: baseFontSize - 6,
                                              color: AppTheme.ru_dark_blue),
                                        ),
                                        Text(
                                          '${record!.courseCredit}',
                                          style: TextStyle(
                                              fontSize: baseFontSize - 6,
                                              fontFamily: AppTheme.ruFontKanit,
                                              color: AppTheme.nearlyBlack),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: (() {
                            if (record!.register == false) {
                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                  onTap: () {
                                    havetoday.addMR30(record!);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.favorite_rounded,
                                      color: HotelAppTheme.buildLightTheme()
                                          .primaryColor,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.app_registration,
                                      color: Color.fromARGB(255, 255, 138, 83),
                                    ),
                                  ),
                                ),
                              );
                            }
                          })(),
                        )
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

  Text TimeStudy(String periodtime, double baseFontSize) {
    String strcheck = StringTimeStudy(periodtime);
    return Text(
      strcheck,
      style: TextStyle(
          fontSize: baseFontSize - 2,
          fontFamily: AppTheme.ruFontKanit,
          color: Color.fromARGB(255, 189, 22, 22).withOpacity(0.8)),
    );
  }
}
