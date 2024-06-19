import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/hotel_app_theme.dart';

import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/model/scholarship.dart';

import '../model/scholarship.dart';
import '../utils/custom_functions.dart';
import 'package:intl/intl.dart';

class SchListView extends StatelessWidget {
  const SchListView(
      {Key? key,
      this.record,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);
  final RECORD? record;
  final VoidCallback? callback;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return ListSch(
            animation: animation, callback: callback, record: record);
      },
    );
  }
}

class ListSch extends StatelessWidget {
  const ListSch({
    super.key,
    required this.animation,
    required this.callback,
    required this.record,
  });

  final Animation<double>? animation;
  final VoidCallback? callback;
  final RECORD? record;

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
                        Container(
                          color:
                              HotelAppTheme.buildLightTheme().backgroundColor,
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
                                        record!.stdCode == ""
                                            ? Text('xxx')
                                            : Row(
                                                children: <Widget>[
                                                  Text(
                                                    '(${record!.scholarshipSemester}/${record!.scholarshipYear}) ${record!.subsidyNameThai} เป็นจำนวน  ${NumberFormat('#,###').format(record!.amount)} บาท',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppTheme.ruFontKanit,
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
                                                  '${record!.created}',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          AppTheme.ruFontKanit,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                      color: AppTheme
                                                          .ru_dark_blue
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
