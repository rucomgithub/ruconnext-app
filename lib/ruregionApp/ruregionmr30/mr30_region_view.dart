import 'package:get/get.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_mr30_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/mr30_provider.dart';
import 'package:badges/badges.dart' as badges;

class RuregionMr30View extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const RuregionMr30View({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<RuregionMr30View> createState() => _RuregionMr30ViewState();
}

class _RuregionMr30ViewState extends State<RuregionMr30View> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    var mr30 = context.watch<MR30Provider>().mr30record;
    var mr30prov = Provider.of<RUREGISMR30Provider>(context, listen: false);
    var mr30ruregisrec = context.watch<RUREGISMR30Provider>().mr30ruregionrec;

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
                      topRight: Radius.circular(45.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.grey.withValues(alpha: 0.6),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Icon(
                              Icons.list,
                              color: AppTheme.nearlyBlack,
                              size: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              'รายการที่สนใจ ${mr30ruregisrec.length} รายการ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontSize: 11,
                                letterSpacing: 0.0,
                                color: AppTheme.nearlyBlack,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: badges.Badge(
                              badgeContent: Text(
                                '${mr30ruregisrec.length}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              position:
                                  badges.BadgePosition.topEnd(top: -5, end: 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                          alpha: 0.25), // Shadow color
                                      spreadRadius: 1, // Spread radius
                                      blurRadius: 30, // Blur radius
                                      offset: Offset(
                                          1, 3), // Shadow position (x, y)
                                    ),
                                  ],
                                  shape: BoxShape
                                      .circle, // To keep the shadow circular
                                ),
                                child: ClipOval(
                                  child: ElevatedButton(
                                    onPressed: mr30ruregisrec.length == 0
                                        ? null
                                        : () {
                                            Get.toNamed('/ruregionAppcart');
                                          },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.resolveWith<
                                              Color>((Set<WidgetState> states) {
                                        if (mr30ruregisrec.length == 0) {
                                          return Color.fromARGB(255, 205, 203,
                                              203); // Color when the length is 0
                                        } else {
                                          return Color.fromARGB(255, 214, 234,
                                              251); // Default color
                                        }
                                      }),
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              70.0), // Circular shape
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          8.0), // Optional padding
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Icon(Icons.shopping_cart,
                                            size: 18,
                                            color: AppTheme
                                                .nearlyBlack // Desired color
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 207, 207, 207),
                                HexColor("#D6E4FF")
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                              topRight: Radius.circular(30.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: AppTheme.grey.withValues(alpha: 0.6),
                                offset: Offset(1.1, 1.1),
                                blurRadius: 0.5),
                          ],
                        ),
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: AppTheme.ruFontKanit,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: AppTheme.nearlyBlack,
                          ),
                          //keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'ค้นหารหัสวิชา',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontSize: 14,
                              color: AppTheme.nearlyBlack,
                            ),
                            labelStyle: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyBlack,
                            ),
                          ),
                          onChanged: (value) {
                            mr30prov.filterMr30(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[],
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
