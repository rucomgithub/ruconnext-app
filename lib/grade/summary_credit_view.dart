import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/ui_view/wave_view.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:th.ac.ru.uSmart/providers/grade_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SummaryCreditView extends StatefulWidget {
  const SummaryCreditView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _SummaryCreditViewState createState() => _SummaryCreditViewState();
}

class _SummaryCreditViewState extends State<SummaryCreditView>
    with TickerProviderStateMixin {
  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    var prov = Provider.of<GradeProvider>(context, listen: false);
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: isLightMode ? AppTheme.nearlyWhite : AppTheme.ru_grey,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(40.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.ru_grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, bottom: 8),
                                      child: Text(
                                        'ผ่าน',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          letterSpacing: -0.2,
                                          color: AppTheme.ru_text_ocean_blue,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, bottom: 3),
                                      child: Text(
                                        '${prov.summaryCreditPass['PASS']!.toString()}',
                                        //'87',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 32,
                                          color: AppTheme.ru_text_ocean_blue,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, bottom: 8),
                                      child: Text(
                                        'หน่วยกิต',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          letterSpacing: -0.2,
                                          color: AppTheme.ru_text_ocean_blue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       left: 4, top: 2, bottom: 14),
                                //   child: Text(
                                //     'ผ่าน',
                                //     textAlign: TextAlign.center,
                                //     style: TextStyle(
                                //       fontFamily: AppTheme.ruFontKanit,
                                //       fontWeight: FontWeight.w500,
                                //       fontSize: 14,
                                //       letterSpacing: 0.0,
                                //       color: AppTheme.darkText,
                                //     ),
                                //   ),
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   crossAxisAlignment: CrossAxisAlignment.end,
                                //   children: <Widget>[
                                //     Padding(
                                //       padding: const EdgeInsets.only(
                                //           left: 4, bottom: 3),
                                //       child: Text(
                                //          '${prov.summaryCreditPass['NOT_PASS']!.toString()}',
                                //         //'100',
                                //         textAlign: TextAlign.center,
                                //         style: TextStyle(
                                //           fontFamily: AppTheme.ruFontKanit,
                                //           fontWeight: FontWeight.w600,
                                //           fontSize: 32,
                                //           color:
                                //               Color.fromARGB(255, 217, 92, 24),
                                //         ),
                                //       ),
                                //     ),
                                //     Padding(
                                //       padding: const EdgeInsets.only(
                                //           left: 8, bottom: 8),
                                //       child: Text(
                                //         'หน่วยกิต',
                                //         textAlign: TextAlign.center,
                                //         style: TextStyle(
                                //           fontFamily: AppTheme.ruFontKanit,
                                //           fontWeight: FontWeight.w500,
                                //           fontSize: 18,
                                //           letterSpacing: -0.2,
                                //           color:
                                //               Color.fromARGB(255, 217, 92, 24),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       left: 4, top: 2, bottom: 14),
                                //   child: Text(
                                //     'ไม่ผ่าน',
                                //     textAlign: TextAlign.center,
                                //     style: TextStyle(
                                //       fontFamily: AppTheme.ruFontKanit,
                                //       fontWeight: FontWeight.w500,
                                //       fontSize: 14,
                                //       letterSpacing: 0.0,
                                //       color: AppTheme.darkText,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, top: 8, bottom: 16),
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  color: AppTheme.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0)),
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 16),
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     crossAxisAlignment: CrossAxisAlignment.end,
                            //     children: <Widget>[
                            //       Row(
                            //         mainAxisAlignment: MainAxisAlignment.start,
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.center,
                            //         children: <Widget>[
                            //           Padding(
                            //             padding: const EdgeInsets.only(left: 4),
                            //             child: Icon(
                            //               Icons.abc,
                            //               color: AppTheme.ru_grey
                            //                   .withOpacity(1),
                            //               size: 20,
                            //             ),
                            //           ),
                            //           Padding(
                            //             padding:
                            //                 const EdgeInsets.only(left: 4.0),
                            //             child: Text(
                            //                'ลงทะเบียนเรียน ${prov.summaryCreditPass['PASS']! + prov.summaryCreditPass['NOT_PASS']!} หน่วยกิต',
                            //               //'ลงทะเบียนเรียน 195 หน่วยกิต',
                            //               textAlign: TextAlign.center,
                            //               style: TextStyle(
                            //                 fontFamily:
                            //                     AppTheme.ruFontKanit,
                            //                 fontWeight: FontWeight.w500,
                            //                 fontSize: 16,
                            //                 letterSpacing: 0.0,
                            //                 color: AppTheme.ru_grey
                            //                     .withOpacity(0.5),
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //       // Padding(
                            //       //   padding: const EdgeInsets.only(top: 4),
                            //       //   child: Row(
                            //       //     mainAxisAlignment:
                            //       //         MainAxisAlignment.start,
                            //       //     crossAxisAlignment:
                            //       //         CrossAxisAlignment.center,
                            //       //     children: <Widget>[
                            //       //       SizedBox(
                            //       //         width: 24,
                            //       //         height: 24,
                            //       //         child: Image.asset(
                            //       //             'assets/fitness_app/bell.png'),
                            //       //       ),
                            //       //       Flexible(
                            //       //         child: Text(
                            //       //           'Your bottle is empty, refill it!.',
                            //       //           textAlign: TextAlign.start,
                            //       //           style: TextStyle(
                            //       //             fontFamily:
                            //       //                 AppTheme.ruFontKanit,
                            //       //             fontWeight: FontWeight.w500,
                            //       //             fontSize: 12,
                            //       //             letterSpacing: 0.0,
                            //       //             color: HexColor('#F65283'),
                            //       //           ),
                            //       //         ),
                            //       //       ),
                            //       //     ],
                            //       //   ),
                            //       // ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   width: 34,
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: <Widget>[
                      //       Container(
                      //         decoration: BoxDecoration(
                      //           color: AppTheme.nearlyWhite,
                      //           shape: BoxShape.circle,
                      //           boxShadow: <BoxShadow>[
                      //             BoxShadow(
                      //                 color: AppTheme.nearlyDarkBlue
                      //                     .withOpacity(0.4),
                      //                 offset: const Offset(4.0, 4.0),
                      //                 blurRadius: 8.0),
                      //           ],
                      //         ),
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(6.0),
                      //           child: Icon(
                      //             Icons.add,
                      //             color: AppTheme.nearlyDarkBlue,
                      //             size: 24,
                      //           ),
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         height: 28,
                      //       ),
                      //       Container(
                      //         decoration: BoxDecoration(
                      //           color: AppTheme.nearlyWhite,
                      //           shape: BoxShape.circle,
                      //           boxShadow: <BoxShadow>[
                      //             BoxShadow(
                      //                 color: AppTheme.nearlyDarkBlue
                      //                     .withOpacity(0.4),
                      //                 offset: const Offset(4.0, 4.0),
                      //                 blurRadius: 8.0),
                      //           ],
                      //         ),
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(6.0),
                      //           child: Icon(
                      //             Icons.remove,
                      //             color: AppTheme.nearlyDarkBlue,
                      //             size: 24,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.only(left: 16, right: 8, top: 16),
                      //   child: Container(
                      //     width: 60,
                      //     height: 160,
                      //     decoration: BoxDecoration(
                      //       color: HexColor('#E8EDFE'),
                      //       borderRadius: const BorderRadius.only(
                      //           topLeft: Radius.circular(80.0),
                      //           bottomLeft: Radius.circular(80.0),
                      //           bottomRight: Radius.circular(80.0),
                      //           topRight: Radius.circular(80.0)),
                      //       boxShadow: <BoxShadow>[
                      //         BoxShadow(
                      //             color: AppTheme.ru_grey.withOpacity(0.4),
                      //             offset: const Offset(2, 2),
                      //             blurRadius: 4),
                      //       ],
                      //     ),
                      //     child: WaveView(
                      //       percentageValue: 1 *
                      //           100 /
                      //           (1 +
                      //               1),
                      //     ),
                      //   ),
                      // )
                    ],
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
