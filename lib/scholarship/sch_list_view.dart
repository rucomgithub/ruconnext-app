import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/hotel_app_theme.dart';

import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/model/scholarship.dart';

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
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    return FadeTransition(
      opacity: animation!,
      child: Transform(
        transform:
            Matrix4.translationValues(0.0, 50 * (1.0 - animation!.value), 0.0),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: callback,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                gradient: LinearGradient(
                  colors: [
                    AppTheme.ru_dark_blue.withValues(alpha: 0.05),
                    AppTheme.ru_yellow.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: AppTheme.ru_dark_blue.withValues(alpha: 0.1),
                  width: 1,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: isLightMode
                        ? Colors.grey.withValues(alpha: 0.2)
                        : Colors.black.withValues(alpha: 0.3),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                child: Container(
                  color: isLightMode
                      ? AppTheme.nearlyWhite
                      : AppTheme.nearlyBlack.withValues(alpha: 0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Header row with icon and semester/year
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppTheme.ru_dark_blue,
                                    AppTheme.ru_dark_blue.withValues(alpha: 0.7),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.ru_dark_blue.withValues(alpha: 0.3),
                                    offset: Offset(0, 2),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.workspace_premium_rounded,
                                color: AppTheme.ru_yellow,
                                size: 28,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ภาคการศึกษา ${record!.scholarshipSemester}/${record!.scholarshipYear}',
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isLightMode
                                          ? AppTheme.ru_dark_blue
                                          : AppTheme.nearlyWhite,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_rounded,
                                        size: 12,
                                        color: AppTheme.ru_dark_blue.withValues(alpha: 0.6),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        formatDateFromString('${record!.created}'),
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 12,
                                          color: isLightMode
                                              ? AppTheme.ru_dark_blue.withValues(alpha: 0.6)
                                              : AppTheme.nearlyWhite.withValues(alpha: 0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16),

                        // Divider
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.ru_dark_blue.withValues(alpha: 0.1),
                                AppTheme.ru_yellow.withValues(alpha: 0.1),
                                AppTheme.ru_dark_blue.withValues(alpha: 0.1),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 16),

                        // Scholarship name
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.school_rounded,
                              size: 20,
                              color: AppTheme.ru_dark_blue.withValues(alpha: 0.7),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                record!.subsidyNameThai ?? '-',
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontSize: 15,
                                  height: 1.4,
                                  color: isLightMode
                                      ? AppTheme.darkText
                                      : AppTheme.nearlyWhite.withValues(alpha: 0.9),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 12),

                        // Amount section with highlight
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.ru_yellow.withValues(alpha: 0.15),
                                AppTheme.ru_yellow.withValues(alpha: 0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppTheme.ru_yellow.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.payments_rounded,
                                    color: AppTheme.ru_dark_blue,
                                    size: 22,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'จำนวนเงิน',
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: 14,
                                      color: isLightMode
                                          ? AppTheme.ru_dark_blue.withValues(alpha: 0.7)
                                          : AppTheme.nearlyWhite.withValues(alpha: 0.7),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${NumberFormat('#,##0').format(record!.amount)} ฿',
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.ru_dark_blue,
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
        ),
      ),
    );
  }
}

String formatDateFromString(String date) {
  var parseDate = DateTime.parse(date);
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formattedDate = formatter.format(parseDate);
  return formattedDate;
}
