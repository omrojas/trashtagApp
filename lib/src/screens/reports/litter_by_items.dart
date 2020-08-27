import 'package:charts_flutter/flutter.dart' as charts;
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/reports/reports_bloc.dart';
import 'package:trashtagApp/src/models/reports/quantity_of_litter_picked_up.dart';
import 'package:trashtagApp/src/screens/reports/report.dart';
import 'package:trashtagApp/src/screens/reports/report_tools.dart';
import 'package:trashtagApp/src/widgets/green_button.dart';

class LitterByItems extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const LitterByItems({Key key, @required this.scaffoldKey}) : super(key: key);

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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 300.0,
                child: _chart(state.data),
              ),
              SizedBox(height: 100.0),
              _downloadButton(state.data),
            ],
          );
        }

        return Container();
      },
    );
  }

  Widget _chart(final List<QuantityOfLitterPickedUp> data) {
    if (data.isEmpty) {
      return Container();
    }

    return new charts.PieChart(
      _donutSeries(data),
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
        domainFn: (QuantityOfLitterPickedUp data, _) => _garbageName(data),
        measureFn: (QuantityOfLitterPickedUp data, _) => data.quantity,
        labelAccessorFn: (QuantityOfLitterPickedUp data, _) =>
            '${data.quantity}',
      )
    ];
  }

  String _garbageName(final QuantityOfLitterPickedUp e) {
    try {
      final length = e.garbage.length;
      return length <= 7 ? e.garbage : '${e.garbage.substring(0, 7)}..';
    } catch (e) {
      return '';
    }
  }

  Widget _downloadButton(final List<QuantityOfLitterPickedUp> data) {
    return GreenButton(
      onPressed: () => _createExcel(data),
      text: 'DOWNLOAD .XLSX',
    );
  }

  void _createExcel(final List<QuantityOfLitterPickedUp> data) async {
    try {
      final excel = Excel.createExcel();
      final sheet = await excel.getDefaultSheet();

      excel.appendRow(sheet, ['Quantity of Litter by Items']);
      excel.appendRow(sheet, ['']);
      excel.appendRow(sheet, ['Garbage', 'Quantity']);
      data.forEach((e) {
        excel.appendRow(sheet, ['${e.garbage}', '${e.quantity}']);
      });

      final List<int> content = await excel.encode();
      await _onWriteFile(content);
    } catch (e) {
      _errorAlert();
    }
  }

  Future<void> _onWriteFile(final List<int> fileContent) async {
    await writeFile(
      fileContent: fileContent,
      fileName: getFileName,
      errorAlert: _errorAlert,
      successAlert: _successAlert,
    );
  }

  String get getFileName {
    final now = DateTime.now();
    final time = '${now.year}-${now.month}-${now.day}-${now.hour}';
    return 'litter_by_items_$time';
  }

  void _successAlert() {
    successAlert(
      scaffoldKey: scaffoldKey,
      title: 'Successfully generated file!',
      subTitle: '',
    );
  }

  void _errorAlert() {
    errorAlert(
      scaffoldKey: scaffoldKey,
      title: 'An error occurred while trying to generate the file.',
      subTitle: 'Check permissions or try again later.',
    );
  }
}
