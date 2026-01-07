import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:flutter/material.dart';
import '../model/ondemand.dart';

class OndemandListView extends StatelessWidget {
  const OndemandListView(
      {Key? key,
      this.index,
      this.record,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);
  final int? index;
  final Detail? record;
  final VoidCallback? callback;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return ListOndemand(
            animation: animation, callback: callback, record: record);
      },
    );
  }
}

class ListOndemand extends StatelessWidget {
  const ListOndemand({
    super.key,
    required this.animation,
    required this.callback,
    required this.record,
  });

  final Animation<double>? animation;
  final VoidCallback? callback;
  final Detail? record;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    return FadeTransition(
      opacity: animation!,
      child: Transform(
        transform:
            Matrix4.translationValues(0.0, 50 * (1.0 - animation!.value), 0.0),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: callback,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                gradient: LinearGradient(
                  colors: [
                    AppTheme.ru_dark_blue.withValues(alpha: 0.05),
                    AppTheme.ru_yellow.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: AppTheme.ru_dark_blue.withValues(alpha: 0.1),
                  width: 1,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: isLightMode
                        ? Colors.grey.withValues(alpha: 0.2)
                        : Colors.black.withValues(alpha: 0.3),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                child: Container(
                  color: isLightMode
                      ? AppTheme.nearlyWhite
                      : AppTheme.nearlyBlack.withValues(alpha: 0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Header row with video icon and session info
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppTheme.ru_dark_blue,
                                    AppTheme.ru_dark_blue.withValues(alpha: 0.7),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.ru_dark_blue.withValues(alpha: 0.3),
                                    offset: Offset(0, 2),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.play_circle_filled_rounded,
                                color: AppTheme.ru_yellow,
                                size: 28,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (record!.audioSec != "")
                                    Text(
                                      'ครั้งที่ ${record!.audioSec}',
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: isLightMode
                                            ? AppTheme.ru_dark_blue
                                            : AppTheme.nearlyWhite,
                                      ),
                                    ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_rounded,
                                        size: 12,
                                        color: AppTheme.ru_dark_blue.withValues(alpha: 0.6),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '${record!.audioCreate}',
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 12,
                                          color: isLightMode
                                              ? AppTheme.ru_dark_blue.withValues(alpha: 0.6)
                                              : AppTheme.nearlyWhite.withValues(alpha: 0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16),

                        // Divider
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.ru_dark_blue.withValues(alpha: 0.1),
                                AppTheme.ru_yellow.withValues(alpha: 0.1),
                                AppTheme.ru_dark_blue.withValues(alpha: 0.1),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 16),

                        // Status badge
                        if (record!.audioStatus != "")
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppTheme.ru_yellow.withValues(alpha: 0.15),
                                  AppTheme.ru_yellow.withValues(alpha: 0.05),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppTheme.ru_yellow.withValues(alpha: 0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.info_outline_rounded,
                                  color: AppTheme.ru_dark_blue,
                                  size: 18,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '${record!.audioStatus}',
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.ru_dark_blue,
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
        ),
      ),
    );
  }
}
