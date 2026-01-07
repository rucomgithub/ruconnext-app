import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:th.ac.ru.uSmart/utils/yeardropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                  left: 16, right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.nearlyWhite,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.ru_dark_blue.withValues(alpha: 0.15),
                        offset: const Offset(0, 4),
                        blurRadius: 12.0,
                        spreadRadius: 0),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.ru_dark_blue,
                        AppTheme.ru_dark_blue.withValues(alpha: 0.9),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppTheme.ru_yellow.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.search_rounded,
                                color: AppTheme.ru_yellow,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'ค้นหาและกรองข้อมูล',
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: AppTheme.nearlyWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        YearDropdownWidget(),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: AppTheme.nearlyWhite,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            style: TextStyle(
                              fontFamily: AppTheme.ruFontKanit,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: AppTheme.ru_dark_blue,
                            ),
                            decoration: InputDecoration(
                              labelText: 'ค้นหารหัสวิชา',
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppTheme.ru_dark_blue.withValues(alpha: 0.5),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: AppTheme.nearlyWhite,
                              labelStyle: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontSize: 14,
                                color: AppTheme.ru_dark_blue.withValues(alpha: 0.6),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                            ),
                            onChanged: (value) {
                              mr30prov.filterMr30(value);
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppTheme.ru_yellow.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppTheme.ru_yellow.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.bookmark_rounded,
                                color: AppTheme.ru_yellow,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'รายการที่สนใจ',
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: AppTheme.nearlyWhite.withValues(alpha: 0.9),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppTheme.ru_yellow,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${mr30.length}',
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: AppTheme.ru_dark_blue,
                                  ),
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
          ),
        );
      },
    );
  }
}
