import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/ui_view/grade_screen.dart';
import 'package:flutter/material.dart';
import 'gradeyear_screen.dart';
import 'rank_screen.dart';

class TitleView extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final AnimationController? animationController;
  final Animation<double>? animation;

  const TitleView(
      {Key? key,
      this.titleTxt: "",
      this.subTxt: "",
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
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        titleTxt,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: AppTheme.ruFontKanit,
                          fontSize: 18,
                          letterSpacing: 0.5,
                          color: AppTheme.ru_dark_blue,
                        ),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      onTap: () {
                        switch (titleTxt) {
                          case 'อันดับการลงทะเบียน':
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RankScreen(
                                      animationController:
                                          animationController!),
                                ));
                            break;
                          case 'สรุปรายการเกรด':
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GradeScreen(
                                      animationController:
                                          animationController!),
                                ));
                            break;
                          default:
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              subTxt,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontSize: 16,
                                letterSpacing: 0.5,
                                color: AppTheme.ru_text_ocean_blue,
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 26,
                              child: Icon(
                                Icons.arrow_forward,
                                color: AppTheme.ru_text_ocean_blue,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
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
