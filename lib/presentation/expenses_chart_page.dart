import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:spent/models/expense.dart';
import 'dart:math' as math;

class ExSample {
  final String categoryName;
  final double amount;
  final charts.Color color;

  ExSample(this.categoryName, this.amount, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);

  @override
  String toString() {
    return 'ExSample: ($categoryName -- $amount)';
  }
}

final data = [
  ExSample('Food', 10, Colors.red),
  ExSample('Rent', 70, Colors.yellow),
  ExSample('groceries', 30, Colors.teal)
];

class ExpensesChartPage extends StatelessWidget {
  final List<Expense> expenses;
  const ExpensesChartPage({Key key, this.expenses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, double> totalExpenses = {};

    if (expenses != null) {
      expenses.forEach((expense) {
        totalExpenses[expense.category.name] =
            totalExpenses[expense.category.name] != null
                ? totalExpenses[expense.category.name] +
                        double.tryParse(expense.amount) ??
                    0.0
                : double.tryParse(expense.amount) ?? 0.0;
      });
    }

    print('totalExpenses: $totalExpenses');

    List<ExSample> expData = [];

    totalExpenses.forEach((category, amount) {
      expData.add(ExSample(
          category,
          amount,
          Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
              .withOpacity(1.0)));
    });

    List<charts.Series> serieslist = [
      new charts.Series<ExSample, double>(
        displayName: 'boo',
        id: 'expenses',
        data: expData,
        measureFn: (ExSample exSample, _) => exSample.amount,
        domainFn: (ExSample exSample, _) => exSample.amount,
        colorFn: (ExSample exSample, _) => exSample.color,
        labelAccessorFn: (ExSample exSample, _) =>
            '${exSample.categoryName} - ${exSample.amount}',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('chart'),
      ),
      body: Container(
          child: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: charts.PieChart(serieslist,
                  animate: true,
                  defaultRenderer: new charts.ArcRendererConfig(
                      arcRendererDecorators: [new charts.ArcLabelDecorator()])),
            ),
            // Expanded(
            //   child: GridView.count(
            //       crossAxisCount: 2,
            //       padding: const EdgeInsets.all(4.0),
            //       mainAxisSpacing: 4.0,
            //       crossAxisSpacing: 4.0,
            //       children: expData.map((ExSample ex) {
            //         return GridTile(child: Text(ex.categoryName));
            //       }).toList()),
            // )
          ],
        ),
      )),
    );
  }
}
