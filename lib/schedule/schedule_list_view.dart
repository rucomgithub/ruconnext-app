import 'dart:math';
import 'package:th.ac.ru.uSmart/model/schedule.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../utils/custom_functions.dart';

class ScheduleListView extends StatelessWidget {
  const ScheduleListView(
      {Key? key,
      this.index,
      this.record,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);
  final int? index;
  final Schedule? record;
  final VoidCallback? callback;
  final AnimationController? animationController;
  final Animation<double>? animation;

  // List of images from assets/hotel
  static const List<String> hotelImages = [
    'assets/hotel/BPB.png',
    'assets/hotel/ECB.png',
    'assets/hotel/HUB.png',
    'assets/hotel/KLB.png',
    'assets/hotel/KMB.png',
    'assets/hotel/LAW.png',
    'assets/hotel/LOB.png',
    'assets/hotel/NMB.png',
    'assets/hotel/PBB.png',
    'assets/hotel/SBB.png',
    'assets/hotel/SCO.png',
    'assets/hotel/SRI.png',
    'assets/hotel/SWB.png',
    'assets/hotel/VPB.png',
  ];

  // Get random image based on index
  String getRandomImage() {
    final random = Random(index ?? 0);
    return hotelImages[random.nextInt(hotelImages.length)];
  }


  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

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
                  left: 16, right: 16, top: 8, bottom: 8),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: isLightMode
                            ? Colors.grey.withValues(alpha: 0.3)
                            : Colors.black.withValues(alpha: 0.4),
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
                      child: Column(
                        children: <Widget>[
                          // Image with overlay gradient
                          Stack(
                            children: [
                              AspectRatio(
                                aspectRatio: 2.5,
                                child: Image.asset(
                                  getRandomImage(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // Gradient overlay
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        AppTheme.ru_dark_blue.withValues(alpha: 0.7),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Date badge
                              Positioned(
                                top: 12,
                                left: 12,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppTheme.ru_yellow,
                                        AppTheme.ru_yellow.withValues(alpha: 0.8),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.2),
                                        offset: Offset(0, 2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.calendar_today_rounded,
                                        size: 14,
                                        color: AppTheme.ru_dark_blue,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        '${formatDate(record!.startDate)} - ${formatDate(record!.endDate)}',
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.ru_dark_blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Content section
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Event name
                                Row(
                                  children: [
                                    Icon(
                                      Icons.event_note_rounded,
                                      size: 22,
                                      color: AppTheme.ru_dark_blue,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        record!.eventName,
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isLightMode
                                              ? AppTheme.ru_dark_blue
                                              : AppTheme.nearlyWhite,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
            
                                SizedBox(height: 12),

                                // Status indicator
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: commingTime(
                                                  DateTime.parse(
                                                      record!.startDate),
                                                  DateTime.now(),
                                                  DateTime.parse(record!.endDate))
                                              .contains('กิจกรรมนี้หมดเวลาแล้ว')
                                          ? [
                                              Colors.grey.withValues(alpha: 0.2),
                                              Colors.grey.withValues(alpha: 0.1),
                                            ]
                                          : commingTime(
                                                      DateTime.parse(
                                                          record!.startDate),
                                                      DateTime.now(),
                                                      DateTime.parse(
                                                          record!.endDate))
                                                  .contains('กิจกรรมได้เริ่มขึ้นแล้ว')
                                              ? [
                                                  Colors.green.withValues(alpha: 0.2),
                                                  Colors.green.withValues(alpha: 0.1),
                                                ]
                                              : [
                                                  AppTheme.ru_yellow.withValues(alpha: 0.2),
                                                  AppTheme.ru_yellow.withValues(alpha: 0.1),
                                                ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: commingTime(
                                                  DateTime.parse(
                                                      record!.startDate),
                                                  DateTime.now(),
                                                  DateTime.parse(record!.endDate))
                                              .contains('กิจกรรมนี้หมดเวลาแล้ว')
                                          ? Colors.grey.withValues(alpha: 0.3)
                                          : commingTime(
                                                      DateTime.parse(
                                                          record!.startDate),
                                                      DateTime.now(),
                                                      DateTime.parse(
                                                          record!.endDate))
                                                  .contains('กิจกรรมได้เริ่มขึ้นแล้ว')
                                              ? Colors.green.withValues(alpha: 0.4)
                                              : AppTheme.ru_yellow.withValues(alpha: 0.4),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        commingTime(
                                                    DateTime.parse(
                                                        record!.startDate),
                                                    DateTime.now(),
                                                    DateTime.parse(
                                                        record!.endDate))
                                                .contains('กิจกรรมนี้หมดเวลาแล้ว')
                                            ? Icons.event_busy_rounded
                                            : commingTime(
                                                        DateTime.parse(
                                                            record!.startDate),
                                                        DateTime.now(),
                                                        DateTime.parse(
                                                            record!.endDate))
                                                    .contains('กิจกรรมได้เริ่มขึ้นแล้ว')
                                                ? Icons.event_available_rounded
                                                : Icons.schedule_rounded,
                                        size: 18,
                                        color: commingTime(
                                                    DateTime.parse(
                                                        record!.startDate),
                                                    DateTime.now(),
                                                    DateTime.parse(
                                                        record!.endDate))
                                                .contains('กิจกรรมนี้หมดเวลาแล้ว')
                                            ? Colors.grey
                                            : commingTime(
                                                        DateTime.parse(
                                                            record!.startDate),
                                                        DateTime.now(),
                                                        DateTime.parse(
                                                            record!.endDate))
                                                    .contains('กิจกรรมได้เริ่มขึ้นแล้ว')
                                                ? Colors.green
                                                : AppTheme.ru_dark_blue,
                                      ),
                                      SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          commingTime(
                                              DateTime.parse(record!.startDate),
                                              DateTime.now(),
                                              DateTime.parse(record!.endDate)),
                                          style: TextStyle(
                                            fontFamily: AppTheme.ruFontKanit,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: commingTime(
                                                        DateTime.parse(
                                                            record!.startDate),
                                                        DateTime.now(),
                                                        DateTime.parse(
                                                            record!.endDate))
                                                    .contains('กิจกรรมนี้หมดเวลาแล้ว')
                                                ? Colors.grey
                                                : commingTime(
                                                            DateTime.parse(
                                                                record!.startDate),
                                                            DateTime.now(),
                                                            DateTime.parse(
                                                                record!.endDate))
                                                        .contains('กิจกรรมได้เริ่มขึ้นแล้ว')
                                                    ? Colors.green.shade700
                                                    : AppTheme.ru_dark_blue,
                                          ),
                                        ),
                                      ),
                                    ],
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
        );
      },
    );
  }
}
