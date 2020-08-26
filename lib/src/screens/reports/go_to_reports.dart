import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/reports/reports_bloc.dart';
import 'package:trashtagApp/src/widgets/link_button.dart';

class GoToReports extends StatelessWidget {
  const GoToReports({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinkButton(
      text: 'Go back to Reports',
      onPressed: () {
        BlocProvider.of<ReportsBloc>(context).add(
          BackButtonPressed(),
        );
      },
    );
  }
}
