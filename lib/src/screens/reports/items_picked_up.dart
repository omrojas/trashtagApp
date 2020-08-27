import 'package:charts_flutter/flutter.dart' as charts;
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/reports/reports_bloc.dart';
import 'package:trashtagApp/src/models/reports/picked_up_litter_per_month.dart';
import 'package:trashtagApp/src/screens/reports/chart_tools.dart';
import 'package:trashtagApp/src/screens/reports/report.dart';
import 'package:trashtagApp/src/screens/reports/report_tools.dart';
import 'package:trashtagApp/src/widgets/green_button.dart';

class ItemasPickedUp extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int year;

  const ItemasPickedUp({
    Key key,
    @required this.year,
    @required this.scaffoldKey,
  })  : assert(year != null),
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
          return Column(
            children: [
              Container(
                height: 300.0,
                child: _chart(state.data),
              ),
              SizedBox(height: 40.0),
              _downloadButton(state.data),
            ],
          );
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

  Widget _downloadButton(final List<PickedUpLitterPerMonth> data) {
    return GreenButton(
      onPressed: () => _createExcel(data),
      text: 'DOWNLOAD .XLSX',
    );
  }

  void _createExcel(final List<PickedUpLitterPerMonth> data) async {
    try {
      final excel = Excel.createExcel();
      final sheet = await excel.getDefaultSheet();

      excel.appendRow(sheet, ['Number of Picked up Litter in $year']);
      excel.appendRow(sheet, ['']);
      excel.appendRow(sheet, ['Month', 'Quantity']);
      data.forEach((e) {
        final month = getMonth(e.month);
        excel.appendRow(sheet, ['$month', '${e.quantity}']);
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
    return 'picked_up_litter_in_$time';
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
