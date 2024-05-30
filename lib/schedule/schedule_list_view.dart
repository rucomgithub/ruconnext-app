import 'package:th.ac.ru.uSmart/hotel_booking/hotel_app_theme.dart';
import 'package:th.ac.ru.uSmart/model/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';
import '../model/mr30_model.dart';
import '../providers/mr30_provider.dart';
import '../utils/custom_functions.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/model/hotel_list_data.dart';

class ScheduleListView extends StatelessWidget {
  const ScheduleListView(
      {Key? key,
      this.index,
      this.record,
      this.hotelData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);
  final int? index;
  final Schedule? record;
  final VoidCallback? callback;
  final HotelListData? hotelData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  // String formatDate(String dateStr) {
  //   DateFormat inputFormat = DateFormat('yyyy-MM-dd');
  //   //DateFormat outputFormat = DateFormat('dd/MM/yyyy');
  //   DateTime date = inputFormat.parse(dateStr);
  //   DateFormat formatter = DateFormat.yMMMd('th');
  //   //return outputFormat.format(date);
  //   return formatter.format(date);
  // }

  // Duration dateDiff(DateTime date1, DateTime date2) {
  //   return date1.difference(date2);
  // }

  // int daysBetween(DateTime from, DateTime to) {
  //   from = DateTime(from.year, from.month, from.day);
  //   to = DateTime(to.year, to.month, to.day);
  //   return (to.difference(from).inHours / 24).round();
  // }

  // String commingTime(DateTime date1, DateTime date2, DateTime date3) {
  //   var txtResponse = null;
  //   //เหลืออีกกี่วันจะถึงกิจกรรม
  //   dateDiff(
  //     DateTime.parse(record!.startDate),
  //     DateTime.now(),
  //   ).inDays;
  //   //เหลืออีกกี่วันจะหมดกิจกรรม
  //   var endTime = dateDiff(
  //     DateTime.parse(record!.endDate),
  //     DateTime.now(),
  //   ).inDays;
  //   // print("xxxx${daysBetween(date2, date1).toString()}");
  //   if (daysBetween(date2, date1) == 0) {
  //     // print(date2);
  //     // print(daysBetween(date2, date1).toString());
  //     //txtResponse = "เหลืออีก 1 วัน${dateDiff(date1, date2).inDays}";
  //     // print(dateDiff(date1, date2).inDays);
  //     // print(dateDiff(date1, date2).inHours);
  //     // print(dateDiff(date1, date2).inMinutes);
  //     txtResponse =
  //         "กิจกรรมได้เริ่มขึ้นแล้ว เหลือ ${dateDiff(date3, DateTime.now()).inDays + 1} กิจกรรมจะหมดเวลา";
  //   } else if (daysBetween(date2, date1) > 0) {
  //     print(daysBetween(date2, date1).toString());
  //     // txtResponse =
  //     //     "อีก ${dateDiff(date1, date2).inDays + 1} วัน กิจกรรมจะเริ่มขึ้น";
  //     txtResponse =
  //         "อีก ${daysBetween(date2, date1).toString()} วัน กิจกรรมจะเริ่มขึ้น";
  //   } else {
  //     //txtResponse = "หมดเวลา${dateDiff(date1, date2).inDays}";
  //     txtResponse = "กิจกรรมนี้หมดเวลาแล้ว ";
  //   }

  //   return txtResponse;
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
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
                              aspectRatio: 10,
                              child: Image.asset(
                                'assets/hotel/SWB.png',
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
                                              '${formatDate(record!.startDate)} - ${formatDate(record!.endDate)}',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                     fontFamily: AppTheme.ruFontKanit,
                                                //fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                            // Row(
                                            //   crossAxisAlignment:
                                            //       CrossAxisAlignment.center,
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment.start,
                                            //   children: <Widget>[
                                            //     Text(
                                            //       //hotelData!.subTxt,
                                            //       '${commingTime(DateTime.parse(record!.startDate), DateTime.now(), DateTime.parse(record!.endDate))}',
                                            //       style: TextStyle(
                                            //           fontSize: 14,
                                            //           color: Colors.grey
                                            //               .withOpacity(0.8)),
                                            //     ),
                                            //     const SizedBox(
                                            //       width: 4,
                                            //     ),
                                            //     Icon(
                                            //       FontAwesomeIcons.locationDot,
                                            //       size: 12,
                                            //       color: HotelAppTheme
                                            //               .buildLightTheme()
                                            //           .primaryColor,
                                            //     ),
                                            //     Expanded(
                                            //       child: Text(
                                            //         //'${hotelData!.dist.toStringAsFixed(1)} km to city',
                                            //         '${record!.id}',
                                            //         overflow:
                                            //             TextOverflow.ellipsis,
                                            //         style: TextStyle(
                                            //             fontSize: 14,
                                            //             color: Colors.grey
                                            //                 .withOpacity(0.8)),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Row(
                                                children: <Widget>[
                                                  // RatingBar(
                                                  //   initialRating:
                                                  //       hotelData!.rating,
                                                  //   direction: Axis.horizontal,
                                                  //   allowHalfRating: true,
                                                  //   itemCount: 5,
                                                  //   itemSize: 24,
                                                  //   ratingWidget: RatingWidget(
                                                  //     full: Icon(
                                                  //       Icons.star_rate_rounded,
                                                  //       color: HotelAppTheme
                                                  //               .buildLightTheme()
                                                  //           .primaryColor,
                                                  //     ),
                                                  //     half: Icon(
                                                  //       Icons.star_half_rounded,
                                                  //       color: HotelAppTheme
                                                  //               .buildLightTheme()
                                                  //           .primaryColor,
                                                  //     ),
                                                  //     empty: Icon(
                                                  //       Icons
                                                  //           .star_border_rounded,
                                                  //       color: HotelAppTheme
                                                  //               .buildLightTheme()
                                                  //           .primaryColor,
                                                  //     ),
                                                  //   ),
                                                  //   itemPadding:
                                                  //       EdgeInsets.zero,
                                                  //   onRatingUpdate: (rating) {
                                                  //     print(rating);
                                                  //   },
                                                  // ),

                                                  Expanded(
                                                    child: Text(
                                                      '${record!.eventName}',
                                                      style: TextStyle(
                                                             fontFamily: AppTheme.ruFontKanit,
                                                          
                                                          fontSize: 14,
                                                          color: Colors
                                                              .lightBlue
                                                              .withOpacity(
                                                                  0.8)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Row(
                                                children: <Widget>[
                                                  //TimeStudy(record!.file!),
                                                  //Text(record!.id!),
                                                  Text(
                                                    '${commingTime(DateTime.parse(record!.startDate), DateTime.now(), DateTime.parse(record!.endDate))}',
                                                    style: TextStyle(
                                                           fontFamily: AppTheme.ruFontKanit,
                                                        color: Colors.redAccent,
                                                        fontSize: 10,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //ปิดการแสดงส่วนแถวแรก ด้านขวามือ
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       right: 16, top: 8),
                                  //   child: Column(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.center,
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.end,
                                  //     children: <Widget>[
                                  //       Text(
                                  //         //แสดงเหลืออีกกี่วัน
                                  //         //'${dateDiff(DateTime.parse("2023-04-04"), DateTime.parse(record!.endDate)).inDays} ***',
                                  //         '*${dateDiff(
                                  //           DateTime.parse(record!.startDate),
                                  //           DateTime.now(),
                                  //         ).inDays} * / ${dateDiff(
                                  //           DateTime.parse(record!.endDate),
                                  //           DateTime.now(),
                                  //         ).inDays}',
                                  //         textAlign: TextAlign.left,
                                  //         style: TextStyle(
                                  //           fontWeight: FontWeight.w600,
                                  //           fontSize: 18,
                                  //         ),
                                  //       ),
                                  //       Text(
                                  //         '${record!.image}',
                                  //         style: TextStyle(
                                  //             fontSize: 14,
                                  //             color:
                                  //                 Colors.grey.withOpacity(0.8)),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Positioned(
                        //   top: 8,
                        //   right: 8,
                        //   child: Material(
                        //     color: Colors.transparent,
                        //     child: InkWell(
                        //       borderRadius: const BorderRadius.all(
                        //         Radius.circular(32.0),
                        //       ),
                        //       onTap: () {
                        //         // havetoday.addMR30(record!);
                        //       },
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Icon(
                        //           Icons.favorite_rounded,
                        //           color: HotelAppTheme.buildLightTheme()
                        //               .primaryColor,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // )
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

  Text TimeStudy(String periodtime) {
    String strcheck = StringTimeStudy(periodtime);
    return Text(
      strcheck,
      style: TextStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 189, 22, 22).withOpacity(0.8)),
    );
  }
}
