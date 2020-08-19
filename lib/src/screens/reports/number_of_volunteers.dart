import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/reports/reports_bloc.dart';
import 'package:trashtagApp/src/screens/reports/go_to_reports.dart';

class Volunteers extends StatelessWidget {
  const Volunteers({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 70),
        Text(
          'We are an incredible community',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
        SizedBox(height: 30),
        _volunteersBuilder(context),
        SizedBox(height: 30),
        GoToReports()
      ],
    );
  }

  Widget _volunteersBuilder(BuildContext contex) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      builder: (context, state) {
        if (state is NumberOfVolunteers) {
          return _volunteers(context, state.volunteers);
        }

        return Container();
      },
    );
  }

  Widget _volunteers(BuildContext context, final int volunteers) {
    return ListTile(
      title: Text(
        '$volunteers volunteers',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Text(
          'We are the ones who are making a better world',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
