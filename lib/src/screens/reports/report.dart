import 'package:flutter/material.dart';
import 'package:trashtagApp/src/screens/reports/go_to_reports.dart';

class Report extends StatelessWidget {
  final String title;
  final Widget chart;

  const Report({
    Key key,
    @required this.title,
    @required this.chart,
  })  : assert(title != null, chart != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(height: 30.0),
          _title(),
          SizedBox(height: 20.0),
          GoToReports(),
          SizedBox(height: 40.0),
          this.chart,
          SizedBox(height: 40.0),
        ],
      ),
    );
  }

  Widget _title() {
    return ListTile(
      contentPadding: EdgeInsets.all(0.0),
      title: Text(
        this.title,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
      ),
    );
  }
}
