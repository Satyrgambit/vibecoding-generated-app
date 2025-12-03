import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressAnalyticsScreen extends StatelessWidget {
  const ProgressAnalyticsScreen({Key? key}) : super(key: key);

  List<BarChartGroupData> _buildSampleData() {
    return List.generate(7, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [BarChartRodData(toY: (index + 1) * 10.0, color: Colors.teal)],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Placeholder sample bar chart
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Analytics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                    final day = days[value.toInt() % days.length];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(day),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
            ),
            borderData: FlBorderData(show: false),
            barGroups: _buildSampleData(),
          ),
        ),
      ),
    );
  }
}
