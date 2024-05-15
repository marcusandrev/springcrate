import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyChart extends StatelessWidget {
  final Map<String, int> monthlySales;

  const MyChart({Key? key, required this.monthlySales}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      mainBarData(),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 20,
          color: Colors.blue,
        ),
      ],
    );
  }

  List<BarChartGroupData> showingGroups() {
    List<BarChartGroupData> barGroups = [];

    // List of all months in YYYY-MM format
    final List<String> allMonths = [
      '2024-01',
      '2024-02',
      '2024-03',
      '2024-04',
      '2024-05',
      '2024-06',
      '2024-07',
      '2024-08',
      '2024-09',
      '2024-10',
      '2024-11',
      '2024-12',
    ];

    for (int i = 0; i < allMonths.length; i++) {
      String monthKey = allMonths[i];

      if (monthlySales.containsKey(monthKey)) {
        int sales = monthlySales[monthKey] ?? 0;
        barGroups.add(makeGroupData(i, sales.toDouble()));
      } else {
        barGroups.add(makeGroupData(i, 0.0));
      }
    }

    return barGroups;
  }

  BarChartData mainBarData() {
    const monthNames = [
      'jan',
      'feb',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec',
    ];

    return BarChartData(
      titlesData: FlTitlesData(
        show: true,
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 38,
          getTitlesWidget: (value, meta) =>
              getTitles(value.toInt(), monthNames),
        )),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      gridData: const FlGridData(show: false),
      barGroups: showingGroups(),
    );
  }

  Widget getTitles(int value, List<String> monthNames) {
    const List<String> monthLabels = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    if (value >= 0 && value < monthLabels.length) {
      return Text(monthLabels[value]);
    } else {
      return const SizedBox();
    }
  }
}
