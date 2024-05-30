import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

class RadarChartWidget extends StatelessWidget {
  final List<String> grades;
  final List<int> counts;
  final List<int> ticks;

  RadarChartWidget(
      {required this.grades, required this.counts, required this.ticks});

  @override
  Widget build(BuildContext context) {
    final data = [counts];
    return RadarChart.light(
      ticks: ticks, // Customize the radar chart ticks as needed
      features: grades,
      data: data,
      reverseAxis: false,
      useSides: true,
    );
  }
}
