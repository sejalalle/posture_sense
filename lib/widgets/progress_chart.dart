import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProgressChart extends StatelessWidget {
  final List<double> scores;

  const ProgressChart({
    super.key,
    required this.scores,
  });

  @override
  Widget build(BuildContext context) {
    if (scores.isEmpty) {
      return const SizedBox(
        height: 220,
        child: Center(
          child: Text("No data available"),
        ),
      );
    }

    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          borderData: FlBorderData(show: true),
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(show: true),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              spots: List.generate(
                scores.length,
                (index) => FlSpot(
                  index.toDouble(),
                  scores[index],
                ),
              ),
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}