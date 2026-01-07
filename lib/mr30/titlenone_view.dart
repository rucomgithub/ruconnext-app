import 'package:flutter/material.dart';

import '../app_theme.dart';

class TitleNoneView extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final AnimationController? animationController;
  final Animation<double>? animation;

  const TitleNoneView(
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
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            titleTxt,
                            textAlign: TextAlign.left,
                            style: AppTheme.header,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 4,
                      thickness: 4,
                      color: AppTheme.ru_yellow,
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
