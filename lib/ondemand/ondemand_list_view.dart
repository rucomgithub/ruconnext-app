import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/hotel_app_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/ondemand.dart';
import '../utils/custom_functions.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/model/hotel_list_data.dart';


import 'package:webview_flutter/webview_flutter.dart';

class OndemandListView extends StatelessWidget {
  const OndemandListView(
      {Key? key,
      this.index,
      this.record,
      this.hotelData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);
  final int? index;
  final Detail? record;
  final VoidCallback? callback;
  final HotelListData? hotelData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return ListOndemand(
            animation: animation, callback: callback, record: record);
      },
    );
  }

  Text TimeStudy(String periodtime) {
    String strcheck = StringTimeStudy(periodtime);
    return Text(
      strcheck,
      style: TextStyle(
          fontFamily: AppTheme.ruFontKanit,
          fontSize: 14,
          color: Color.fromARGB(255, 189, 22, 22).withOpacity(0.8)),
    );
  }
}

class ListOndemand extends StatelessWidget {
  const ListOndemand({
    super.key,
    required this.animation,
    required this.callback,
    required this.record,
  });

  final Animation<double>? animation;
  final VoidCallback? callback;
  final Detail? record;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation!,
      child: Transform(
        transform:
            Matrix4.translationValues(0.0, 50 * (1.0 - animation!.value), 0.0),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
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
                        // AspectRatio(
                        //   aspectRatio: 10,
                        //   child: Image.asset(
                        //     'assets/hotel/hotel_1.png',
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                        Container(
                          color:
                              HotelAppTheme.buildLightTheme().scaffoldBackgroundColor,
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
                                        record!.audioSec == ""
                                            ? Text('xxx')
                                            : Row(
                                                children: <Widget>[
                                                  Text(
                                                    'ครั้งที่ ${record!.audioSec} (${record!.audioStatus})',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontFamily: AppTheme.ruFontKanit,
                                                      //fontWeight: FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  '${record!.audioCreate}',
                                                  style: TextStyle(
                                                      fontFamily: AppTheme.ruFontKanit,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                      color: AppTheme.ru_dark_blue
                                                          .withOpacity(0.8)),
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
    );
  }
}
