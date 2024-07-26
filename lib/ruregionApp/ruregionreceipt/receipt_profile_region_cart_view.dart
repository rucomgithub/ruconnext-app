import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:th.ac.ru.uSmart/providers/region_receipt_provider.dart';
import 'package:th.ac.ru.uSmart/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregion_check_cart.dart';
import 'package:th.ac.ru.uSmart/providers/ruregion_mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_provider.dart';
import '../../fitness_app/fitness_app_theme.dart';
import '../../utils/registeryeardropdown.dart';

class ReceiptProfileRegionCartView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const ReceiptProfileRegionCartView(
      {Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<ReceiptProfileRegionCartView> createState() =>
      _ReceiptProfileRegionCartViewState();
}

class _ReceiptProfileRegionCartViewState
    extends State<ReceiptProfileRegionCartView> {
  String? _selectedOption;
  bool isChecked = false;
  var dropdownvalue;
  @override
  void initState() {
    Provider.of<RuregionCheckCartProvider>(context, listen: false)
        .fetchLocationExam();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ruregisProv = context.watch<RuregisProvider>().ruregionApp;
    var locationexam = context.watch<RuregionReceiptProvider>().examLocate;
    var isGrad = context.watch<RuregionReceiptProvider>().isGrad;
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
                      Color.fromARGB(255, 214, 234, 251),
                      HexColor("#65ADFF")
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(68.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey.withOpacity(0.6),
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
          double screenWidth = MediaQuery.of(context).size.width;
          double screenHeight = MediaQuery.of(context).size.height;
          double baseFontSize =
              screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;
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
                      Color.fromARGB(255, 214, 234, 251),
                      HexColor("#65ADFF")
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey.withOpacity(0.6),
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
                                  overflow: TextOverflow.clip,
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontWeight: FontWeight.normal,
                                  fontSize: baseFontSize - 4,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Distribute space evenly
                            children: [
                             
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      '$locationexam',
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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Distribute space evenly
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Checkbox(
                                      checkColor: Colors.white,
                                      value: isGrad,
                                      onChanged: (bool? value) {
                                        null;
                                      },
                                    ),
                                    Text(
                                      'ขอจบ',
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
                        
                            ],
                          ),
                        ),
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
