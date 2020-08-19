import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/reports/reports_bloc.dart';
import 'package:trashtagApp/src/screens/reports/items_picked_out.dart';
import 'package:trashtagApp/src/screens/reports/litter_by_items.dart';
import 'package:trashtagApp/src/screens/reports/number_of_volunteers.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _builder(context);
  }

  Widget _builder(BuildContext context) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      builder: (context, state) {
        if (state is ItemsPickedUpInYear) {
          return ItemasPickedUp(year: state.year);
        }

        if (state is NumberOfVolunteers) {
          return Volunteers();
        }

        if (state is QuantityOfLitterByItems) {
          return LitterByItems();
        }

        return initialState(context);
      },
    );
  }

  Widget initialState(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          _title(),
          SizedBox(height: 25.0),
          _reports(context),
        ],
      ),
    );
  }

  Widget _title() {
    return PageTitle(
      title: 'Reports',
      subTitle: 'TrashTag official reports',
    );
  }

  Widget _reports(BuildContext context) {
    return Container(
      height: 400.0,
      child: ListView(
        children: [
          _itemsPickedUpInYear(context),
          _numberOfVolunteers(context),
          _quantityOfLitterByItems(context),
        ],
      ),
    );
  }

  Widget _itemsPickedUpInYear(BuildContext context) {
    final int year = _getCurrentYear();
    final String title = 'Number od Items Picked Up in $year.';
    final String subtitle = 'Check out the number.';
    return _option(
      title: title,
      subtitle: subtitle,
      onTab: () {
        BlocProvider.of<ReportsBloc>(context).add(
          ItemsPickedUpInYearButtonPressed(year: year),
        );
      },
    );
  }

  Widget _numberOfVolunteers(BuildContext context) {
    final String title = 'Number of volunteers.';
    // TODO SET SUBTITLE
    final String subtitle = '.';
    return _option(
      title: title,
      subtitle: subtitle,
      onTab: () {
        BlocProvider.of<ReportsBloc>(context).add(
          NumberOfVolunteersButtonPressed(),
        );
      },
    );
  }

  Widget _quantityOfLitterByItems(BuildContext context) {
    final String title = 'Quantity of litter by items.';
    // TODO SET SUBTITLE
    final String subtitle = '';
    return _option(
      title: title,
      subtitle: subtitle,
      onTab: () {
        BlocProvider.of<ReportsBloc>(context).add(
          QuantityOfLitterByItemsButtonPressed(),
        );
      },
    );
  }

  Widget _option({
    @required final String title,
    @required final String subtitle,
    @required final Function onTab,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(
            '$title',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text('$subtitle'),
          onTap: onTab,
        ),
        Divider(
          color: Colors.black54,
        ),
      ],
    );
  }

  int _getCurrentYear() => new DateTime.now().year;
}
