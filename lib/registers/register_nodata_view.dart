import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:th.ac.ru.uSmart/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../fitness_app/fitness_app_theme.dart';

class RegisterNoDataView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;
  final String? titleTxt;
  final String? subTxt;

  const RegisterNoDataView({
    Key? key,
    this.animationController,
    this.animation,
    this.titleTxt,
    this.subTxt,
  }) : super(key: key);

  @override
  State<RegisterNoDataView> createState() => _RegisterNoDataViewState();
}

class _RegisterNoDataViewState extends State<RegisterNoDataView> {
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
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.nearlyWhite,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.red.withValues(alpha: 0.15),
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
                        Colors.red.shade400,
                        Colors.red.shade500,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.wifi_off_rounded,
                            color: Colors.white,
                            size: 48,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'เกิดปัญหาในการเชื่อมต่อ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: AppTheme.ruFontKanit,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 0.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.info_outline_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  'ไม่สามารถดึงข้อมูลได้\nกรุณาลองใหม่อีกครั้ง',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    height: 1.4,
                                    color: Colors.white,
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
