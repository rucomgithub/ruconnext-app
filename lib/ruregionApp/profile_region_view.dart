import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:th.ac.ru.uSmart/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_provider.dart';
import '../fitness_app/fitness_app_theme.dart';
import '../utils/registeryeardropdown.dart';

class ProfileRegionView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const ProfileRegionView({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<ProfileRegionView> createState() => _ProfileRegionViewState();
}

class _ProfileRegionViewState extends State<ProfileRegionView> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    var ruregisProv = context.watch<RuregisProvider>().ruregisApp;
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
                      HexColor("#045586")
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
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${ruregisProv.nAMETHAI!}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: AppTheme.ruFontKanit,
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                              letterSpacing: 0.0,
                              color: FitnessAppTheme.nearlyBlack,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  'รหัส : ${ruregisProv.sTDCODE!}',
                                  //  '${ruregisProv.fACULTYNAMETHAI!} สาขา${ruregisProv.mAJORNAMETHAI!} หลักสูตร${ruregisProv.cURRNAMETHAI!}  ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                    color: FitnessAppTheme.nearlyBlack,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 4),
                              //   child: Icon(
                              //     Icons.account_balance_sharp,
                              //     color: FitnessAppTheme.nearlyBlack,
                              //     size: 16,
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  //'คณะรัฐศาสตร์   สาขารัฐศาสตร์',
                                  '${ruregisProv.fACULTYNAMETHAI!} สาขา${ruregisProv.mAJORNAMETHAI!} ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                    color: FitnessAppTheme.nearlyBlack,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  '${ruregisProv.eRRMSG!} ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                    color: Color.fromARGB(255, 113, 113, 113),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 1, 18, 33),
                                  shape: BoxShape.circle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: FitnessAppTheme.nearlyBlack
                                            .withOpacity(0.4),
                                        offset: Offset(8.0, 8.0),
                                        blurRadius: 8.0),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    if (ruregisProv.sTDSTATUSCURRENT ==
                                        'A') ...[
                                      Icon(
                                        Icons.check,
                                        color: HexColor("#87A96B"),
                                        size: 44,
                                      ),
                                    ] else if (ruregisProv.sTDSTATUSCURRENT ==
                                        'B') ...[
                                      Icon(
                                        Icons.check,
                                        color: HexColor("#87A96B"),
                                        size: 44,
                                      ),
                                    ] else if (ruregisProv.sTDSTATUSCURRENT ==
                                        'C') ...[
                                      Icon(
                                        Icons.check,
                                        color: HexColor("#87A96B"),
                                        size: 44,
                                      ),
                                    ] else ...[
                                      Icon(
                                        Icons.close_rounded,
                                        color: HexColor("#F9856C"),
                                        size: 44,
                                      ),
                                    ],
                                  ],
                                ),
                              )
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
