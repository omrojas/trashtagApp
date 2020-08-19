import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/reports/reports_bloc.dart';
import 'package:trashtagApp/src/models/reports/quantity_of_litter_picked_up.dart';
import 'package:trashtagApp/src/screens/reports/report.dart';

class LitterByItems extends StatelessWidget {
  const LitterByItems({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Report(
      title: 'Quantity of Litter by Items',
      chart: _chartBuilder(),
    );
  }

  Widget _chartBuilder() {
    return BlocBuilder<ReportsBloc, ReportsState>(
      builder: (context, state) {
        if (state is QuantityOfLitterByItems) {
          return _chart(state.data);
        }

        return Container();
      },
    );
  }

  Widget _chart(final List<QuantityOfLitterPickedUp> data) {
    if (data.isEmpty) {
      return Container();
    }

    final items = _substringGarbage(data);
    return new charts.PieChart(
      _donutSeries(items),
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

  List<charts.Series<QuantityOfLitterPickedUp, String>> _donutSeries(
    final List<QuantityOfLitterPickedUp> data,
  ) {
    return [
      new charts.Series<QuantityOfLitterPickedUp, String>(
        id: 'litterByItems',
        data: data,
        domainFn: (QuantityOfLitterPickedUp data, _) => data.garbage,
        measureFn: (QuantityOfLitterPickedUp data, _) => data.quantity,
        labelAccessorFn: (QuantityOfLitterPickedUp data, _) =>
            '${data.quantity}',
      )
    ];
  }

  List<QuantityOfLitterPickedUp> _substringGarbage(
    final List<QuantityOfLitterPickedUp> data,
  ) {
    return data.map((e) {
      final length = e.garbage.length;
      e.garbage = length <= 10 ? e.garbage : '${e.garbage.substring(0, 10)}...';
      return e;
    }).toList();
  }
}
