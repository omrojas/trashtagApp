import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/reports/reports_bloc.dart';
import 'package:trashtagApp/src/models/reports/report_data.dart';
import 'package:trashtagApp/src/screens/reports/report.dart';
import 'package:trashtagApp/src/screens/reports/chart_tools.dart';

class ItemasPickedOut extends StatelessWidget {
  final int year;
  const ItemasPickedOut({Key key, @required this.year})
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

  Widget _chart(final List<ReportData> data) =>
      getLinearChart(id: 'volunteers', data: data);
}
