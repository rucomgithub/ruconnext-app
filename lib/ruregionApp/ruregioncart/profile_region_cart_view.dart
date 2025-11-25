import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:th.ac.ru.uSmart/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregion_check_cart.dart';
import 'package:th.ac.ru.uSmart/providers/ruregion_mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_provider.dart';
import '../../fitness_app/fitness_app_theme.dart';
import '../../utils/registeryeardropdown.dart';

class ProfileRegionCartView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const ProfileRegionCartView(
      {Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<ProfileRegionCartView> createState() => _ProfileRegionCartViewState();
}

class _ProfileRegionCartViewState extends State<ProfileRegionCartView> {
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
      return Column(
        children: [
          // ====== ส่วน Card เดิม (AnimatedBuilder) ======
          AnimatedBuilder(
            animation: widget.animationController!,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: widget.animation!,
                child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30 * (1.0 - widget.animation!.value), 0.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 16, bottom: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            HexColor("#D6E4FF"),
                            HexColor("#65ADFF"),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: FitnessAppTheme.grey.withOpacity(0.6),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${ruregisProv.nAMETHAI!}',
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontSize: 15,
                                color: FitnessAppTheme.nearlyBlack,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'รหัส ${ruregisProv.sTDCODE!}',
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontSize: 15,
                                color: FitnessAppTheme.nearlyBlack,
                              ),
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${ruregisProv.fACULTYNAMETHAI!}',
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 15,
                                    color: FitnessAppTheme.nearlyBlack,
                                  ),
                                ),
                                Text(
                                  'สาขา ${ruregisProv.mAJORNAMETHAI!}',
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 15,
                                    color: FitnessAppTheme.nearlyBlack,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // ====== Checkbox แยกออกมาข้างนอก ======
          // if (ruregisProv.gRADUATESTATUS!)
          //   Padding(
          //     padding: const EdgeInsets.only(top: 0.0, left: 24, right: 24),
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: Colors.white, // ✅ พื้นหลังสีขาว
          //         borderRadius: BorderRadius.circular(8.0), // ขอบมนเล็กน้อย
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black.withOpacity(0.1), // เงาเบา ๆ
          //             offset: const Offset(1, 1),
          //             blurRadius: 3,
          //           ),
          //         ],
          //       ),
          //       child: Padding(
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 8.0), // เว้นขอบใน
          //         child: Row(
          //           children: [
          //             Checkbox(
          //               checkColor: Colors.white,
          //               value: isChecked,
          //               onChanged: (bool? value) {
          //                 setState(() {
          //                   isChecked = value!;
          //                   final cartProv =
          //                       Provider.of<RuregionCheckCartProvider>(context,
          //                           listen: false);
          //                   cartProv.getStatusGraduate(value);
          //                   cartProv.checkButtonComfirm();
          //                 });
          //               },
          //             ),
          //             const Text(
          //               'ขอจบ',
          //               style: TextStyle(
          //                 fontSize: 15,
          //                 color: Colors.black87, // ให้ contrast กับพื้นหลังขาว
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      );
    }
  }
}
