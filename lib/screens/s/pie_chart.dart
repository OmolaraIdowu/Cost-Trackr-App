import 'package:cost_trackr/widgets/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartItem extends StatefulWidget {
  const PieChartItem({super.key});

  @override
  State<PieChartItem> createState() => _PieChartItemState();
}

class _PieChartItemState extends State<PieChartItem> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 30,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Indicator(
                      color: Colors.green,
                      text: 'Food',
                      isSquare: false,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Colors.orange,
                      text: 'Travel',
                      isSquare: false,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Colors.purple,
                      text: 'Utility',
                      isSquare: false,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Indicator(
                      color: Colors.blue,
                      text: 'Subscription',
                      isSquare: false,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Colors.red,
                      text: 'Entertainment',
                      isSquare: false,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Colors.grey,
                      text: 'Tech',
                      isSquare: false,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(6, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 14.0;
      final radius = isTouched ? 80.0 : 60.0;
      const shadows = [Shadow(color: Colors.grey, blurRadius: 1)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.black, shadows: shadows, fontSize: fontSize),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.orange,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.black, shadows: shadows, fontSize: fontSize),
          );
        case 2:
          return PieChartSectionData(
            color: const Color.fromARGB(255, 163, 111, 227),
            value: 20,
            title: '20%',
            radius: radius,
            titleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.black, shadows: shadows, fontSize: fontSize),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.black, shadows: shadows, fontSize: fontSize),
          );
        case 4:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 25,
            title: '25%',
            radius: radius,
            titleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.black, shadows: shadows, fontSize: fontSize),
          );
        case 5:
          return PieChartSectionData(
            color: Colors.red,
            value: 5,
            title: '5%',
            radius: radius,
            titleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.black, shadows: shadows, fontSize: fontSize),
          );
        default:
          throw Error();
      }
    });
  }
}
