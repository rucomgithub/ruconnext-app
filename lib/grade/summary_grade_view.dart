import 'package:th.ac.ru.uSmart/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../app_theme.dart';
import '../providers/grade_provider.dart';

class SummaryGradeView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const SummaryGradeView({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<SummaryGradeView> createState() => _SummaryGradeViewState();
}

class _SummaryGradeViewState extends State<SummaryGradeView> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<GradeProvider>(context, listen: false);
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;
    return prov.groupGrade.isEmpty
        ? SizedBox()
        : AnimatedBuilder(
            animation: widget.animationController!,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: widget.animation!,
                child: new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 30 * (1.0 - widget.animation!.value), 0.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/ID.png'),
                          fit: BoxFit.cover,
                          opacity: isLightMode ? 0.4 : 0.2,
                        ),
                        color: isLightMode
                            ? AppTheme.nearlyWhite
                            : AppTheme.ru_grey,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(24.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.ru_grey.withOpacity(0.2),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, top: 4),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: prov.groupGrade.length,
                                            itemBuilder: (BuildContext context,
                                                int childIndex) {
                                              var key = prov.groupGrade.keys
                                                  .elementAt(childIndex);
                                              var value = prov.groupGrade.values
                                                  .elementAt(childIndex);
                                              return Row(
                                                children: <Widget>[
                                                  Container(
                                                    height: 48,
                                                    width: 2,
                                                    decoration: BoxDecoration(
                                                      color: HexColor('#87A0E5')
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4.0)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4,
                                                                  bottom: 2),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                '${key} :',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      AppTheme
                                                                          .ruFontKanit,
                                                                  fontSize:
                                                                      baseFontSize -
                                                                          6,
                                                                  letterSpacing:
                                                                      -0.1,
                                                                  color: AppTheme
                                                                      .ru_text_ocean_blue,
                                                                ),
                                                              ),
                                                              Text(
                                                                ' ${value['count'].toString()} วิชา',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      AppTheme
                                                                          .ruFontKanit,
                                                                  fontSize:
                                                                      baseFontSize -
                                                                          6,
                                                                  letterSpacing:
                                                                      -0.1,
                                                                  color: AppTheme
                                                                      .ru_text_grey,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            // SizedBox(
                                                            //   width: 28,
                                                            //   height: 28,
                                                            //   child: Image.asset(
                                                            //       "assets/fitness_app/eaten.png"),
                                                            // ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 4,
                                                                      bottom:
                                                                          3),
                                                              child: Text(
                                                                '${(int.parse(value['credit_sum'].toString()) * widget.animation!.value).toInt()}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      AppTheme
                                                                          .ruFontKanit,
                                                                  fontSize:
                                                                      baseFontSize -
                                                                          6,
                                                                  color: AppTheme
                                                                      .ru_text_ocean_blue,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 4,
                                                                      bottom:
                                                                          3),
                                                              child: Text(
                                                                'หน่วยกิต',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      AppTheme
                                                                          .ruFontKanit,
                                                                  fontSize:
                                                                      baseFontSize -
                                                                          6,
                                                                  letterSpacing:
                                                                      -0.2,
                                                                  color: AppTheme
                                                                      .ru_text_grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Center(
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: <Widget>[
                                        Container(
                                          width: screenWidth * 0.35,
                                          height: screenWidth * 0.35,
                                          decoration: BoxDecoration(
                                            color: AppTheme.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  screenWidth * 0.35),
                                            ),
                                            border: new Border.all(
                                                width: 10,
                                                color: AppTheme.ru_dark_blue),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                '${prov.summaryCreditPass['PASS']!.toString()}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: baseFontSize,
                                                  color: AppTheme
                                                      .ru_text_light_blue,
                                                ),
                                              ),
                                              Text(
                                                'หน่วยกิตสะสม',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                  fontSize: baseFontSize - 6,
                                                  color: AppTheme.ru_text_grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        CustomPaint(
                                          painter: CurvePainter(
                                              colors: [
                                                HexColor("#F6C563"),
                                                HexColor("#F6C543"),
                                                HexColor("#F6C523")
                                              ],
                                              angle: 360 *
                                                  ((100 *
                                                          prov.summaryCreditPass[
                                                                  'PASS']!
                                                              .toInt() /
                                                          145) /
                                                      100)),
                                          child: SizedBox(
                                            width: screenWidth * 0.35,
                                            height: screenWidth * 0.35,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 8, bottom: 8),
                            child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                color: AppTheme.ru_grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 8, top: 8, bottom: 20),
                                child: Icon(
                                  Icons.abc,
                                  color: AppTheme.ru_text_ocean_blue,
                                  size: baseFontSize + 4,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 4, top: 8, bottom: 20),
                                child: Text(
                                  'ลงทะเบียนเรียนมาแล้ว ${prov.summaryCreditPass['PASS']! + prov.summaryCreditPass['NOT_PASS']!} หน่วยกิต',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontWeight: FontWeight.w500,
                                    fontSize: baseFontSize - 6,
                                    letterSpacing: 0.0,
                                    color: AppTheme.ru_dark_blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}

class CurvePainter extends CustomPainter {
  final double? angle;
  final List<Color>? colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = [];
    if (colors != null) {
      colorsList = colors ?? [];
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = new Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = new Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        paint);

    final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle! + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
