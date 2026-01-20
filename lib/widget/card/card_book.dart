import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';

class CardBook extends StatelessWidget {
  const CardBook(
      {Key? key,
      this.index,
      this.icondata,
      this.content,
      this.title,
      this.callback,
      this.animationController,
      this.animation})
      : super(key: key);
  final VoidCallback? callback;
  final int? index;
  final IconData? icondata;
  final String? title;
  final String? content;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: InkWell(
              highlightColor: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              onTap: callback,
              child: SizedBox(
                width: 150,
                height: 180,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: HexColor("#FF19196B").withValues(alpha: 0.6),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0),
                        ],
                        gradient: LinearGradient(
                          colors: <HexColor>[
                            HexColor("#FF19196B"),
                            HexColor("#FF1919EB"),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          topLeft: Radius.circular(48.0),
                          topRight: Radius.circular(8.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 18, left: 12, right: 12, bottom: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '$content',
                              style: AppTheme.content,
                              maxLines:
                                  4, // จำกัดจำนวนบรรทัดที่แสดงเป็น 1 บรรทัด
                              overflow: TextOverflow
                                  .ellipsis, // แสดง '...' หากข้อความยาวเกินไป
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  width: 110,
                                  decoration: BoxDecoration(
                                    color: AppTheme.nearlyWhite,
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(12.0),
                                      bottomLeft: Radius.circular(12.0),
                                      topLeft: Radius.circular(12.0),
                                      topRight: Radius.circular(12.0),
                                    ),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color:
                                              AppTheme.ru_grey.withValues(alpha: 0.4),
                                          offset: Offset(6.0, 6.0),
                                          blurRadius: 6.0),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(
                                      '$title',
                                      textAlign: TextAlign.center,
                                      style: AppTheme.body1,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 4,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppTheme.ru_yellow.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 8,
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: Icon(
                          icondata == null ? Icons.book : icondata,
                          size: 20,
                          color: AppTheme.ru_dark_blue,
                        ),
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
