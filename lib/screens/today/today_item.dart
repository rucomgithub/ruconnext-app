import 'package:th.ac.ru.uSmart/model/mr30_model.dart';
import 'package:th.ac.ru.uSmart/utils/custom_functions.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/utils/constants.dart';
import 'package:th.ac.ru.uSmart/utils/widget_functions.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class TodayItem extends StatelessWidget {
  final double width;
  final RECORD todayData;

  const TodayItem({Key? key, required this.width, required this.todayData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final height = width * 4 / 3;
    return Container(
      margin: const EdgeInsets.only(right: 20),
      width: width,
      height: height + 40,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(flex: 2, child: Container()),
              Expanded(
                flex: 7,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 20,
                    child: Center(
                        child: CircleAvatar(
                      //backgroundColor: Colors.blueGrey,
                      backgroundImage: AssetImage('assets/images/mr30.png'),
                      backgroundColor: ColorDay(todayData.dayCode!),
                      minRadius: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.book,
                            size: 60,
                            color: COLOR_BLACK,
                          ),
                          Text('${todayData.courseNo}',
                              style: TextStyle(
                                  color: COLOR_BLACK,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ))),
                Text(
                  "${todayData.dayNameS} ${todayData.timePeriod}",
                  style: textTheme.headline6,
                ),
                TimeStudy(textTheme, todayData.timePeriod!),
                addVerticalSpace(5),
                RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      WidgetSpan(
                          child: Icon(Icons.location_on,
                              color: Colors.red, size: 15)),
                      TextSpan(
                          text: "${todayData.courseRoom}",
                          style: textTheme.caption)
                    ])),
                addVerticalSpace(5),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: RichText(
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            WidgetSpan(
                                child: Icon(Icons.credit_score_outlined,
                                    color: Colors.orange, size: 15)),
                            TextSpan(
                                text: "${todayData.courseCredit}",
                                style: textTheme.subtitle2!
                                    .apply(fontWeightDelta: 4))
                          ])),
                    ),
                    Expanded(
                      flex: 5,
                      child: RichText(
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            TextSpan(
                                text:
                                    "${todayData.courseYear}/${todayData.courseSemester}",
                                style: textTheme.headline5!
                                    .apply(color: COLOR_ORANGE))
                          ])),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Text TimeStudy(TextTheme textTheme, String periodtime) {
    String strcheck = StringTimeStudy(periodtime);
    return Text(
      "$strcheck",
      style: textTheme.headline6,
    );
  }
}
