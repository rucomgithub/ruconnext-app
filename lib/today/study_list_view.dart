import 'package:flutter/services.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/hotel_app_theme.dart';
import 'package:th.ac.ru.uSmart/pages/ru_map.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../model/mr30_model.dart';
import '../providers/mr30_provider.dart';
import '../utils/custom_functions.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/model/hotel_list_data.dart';

class StudyListView extends StatelessWidget {
  const StudyListView(
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
    var havetoday = context.watch<MR30Provider>();
    final bool isEven = (index ?? 0) % 2 == 0;
    final Color primaryColor =
        isEven ? AppTheme.ru_dark_blue : AppTheme.ru_yellow;
    final Color secondaryColor =
        isEven ? AppTheme.ru_yellow : AppTheme.ru_dark_blue;

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: callback,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: primaryColor,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withValues(alpha: 0.3),
                          offset: const Offset(0, 6),
                          blurRadius: 16,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Image Section with Gradient Overlay
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(18.0),
                                topRight: Radius.circular(18.0),
                              ),
                              child: SizedBox(
                                height: 120,
                                width: double.infinity,
                                child: FutureBuilder<Image>(
                                  future: imageFileExists(
                                      'assets/hotel/${record!.courseRoom.toString().trim().substring(0, 3)}.png'),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              primaryColor.withValues(alpha: 0.3),
                                              secondaryColor.withValues(alpha: 0.2),
                                            ],
                                          ),
                                        ),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              primaryColor,
                                            ),
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              primaryColor.withValues(alpha: 0.2),
                                              secondaryColor.withValues(alpha: 0.15),
                                            ],
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            // Background pattern
                                            Positioned.fill(
                                              child: Opacity(
                                                opacity: 0.1,
                                                child: Icon(
                                                  Icons.domain,
                                                  size: 80,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                            // Content
                                            Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.all(12),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withValues(alpha: 0.1),
                                                          offset: const Offset(0, 2),
                                                          blurRadius: 8,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Icon(
                                                      Icons.apartment,
                                                      color: primaryColor,
                                                      size: 28,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'ไม่พบรูปอาคาร',
                                                    style: TextStyle(
                                                      fontFamily: AppTheme.ruFontKanit,
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w600,
                                                      color: primaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return snapshot.data!;
                                    }
                                  },
                                ),
                              ),
                            ),
                            // Gradient Overlay
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withValues(alpha: 0.1),
                                    ],
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(18.0),
                                    topRight: Radius.circular(18.0),
                                  ),
                                ),
                              ),
                            ),
                            // Favorite/Register Icon
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.2),
                                      offset: const Offset(0, 2),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: record!.register == false
                                    ? InkWell(
                                        borderRadius: BorderRadius.circular(32.0),
                                        onTap: () => havetoday.addMR30(record!),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.favorite_border_rounded,
                                            color: primaryColor,
                                            size: 24,
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.app_registration,
                                          color: const Color(0xFFFF8A53),
                                          size: 24,
                                        ),
                                      ),
                              ),
                            ),
                            // Year/Semester Badge
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.2),
                                      offset: const Offset(0, 2),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '${record!.courseYear}/${record!.courseSemester}',
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Content Section
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Course Number
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${record!.courseNo}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppTheme.ruFontKanit,
                                        color: AppTheme.ru_dark_blue,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '${record!.courseCredit} หน่วยกิต',
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Day and Time
                              Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    size: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      '${record!.dayNameS} ${record!.timePeriod}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: AppTheme.ruFontKanit,
                                        color: Colors.grey.shade700,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),

                              // Location
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RuMap(),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.locationDot,
                                      size: 14,
                                      color: primaryColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Flexible(
                                      child: Text(
                                        '${record!.courseRoom}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: AppTheme.ruFontKanit,
                                          color: primaryColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Instructor
                              Row(
                                children: [
                                  Icon(
                                    Icons.person_outline,
                                    size: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      '${record!.courseInstructor}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: AppTheme.ruFontKanit,
                                        color: Colors.grey.shade700,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
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
        );
      },
    );
  }

  Text TimeStudy(String periodtime) {
    String strcheck = StringTimeStudy(periodtime.toString());
    return Text(
      strcheck,
      style: TextStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 189, 22, 22).withValues(alpha: 0.8)),
    );
  }

  Future<Image> imageFileExists(String path) async {
    try {
      await rootBundle.load(path);
      return Image.asset(
        path,
        fit: BoxFit.cover,
      );
    } catch (e) {
      return Image.asset(
        'assets/fitness_app/banner2.png',
        fit: BoxFit.cover,
      );
    }
  }
}
