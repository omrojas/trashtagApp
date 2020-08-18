import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:trashtagApp/src/models/reports/report_data.dart';

final monthFormatter =
    charts.BasicNumericTickFormatterSpec((num value) => _getMonth(value));

Widget getLinearChart({
  @required final String id,
  @required final List<ReportData> data,
}) {
  return new charts.LineChart(
    _getLinerSeries(id: id, data: data),
    animate: true,
    defaultRenderer: new charts.LineRendererConfig(includePoints: true),
    domainAxis: charts.NumericAxisSpec(
      tickFormatterSpec: monthFormatter,
    ),
  );
}

Widget donutChart({
  @required final String id,
  @required final List<ReportData> data,
}) {
  return new charts.PieChart(
    _donutSeries(id: id, data: data),
    animate: true,
    defaultRenderer: new charts.ArcRendererConfig(
      arcWidth: 70,
      arcRendererDecorators: [new charts.ArcLabelDecorator()],
    ),
    behaviors: [
      new charts.DatumLegend(
        position: charts.BehaviorPosition.end,
        horizontalFirst: false,
        cellPadding: new EdgeInsets.only(bottom: 4.0),
        showMeasures: true,
        legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
        measureFormatter: (num value) => '',
      ),
    ],
  );
}

List<charts.Series<ReportData, int>> _getLinerSeries({
  @required final String id,
  @required final List<ReportData> data,
}) {
  return [
    new charts.Series<ReportData, int>(
      id: id,
      data: data,
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (ReportData data, _) => data.month,
      measureFn: (ReportData data, _) => data.quantity,
    )
  ];
}

List<charts.Series> _donutSeries({
  @required final String id,
  @required final List<ReportData> data,
}) {
  return [
    new charts.Series<ReportData, String>(
      id: id,
      data: data,
      //domainFn: (ReportData data, _) => '${data.month}s',
      domainFn: (ReportData data, _) => _getMonth(data.month),
      measureFn: (ReportData data, _) => data.quantity,
      labelAccessorFn: (ReportData data, _) => '${data.quantity}',
    )
  ];
}

String _getMonth(num value) {
  switch (value) {
    case 1:
      return 'Jan';
      break;
    case 2:
      return 'Feb';
      break;
    case 3:
      return 'Mar';
      break;
    case 4:
      return 'Apr';
      break;
    case 5:
      return 'May';
      break;
    case 6:
      return 'June';
      break;
    case 7:
      return 'July';
      break;
    case 8:
      return 'Aug';
      break;
    case 9:
      return 'Sept';
      break;
    case 10:
      return 'Oct';
      break;
    case 11:
      return 'Nov';
      break;
    case 12:
      return 'Dec';
      break;
    default:
      return '';
  }
}
