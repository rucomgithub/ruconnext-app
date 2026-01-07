import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_provider.dart';
import '../../fitness_app/fitness_app_theme.dart';

class ProfileCartView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const ProfileCartView({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<ProfileCartView> createState() => _ProfileCartViewState();
}

class _ProfileCartViewState extends State<ProfileCartView> {
  String? _selectedOption;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    var ruregisProv = context.watch<RuregisProvider>().ruregisApp;
    var mr30ruregisrec = context.watch<RUREGISMR30Provider>().mr30ruregionrec;
    var sumcredit = context.watch<RUREGISMR30Provider>().sumIntCredit;
    print('view $ruregisProv');

    var loading = context.watch<RuregisProvider>().isLoadingRuregisProfile;
    if (loading) {
      return AnimatedBuilder(
        animation: widget.animationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: widget.animation!,
            child: new Transform(
              transform: new Matrix4.translationValues(
                  0.0, 30 * (1.0 - widget.animation!.value), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 16, bottom: 18),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 251, 247, 214),
                      HexColor("#F0DC82")
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(68.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey.withValues(alpha: 0.6),
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(),
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
    } else {
      return AnimatedBuilder(
        animation: widget.animationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: widget.animation!,
            child: new Transform(
              transform: new Matrix4.translationValues(
                  0.0, 30 * (1.0 - widget.animation!.value), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 16, bottom: 18),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 251, 247, 214),
                      HexColor("#F0DC82")
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey.withValues(alpha: 0.6),
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Distribute space evenly
                            children: [
                              Text(
                                '${ruregisProv.nAMETHAI!}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  letterSpacing: 0.0,
                                  color: FitnessAppTheme.nearlyBlack,
                                ),
                              ),
                              Text(
                                'รหัส ${ruregisProv.sTDCODE!}', // Your right-aligned text
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  letterSpacing: 0.0,
                                  color: FitnessAppTheme.nearlyBlack,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Distribute space evenly
                            children: [
                              Text(
                                '${ruregisProv.fACULTYNAMETHAI!}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  letterSpacing: 0.0,
                                  color: FitnessAppTheme.nearlyBlack,
                                ),
                              ),
                              Text(
                                ' สาขา${ruregisProv.mAJORNAMETHAI!}', // Your right-aligned text
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  letterSpacing: 0.0,
                                  color: FitnessAppTheme.nearlyBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 4),
                        //   child: Row(
                        //     crossAxisAlignment: CrossAxisAlignment.end,
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: <Widget>[
                        //       Padding(
                        //         padding: const EdgeInsets.only(left: 4.0),
                        //         child: Text(
                        //           //'คณะรัฐศาสตร์   สาขารัฐศาสตร์',
                        //           '${ruregisProv.fACULTYNAMETHAI!} สาขา${ruregisProv.mAJORNAMETHAI!} ',
                        //           textAlign: TextAlign.center,
                        //           style: TextStyle(
                        //             fontFamily: AppTheme.ruFontKanit,
                        //             fontWeight: FontWeight.w500,
                        //             fontSize: 14,
                        //             letterSpacing: 0.0,
                        //             color: FitnessAppTheme.nearlyBlack,
                        //           ),
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: SizedBox(),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: [
                                    Checkbox(
                                      checkColor: Colors.white,
                                      value: isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isChecked = value!;
                                        });
                                      },
                                    ),
                                    Text('ขอจบ'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 4.0),
                              //   child: Text(
                              //     '${sumcredit} หน่วยกิต',
                              //     textAlign: TextAlign.start,
                              //     style: TextStyle(
                              //       fontFamily: AppTheme.ruFontKanit,
                              //       fontWeight: FontWeight.w500,
                              //       fontSize: 20,
                              //       letterSpacing: 0.0,
                              //       color: FitnessAppTheme.nearlyBlack,
                              //     ),
                              //   ),
                              // ),
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
}
