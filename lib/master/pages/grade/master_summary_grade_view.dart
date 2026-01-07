import 'package:th.ac.ru.uSmart/app_theme.dart';
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
                      color: AppTheme.ru_yellow.withValues(alpha: 0.4),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(4, 4),
                    ),
                  ],
                ),
                child: prov.groupGrade.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'ไม่พบข้อมูล',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            // Circular Progress Chart - Top Section
                            Container(
                              margin: const EdgeInsets.only(bottom: 24),
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: AppTheme.white,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: AppTheme.ru_yellow.withOpacity(0.3),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.ru_yellow.withOpacity(0.2),
                                    offset: const Offset(0, 6),
                                    blurRadius: 16,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'หน่วยกิตสะสม',
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.ru_dark_blue,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Stack(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 160,
                                        height: 160,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 10,
                                            color: AppTheme.ru_dark_blue
                                                .withOpacity(0.15),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 12,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            TweenAnimationBuilder(
                                              tween: Tween<double>(
                                                  begin: 0.0, end: 1.0),
                                              duration: const Duration(
                                                  milliseconds: 2000),
                                              builder: (context, double value,
                                                  child) {
                                                return Opacity(
                                                  opacity: value,
                                                  child: Transform.scale(
                                                    scale: value,
                                                    child: Text(
                                                      '${prov.summaryCreditPass['PASS']!.toString()}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        fontFamily: AppTheme
                                                            .ruFontKanit,
                                                        fontSize: 42,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppTheme
                                                            .ru_dark_blue,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(height: 4),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                color: AppTheme.ru_yellow
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                'หน่วยกิต',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppTheme.ru_dark_blue,
                                                ),
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
                                                      50) /
                                                  100),
                                        ),
                                        child: const SizedBox(
                                          width: 160,
                                          height: 160,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.trending_up,
                                        color: AppTheme.ru_yellow,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'ความคืบหน้า ${((prov.grade.summaryCredit!.toInt() / 48) * 100).toStringAsFixed(1)}%',
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Grade Cards Section
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: prov.groupGrade.length,
                              itemBuilder:
                                  (BuildContext context, int childIndex) {
                                var key =
                                    prov.groupGrade.keys.elementAt(childIndex);
                                var value = prov.groupGrade.values
                                    .elementAt(childIndex);
                                final bool isEven = childIndex % 2 == 0;
                                final Color primaryColor = isEven
                                    ? AppTheme.ru_yellow
                                    : AppTheme.ru_dark_blue;
                                final Color secondaryColor = isEven
                                    ? AppTheme.ru_dark_blue
                                    : AppTheme.ru_yellow;

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(
                                      color: primaryColor,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryColor,
                                        offset: const Offset(0, 4),
                                        blurRadius: 12,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                primaryColor,
                                                primaryColor
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            boxShadow: [
                                              BoxShadow(
                                                color: primaryColor,
                                                offset: const Offset(0, 4),
                                                blurRadius: 8,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                key.length > 1
                                                    ? key.substring(0, 1)
                                                    : key,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 2),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  '${value['count']}',
                                                  style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'เกรด $key',
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppTheme.ru_dark_blue,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.assignment_turned_in,
                                                    size: 14,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    '${value['count']} วิชา',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppTheme.ruFontKanit,
                                                      fontSize: 12,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: primaryColor,
                                              width: 2,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                '${(int.parse(value['credit_sum'].toString()) * widget.animation!.value).toInt()}',
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                              Text(
                                                'หน่วยกิต',
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                  fontSize: 10,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
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
      ..color = Colors.black.withValues(alpha: 0.4)
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

    shdowPaint.color = Colors.grey.withValues(alpha: 0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withValues(alpha: 0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withValues(alpha: 0.1);
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
      ..strokeWidth = 16;
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
