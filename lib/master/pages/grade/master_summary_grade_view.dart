import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/master/providers/master_grade_provider.dart';
import 'dart:math' as math;

class MasterSummaryGradeView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const MasterSummaryGradeView(
      {Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<MasterSummaryGradeView> createState() => _MasterSummaryGradeViewState();
}

class _MasterSummaryGradeViewState extends State<MasterSummaryGradeView> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MasterGradeProvider>(context, listen: false);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;

    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 100 * (1.0 - widget.animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/ID.png'),
                    fit: BoxFit.cover,
                    opacity: 0.6,
                  ),
                  color: AppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(38.0),
                      topRight: Radius.circular(48.0)),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.ru_yellow.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(4, 4),
                    ),
                  ],
                ),
                child: prov.groupGrade.isEmpty
                    ? Text('ไม่พบข้อมูล')
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: prov.groupGrade.length,
                                    itemBuilder:
                                        (BuildContext context, int childIndex) {
                                      var key = prov.groupGrade.keys
                                          .elementAt(childIndex);
                                      var value = prov.groupGrade.values
                                          .elementAt(childIndex);
                                      return Container(
                                        color: Colors.white,
                                        width: screenWidth * 0.1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: baseFontSize + 60,
                                                    width: 2,
                                                    decoration: BoxDecoration(
                                                      color: childIndex % 2 == 0
                                                          ? AppTheme.ru_yellow
                                                          : AppTheme
                                                              .ru_dark_blue,
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
                                                              .spaceBetween,
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              AppTheme
                                                                  .ru_dark_blue,
                                                          radius: 16,
                                                          child: Text(
                                                            '${key}',
                                                            style: TextStyle(
                                                              fontFamily: AppTheme
                                                                  .ruFontKanit,
                                                              fontSize:
                                                                  baseFontSize -
                                                                      8,
                                                              color: AppTheme
                                                                  .white,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                AppTheme
                                                                    .ru_yellow,
                                                            radius: 16,
                                                            child: Text(
                                                              '${value['count'].toString()}',
                                                              style: TextStyle(
                                                                fontFamily: AppTheme
                                                                    .ruFontKanit,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    baseFontSize,
                                                                color: AppTheme
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${(int.parse(value['credit_sum'].toString()) * widget.animation!.value).toInt()}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.ruFontKanit,
                                                    fontSize: baseFontSize - 8,
                                                    color:
                                                        AppTheme.ru_text_grey,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  'หน่วยกิต',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.ruFontKanit,
                                                    fontSize: baseFontSize - 8,
                                                    color:
                                                        AppTheme.ru_text_grey,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16.0, right: 8.0),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: <Widget>[
                                  Container(
                                    width: screenWidth * 0.45,
                                    height: screenWidth * 0.45,
                                    decoration: BoxDecoration(
                                      color: AppTheme.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(screenWidth * 0.45),
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
                                        TweenAnimationBuilder(
                                          tween: Tween<double>(
                                              begin: 0.0, end: 1.0),
                                          duration:
                                              Duration(milliseconds: 2000),
                                          builder:
                                              (context, double value, child) {
                                            return Opacity(
                                              opacity: value,
                                              child: Transform.scale(
                                                scale: value,
                                                child: Text(
                                                  '${prov.summaryCreditPass['PASS']!.toString()}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.ruFontKanit,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: baseFontSize + 24,
                                                    letterSpacing: 0.0,
                                                    color: AppTheme
                                                        .ru_text_light_blue,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        Text(
                                          'หน่วยกิตสะสม',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.ruFontKanit,
                                            fontSize: baseFontSize - 8,
                                            letterSpacing: 0.0,
                                            color: AppTheme.nearlyBlack,
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
                                                    prov.grade.summaryCredit!
                                                        .toInt() /
                                                    48) /
                                                100)),
                                    child: SizedBox(
                                      width: screenWidth * 0.45,
                                      height: screenWidth * 0.45,
                                    ),
                                  )
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
