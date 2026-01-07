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
                                Icons.calendar_today_rounded,
                                color: AppTheme.ru_yellow,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'ระบุปีการศึกษาที่สนใจ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  letterSpacing: 0.0,
                                  color: AppTheme.nearlyWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        RegisterYearDropdownWidget(),
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
                            children: <Widget>[
                              Icon(
                                Icons.class_rounded,
                                color: AppTheme.ru_yellow,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'จำนวนวิชาที่ลงทะเบียน',
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
                                  '${register.record == null ? "0" : register.record!.length} รายการ',
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
                        )
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
