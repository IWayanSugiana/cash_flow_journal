import 'package:cash_flow_journal/helper/currency_helper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({
    Key? key,
    required this.expensesTotal,
    required this.incomesTotal,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final double expensesTotal;
  final double incomesTotal;
  final String title;
  final String subTitle;

  double _getPercent(double data1, double data2) {
    return (data1 / (data1 + data2)) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Text(title),
            Text(subTitle),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 1.3,
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(
                      show: false,
                    ),
                    startDegreeOffset: 90,
                    sectionsSpace: 5,
                    centerSpaceRadius: 0,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  indicator(
                    const Color(0xff0293ee),
                    'Expenses',
                  ),
                  const SizedBox(height: 5),
                  indicator(
                    const Color(0xfff8b250),
                    'Incomes',
                  ),
                ],
              ),
            ),
          ],
        ),
        typeAmountTile()
      ],
    );
  }

  Widget typeAmountTile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text('Expense:'),
            Text(CurrencyHelper.format(expensesTotal)),
          ],
        ),
        Column(
          children: [
            Text('Income:'),
            Text(CurrencyHelper.format(incomesTotal)),
          ],
        )
      ],
    );
  }

  Widget indicator(Color color, String text) {
    return Row(
      children: <Widget>[
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      2,
      (i) {
        final isTouched = i == -1;
        final fontSize = isTouched ? 20.0 : 16.0;
        final radius = isTouched ? 110.0 : 100.0;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: const Color(0xff0293ee),
              value: expensesTotal,
              radius: radius,
              title:
                  _getPercent(expensesTotal, incomesTotal).toStringAsFixed(0) +
                      ' %',
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
            );
          case 1:
            return PieChartSectionData(
              color: const Color(0xfff8b250),
              value: incomesTotal,
              radius: radius,
              title:
                  _getPercent(incomesTotal, expensesTotal).toStringAsFixed(0) +
                      ' %',
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
            );
          default:
            throw 'Oh no';
        }
      },
    );
  }
}
