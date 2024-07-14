import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:th.ac.ru.uSmart/utils/yeardropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../fitness_app/fitness_app_theme.dart';
import '../providers/mr30_provider.dart';

class Mr30View extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const Mr30View({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<Mr30View> createState() => _Mr30ViewState();
}

class _Mr30ViewState extends State<Mr30View> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    var mr30 = context.watch<MR30Provider>().mr30record;
    var mr30prov = Provider.of<MR30Provider>(context, listen: false);

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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          YearDropdownWidget(),
                          Expanded(
                            child: SizedBox(),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
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
