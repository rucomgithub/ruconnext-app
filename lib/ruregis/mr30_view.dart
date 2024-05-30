import 'package:get/get.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:th.ac.ru.uSmart/providers/ruregion_mr30_provider.dart';
import 'package:th.ac.ru.uSmart/utils/yeardropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../fitness_app/fitness_app_theme.dart';
import '../providers/mr30_provider.dart';
import 'package:badges/badges.dart' as badges;

class Mr30RuregisView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const Mr30RuregisView({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<Mr30RuregisView> createState() => _Mr30RuregisViewState();
}

class _Mr30RuregisViewState extends State<Mr30RuregisView> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    context.watch<MR30Provider>().getRuregisRecordMr30();
   // context.watch<RuregionProvider>().fetchMR30RUREGION();
    

    var mr30 = context.watch<MR30Provider>().mr30ruregisrecord;
   var mr30ruregion = context.watch<RuregionProvider>().mr30ruregionrec;
    var mr30prov = Provider.of<MR30Provider>(context, listen: false);
   var mr30ruregionprov = Provider.of<RuregionProvider>(context, listen: false);

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
                    AppTheme.ru_text_ocean_blue,
                    HexColor("#1B75BB")
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.grey.withOpacity(0.6),
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
                              color: AppTheme.white,
                              size: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              'รายการที่สนใจ ${mr30.length} รายการ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontSize: 11,
                                letterSpacing: 0.0,
                                color: AppTheme.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: badges.Badge(
                              badgeContent: Text('${mr30.length}'),
                              position:
                                  badges.BadgePosition.topEnd(top: -5, end: 0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.shopping_cart,
                                  size: 35,
                                  color: Color.fromARGB(255, 255, 238, 188),
                                ),
                                onPressed: () {
                                  Get.toNamed('/ruregiscart');
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: AppTheme.nearlyBlack,
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: AppTheme.ruFontKanit,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: AppTheme.white,
                          ),
                          //keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'ค้นหารหัสวิชา',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontSize: 14,
                              color: AppTheme.white,
                            ),
                            labelStyle: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0.2,
                              color: AppTheme.white,
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
