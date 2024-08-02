import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:flutter/material.dart';

class InsuranceInfoView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const InsuranceInfoView({Key? key, this.animationController, this.animation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 16, bottom: 8),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.ru_grey.withOpacity(0.3),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            // boxShadow: <BoxShadow>[
                            //   BoxShadow(
                            //       color: AppTheme.grey.withOpacity(0.2),
                            //       offset: Offset(1.1, 1.1),
                            //       blurRadius: 10.0),
                            // ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 60, bottom: 12, right: 16, top: 12),
                                child: Text(
                                  'ข้อมูลกรมธรรม์ประกันภัย จะทำการอัปเดตทุกวันที่ 7 ของเดือน โดยกองกิจการนักศึกษา',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    letterSpacing: 0.0,
                                    color: AppTheme.ru_dark_blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -12,
                        left: 0,
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.asset("assets/fitness_app/tab_1.png"),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
