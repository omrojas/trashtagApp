import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/reports/reports_bloc.dart';
import 'package:trashtagApp/src/models/reports/picked_up_litter_per_month.dart';
import 'package:trashtagApp/src/screens/reports/chart_tools.dart';
import 'package:trashtagApp/src/screens/reports/report.dart';

class ItemasPickedUp extends StatelessWidget {
  final int year;
  const ItemasPickedUp({Key key, @required this.year})
      : assert(year != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Report(
      title: 'Number of Picked up Litter in $year',
      chart: _chartBuilder(),
    );
  }

  Widget _chartBuilder() {
    return BlocBuilder<ReportsBloc, ReportsState>(
      builder: (context, state) {
        if (state is ItemsPickedUpInYear) {
          return _chart(state.data);
        }

        return Container();
      },
    );
  }

  Widget _chart(final List<PickedUpLitterPerMonth> data) {
    if (data.isEmpty) {
      return Container();
    }

    return new charts.LineChart(
      _getSeries(data),
      animate: true,
      defaultRenderer: new charts.LineRendererConfig(includePoints: true),
      domainAxis: charts.NumericAxisSpec(
        tickFormatterSpec: monthFormatter,
      ),
    );
  }

  List<charts.Series<PickedUpLitterPerMonth, int>> _getSeries(
    final List<PickedUpLitterPerMonth> data,
  ) {
    return [
      new charts.Series<PickedUpLitterPerMonth, int>(
        id: 'garbage',
        data: data,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (PickedUpLitterPerMonth data, _) => data.month,
        measureFn: (PickedUpLitterPerMonth data, _) => data.quantity,
      )
    ];
  }
}
