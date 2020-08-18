import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/reports/reports_bloc.dart';
import 'package:trashtagApp/src/models/reports/report_data.dart';
import 'package:trashtagApp/src/screens/reports/report.dart';
import 'package:trashtagApp/src/screens/reports/chart_tools.dart';

class LitterByItems extends StatelessWidget {
  const LitterByItems({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO change title
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

  Widget _chart(final List<ReportData> data) =>
      donutChart(id: 'litterByItems', data: data);
}
