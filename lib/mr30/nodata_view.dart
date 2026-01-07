import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:flutter/material.dart';

class NoDataView extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final AnimationController? animationController;
  final Animation<double>? animation;

  const NoDataView(
      {Key? key,
      this.titleTxt = "",
      this.subTxt = "",
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.nearlyDarkBlue
                            .withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.search_off_rounded,
                        size: 64,
                        color: FitnessAppTheme.nearlyDarkBlue
                            .withValues(alpha: 0.5),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      titleTxt.isNotEmpty ? titleTxt : 'ไม่พบข้อมูล',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: FitnessAppTheme.fontName,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: FitnessAppTheme.darkerText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      subTxt.isNotEmpty
                          ? subTxt
                          : 'ลองค้นหาด้วยคำอื่นหรือปรับเปลี่ยนตัวกรอง',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: FitnessAppTheme.fontName,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: FitnessAppTheme.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
