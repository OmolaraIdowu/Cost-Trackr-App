import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartItem extends StatefulWidget {
  const ChartItem({super.key});

  @override
  State<ChartItem> createState() => _ChartItemState();
}

class _ChartItemState extends State<ChartItem> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      mainBarChart(),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
          toY: y,
          color: Theme.of(context).primaryColor,
          width: 12,
          backDrawRodData:
              BackgroundBarChartRodData(show: true, toY: 5, color: Colors.grey))
    ]);
  }

  List<BarChartGroupData> showingGroups() => List.generate(8, (index) {
        switch (index) {
          case 0:
            return makeGroupData(0, 2);
          case 1:
            return makeGroupData(1, 3);
          case 2:
            return makeGroupData(2, 2);
          case 3:
            return makeGroupData(3, 4.5);
          case 4:
            return makeGroupData(4, 3.8);
          case 5:
            return makeGroupData(5, 1.5);
          case 6:
            return makeGroupData(6, 4);
          case 7:
            return makeGroupData(7, 3.8);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarChart() {
    return BarChartData(
        titlesData: FlTitlesData(
          show: true,
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 38,
              getTitlesWidget: getTiles,
            ),
          ),
          leftTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 38,
            getTitlesWidget: leftTiles,
          )),
        ),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        barGroups: showingGroups());
  }

  Widget getTiles(double value, TitleMeta meta) {
    final theme = Theme.of(context).textTheme.titleMedium;
    Widget text;

    switch (value.toInt()) {
      case 0:
        text = Text('01', style: theme);
        break;
      case 1:
        text = Text('02', style: theme);
        break;
      case 2:
        text = Text('03', style: theme);
        break;
      case 3:
        text = Text('04', style: theme);
        break;
      case 4:
        text = Text('05', style: theme);
        break;
      case 5:
        text = Text('06', style: theme);
        break;
      case 6:
        text = Text('07', style: theme);
        break;
      case 7:
        text = Text('08', style: theme);
        break;
      default:
        text = Text('', style: theme);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Widget leftTiles(double value, TitleMeta meta) {
    final theme = Theme.of(context).textTheme.titleMedium;

    String text;

    if (value == 0) {
      text = '\$ 1K';
    } else if (value == 2) {
      text = '\$ 2K';
    } else if (value == 3) {
      text = '\$ 3K';
    } else if (value == 4) {
      text = '\$ 4K';
    } else if (value == 5) {
      text = '\$ 5K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 6,
      child: Text(text, style: theme),
    );
  }
}
