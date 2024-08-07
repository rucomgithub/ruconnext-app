import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:th.ac.ru.uSmart/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../fitness_app/fitness_app_theme.dart';
import '../utils/registeryeardropdown.dart';

class RegisterView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const RegisterView({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    var register = context.watch<RegisterProvider>().register;

    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation!.value), 0.0),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
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
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: const Text(
                          'ระบุปีลงทะเบียนที่สนใจ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: AppTheme.ruFontKanit,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            letterSpacing: 0.0,
                            color: FitnessAppTheme.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RegisterYearDropdownWidget(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Icon(
                                Icons.list,
                                color: FitnessAppTheme.white,
                                size: 16,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                'จำนวนวิชาที่ลงทะเบียน ${register.record == null ? "0" : register.record!.length} รายการ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  letterSpacing: 0.0,
                                  color: FitnessAppTheme.white,
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(),
                            ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     color: FitnessAppTheme.nearlyWhite,
                            //     shape: BoxShape.circle,
                            //     boxShadow: <BoxShadow>[
                            //       BoxShadow(
                            //           color: FitnessAppTheme.nearlyBlack
                            //               .withOpacity(0.4),
                            //           offset: Offset(8.0, 8.0),
                            //           blurRadius: 8.0),
                            //     ],
                            //   ),
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(0.0),
                            //     child: Icon(
                            //       Icons.search,
                            //       color: HexColor("#6F56E8"),
                            //       size: 44,
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      )
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
