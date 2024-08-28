import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';

class CardBookTitle extends StatelessWidget {
  const CardBookTitle(
      {Key? key,
      this.iconheader,
      this.iconfooter,
      this.header,
      this.footer,
      this.title,
      this.content,
      this.animationController,
      this.animation})
      : super(key: key);
  final IconData? iconheader;
  final IconData? iconfooter;
  final String? header;
  final String? footer;
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
              onTap: () {
                // ondemand.ondemand.rECORD.detail.isEmpty
                // print(ondemand.error);
              },
              child: SizedBox(
                width: 180,
                height: 240,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: HexColor("#FF19196B").withOpacity(0.6),
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
                            top: 50, left: 16, right: 16, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 140,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        title != ''
                                            ? Text(
                                                '$title',
                                                maxLines: 1,
                                                style: AppTheme.cardTitle,
                                              )
                                            : SizedBox(),
                                        Text(
                                          '${content ?? ''}',
                                          maxLines: 6,
                                          style: AppTheme.cardContent,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppTheme.nearlyWhite,
                                    shape: BoxShape.circle,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: AppTheme.nearlyBlack
                                              .withOpacity(0.4),
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 4.0),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      iconfooter == null
                                          ? Icons.book
                                          : iconfooter,
                                      size: 24,
                                      color: AppTheme.ru_dark_blue,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: SizedBox(
                                      width: 100,
                                      child: Text(
                                        maxLines: 1,
                                        '${footer ?? ''}',
                                        style: AppTheme.cardFooter,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 4,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppTheme.ru_yellow.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 8,
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: Icon(
                          iconheader == null ? Icons.book : iconheader,
                          size: 24,
                          color: AppTheme.ru_dark_blue,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 50,
                      child: SizedBox(
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              maxLines: 1,
                              '${header ?? ''}',
                              style: AppTheme.cardHeader,
                            ),
                            Divider(
                              height: 4,
                              thickness: 2,
                              color: AppTheme.ru_yellow,
                            )
                          ],
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
