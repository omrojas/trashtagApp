import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/reports/reports_bloc.dart';

class GoToReports extends StatelessWidget {
  const GoToReports({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        BlocProvider.of<ReportsBloc>(context).add(
          BackButtonPressed(),
        );
      },
      child: Text(
        'Go back to Reports',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
