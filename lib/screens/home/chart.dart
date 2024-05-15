import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyChart extends StatefulWidget {
  const MyChart({super.key});

  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(mainBarData());
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
          toY: y, width: 50, color: Theme.of(context).colorScheme.secondary)
    ]);
  }

  List<BarChartGroupData> showingGroups() {
    return List.generate(1, (i) {
      switch (i) {
        case 0:
          return makeGroupData(0, 4600);
        // case 1:
        //   return makeGroupData(1, 3500);
        // case 2:
        //   return makeGroupData(2, 5);
        // case 3:
        //   return makeGroupData(3, 2);
        // case 4:
        //   return makeGroupData(4, 6);
        // case 5:
        //   return makeGroupData(5, 8.5);
        // case 6:
        //   return makeGroupData(6, 7);
        // case 7:
        //   return makeGroupData(7, 3);
        // case 8:
        //   return makeGroupData(8, 8);
        // case 9:
        //   return makeGroupData(9, 5);
        // case 10:
        //   return makeGroupData(10, 9);
        // case 11:
        //   return makeGroupData(11, 11.5);
        default:
          return throw Error();
      }
    });
  }

  BarChartData mainBarData() {
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
          getTitlesWidget: getTiles,
        )),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      gridData: const FlGridData(show: false),
      barGroups: showingGroups(),
    );
  }

  Widget getTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontSize: 14,
    );

    Widget text;

    switch (value.toInt()) {
      case 0:
        text = Text(
          'may',
          style: style,
        );
        break;
      // case 1:
      //   text = Text(
      //     'may',
      //     style: style,
      //   );
      //   break;
      // case 2:
      //   text = Text(
      //     'mar',
      //     style: style,
      //   );
      //   break;
      // case 3:
      //   text = Text(
      //     'apr',
      //     style: style,
      //   );
      //   break;
      // case 4:
      //   text = Text(
      //     'may',
      //     style: style,
      //   );
      //   break;
      // case 5:
      //   text = Text(
      //     'jun',
      //     style: style,
      //   );
      //   break;
      // case 6:
      //   text = Text(
      //     'jul',
      //     style: style,
      //   );
      //   break;
      // case 7:
      //   text = Text(
      //     'aug',
      //     style: style,
      //   );
      //   break;
      // case 8:
      //   text = Text(
      //     'sep',
      //     style: style,
      //   );
      //   break;
      // case 9:
      //   text = Text(
      //     'oct',
      //     style: style,
      //   );
      //   break;
      // case 10:
      //   text = Text(
      //     'nov',
      //     style: style,
      //   );
      //   break;
      // case 11:
      //   text = Text(
      //     'dec',
      //     style: style,
      //   );
      //   break;
      default:
        text = const SizedBox();
    }
    return SideTitleWidget(child: text, axisSide: meta.axisSide, space: 5);
  }
}
