import 'package:cash_flow_journal/model/statistic_year.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _LineChart extends StatelessWidget {
  const _LineChart({
    Key? key,
    required this.statisticDataExpenses,
    required this.statisticDataIncomes,
    required this.indexCount,
    required this.expenseAmount,
    required this.incomeAmount,
  }) : super(key: key);

  final List<Data> statisticDataExpenses;
  final List<Data> statisticDataIncomes;
  final int indexCount;

  final double incomeAmount;
  final double expenseAmount;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData => LineChartData(
        lineTouchData: lineTouchData,
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: lineBarsData,
        minX: 0,
        maxX: 5,
        maxY: 11,
        minY: 0,
      );

  LineTouchData get lineTouchData => LineTouchData(
        enabled: true,
      );

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: bottomTitles,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        leftTitles: leftTitles(
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0%';
              case 2:
                return '20%';
              case 4:
                return '40%';
              case 6:
                return '60%';
              case 8:
                return '80%';
              case 10:
                return '100%';
            }
            return '';
          },
        ),
      );

  List<LineChartBarData> get lineBarsData => [
        lineChartBarDataIncome,
        lineChartBarDataExpense,
      ];

  SideTitles leftTitles({required GetTitleFunction getTitles}) => SideTitles(
        getTitles: getTitles,
        showTitles: true,
        margin: 15,
        interval: 1,
        reservedSize: 35,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xff75729e),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 22,
        margin: 10,
        interval: 1,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xff72719b),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        getTitles: (value) {
          return statisticDataIncomes[(value.toInt()) + indexCount].month;
        },
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarDataIncome => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        colors: const [Color(0x444af699)],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: true),
        spots: List.generate(
          6,
          (index) => FlSpot(
            index.toDouble(),
            _getPercent(
              statisticDataIncomes[indexCount + index].amount,
              incomeAmount,
            ),
          ),
        ),
      );

  LineChartBarData get lineChartBarDataExpense => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        colors: const [Color(0x99aa4cfc)],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: List.generate(
          6,
          (index) => FlSpot(
            index.toDouble(),
            _getPercent(
              statisticDataExpenses[indexCount + index].amount,
              expenseAmount,
            ),
          ),
        ),
      );

  double _getPercent(double data1, double data2) {
    return ((data1 / data2) * 100) / 10;
  }
}

class LineChartWidget extends StatelessWidget {
  const LineChartWidget(
      {Key? key,
      required this.statisticData,
      required this.expensesTotal,
      required this.incomesTotal})
      : super(key: key);

  final StatisticYear statisticData;
  final double expensesTotal;
  final double incomesTotal;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SizedBox(
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TabBar(
              tabs: [Tab(text: 'JAN - JUN'), Tab(text: 'JUL - DEC')],
              labelColor: Colors.black,
            ),
            Expanded(
              child: TabBarView(children: [
                lineChart1(),
                lineChart2(),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget lineChart2() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatio(
        aspectRatio: 1.5,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            gradient: LinearGradient(
              colors: [
                Color(0xff2c274c),
                Color(0xff46426c),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Center(child: Text('Monthly Statistic')),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                  child: _LineChart(
                    statisticDataExpenses: statisticData.dataExpanse,
                    statisticDataIncomes: statisticData.dataIncome,
                    indexCount: 6,
                    incomeAmount: incomesTotal,
                    expenseAmount: expensesTotal,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget lineChart1() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatio(
        aspectRatio: 1.5,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            gradient: LinearGradient(
              colors: [
                Color(0xff2c274c),
                Color(0xff46426c),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Center(child: Text('Monthly Statistic')),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                  child: _LineChart(
                    statisticDataExpenses: statisticData.dataExpanse,
                    statisticDataIncomes: statisticData.dataIncome,
                    indexCount: 0,
                    incomeAmount: incomesTotal,
                    expenseAmount: expensesTotal,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
