import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/model/manual_list_data.dart';
import 'package:th.ac.ru.uSmart/ruconnext_app_theme.dart';

class ManualListView extends StatelessWidget {
  const ManualListView(
      {Key? key,
      this.manualData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final ManualListData? manualData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: callback,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isLightMode
                            ? [
                                Colors.white,
                                Colors.white.withValues(alpha: 0.95),
                              ]
                            : [
                                AppTheme.nearlyBlack.withValues(alpha: 0.9),
                                AppTheme.nearlyBlack.withValues(alpha: 0.8),
                              ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isLightMode
                            ? Colors.grey.withValues(alpha: 0.15)
                            : Colors.white.withValues(alpha: 0.1),
                        width: 1.5,
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: isLightMode
                              ? Colors.grey.withValues(alpha: 0.15)
                              : Colors.black.withValues(alpha: 0.3),
                          offset: const Offset(0, 6),
                          blurRadius: 16.0,
                        ),
                        BoxShadow(
                          color: isLightMode
                              ? Colors.white.withValues(alpha: 0.5)
                              : Colors.white.withValues(alpha: 0.02),
                          offset: const Offset(0, -2),
                          blurRadius: 8.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 68,
                            height: 68,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                colors: [
                                  AppTheme.ru_dark_blue.withValues(alpha: 0.1),
                                  AppTheme.ru_dark_blue.withValues(alpha: 0.05),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              border: Border.all(
                                color: AppTheme.ru_dark_blue.withValues(alpha: 0.2),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.ru_dark_blue.withValues(alpha: 0.1),
                                  offset: const Offset(0, 4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                manualData!.imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  manualData!.titleTxt,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppTheme.ruFontKanit,
                                    color: isLightMode
                                        ? AppTheme.nearlyBlack
                                        : AppTheme.nearlyWhite,
                                    letterSpacing: -0.3,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (manualData!.subTxt.isNotEmpty) ...[
                                  const SizedBox(height: 6),
                                  Text(
                                    manualData!.subTxt,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: AppTheme.ruFontKanit,
                                      color: isLightMode
                                          ? Colors.grey[600]
                                          : Colors.grey[400],
                                      height: 1.4,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppTheme.ru_dark_blue.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              FontAwesomeIcons.chevronRight,
                              size: 16,
                              color: AppTheme.ru_dark_blue,
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
        );
      },
    );
  }
}
