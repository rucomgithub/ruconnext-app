import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/model/rotcs_extend.dart';
import 'package:th.ac.ru.uSmart/ruconnext_app_theme.dart';

class RotcsExtendListView extends StatelessWidget {
  const RotcsExtendListView(
      {Key? key,
      this.rotcslData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final RotcsExtendDetail? rotcslData;
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
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            // AspectRatio(
                            //   aspectRatio: 2,
                            //   child: Image.asset(
                            //     rotcslData!.imagePath,
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            Container(
                              color: RuConnextAppTheme.buildLightTheme()
                                  .backgroundColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 8, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'ภาคการศึกษา ${rotcslData!.registerSemester} / ${rotcslData!.registerYear}',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'สอบผ่าน ${rotcslData!.credit} หน่วยกิต',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey
                                                          .withOpacity(0.8)),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'วันที่แก้ไข ${rotcslData!.modified}',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey
                                                          .withOpacity(0.8)),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Positioned(
                        //   top: 8,
                        //   right: 8,
                        //   child: Material(
                        //     color: Colors.transparent,
                        //     child: InkWell(
                        //       borderRadius: const BorderRadius.all(
                        //         Radius.circular(32.0),
                        //       ),
                        //       onTap: () {},
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Icon(
                        //           Icons.favorite_border,
                        //           color: RuConnextAppTheme.buildLightTheme()
                        //               .primaryColor,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // )
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
}
