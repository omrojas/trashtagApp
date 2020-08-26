import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/reports/reports_bloc.dart';
import 'package:trashtagApp/src/screens/reports/items_picked_up.dart';
import 'package:trashtagApp/src/screens/reports/litter_by_items.dart';
import 'package:trashtagApp/src/screens/reports/number_of_volunteers.dart';
import 'package:trashtagApp/src/widgets/loading_indicator.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key key}) : super(key: key);

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReportsBloc>(context).add(
      BackButtonPressed(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _builder(context),
    );
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

        if (state is LoadingReport) {
          return _loading();
        }

        return initialState(context);
      },
    );
  }

  Widget _loading() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: LoadingIndicator(),
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
    return _option(
      title: 'Number od Items Picked Up in $year.',
      subtitle: 'Check out the number.',
      onTab: () {
        BlocProvider.of<ReportsBloc>(context).add(
          ItemsPickedUpInYearButtonPressed(year: year),
        );
      },
    );
  }

  Widget _numberOfVolunteers(BuildContext context) {
    return _option(
      title: 'Number of volunteers.',
      subtitle: 'Discover how many we are.',
      onTab: () {
        BlocProvider.of<ReportsBloc>(context).add(
          NumberOfVolunteersButtonPressed(),
        );
      },
    );
  }

  Widget _quantityOfLitterByItems(BuildContext context) {
    return _option(
      title: 'Quantity of litter by items.',
      subtitle: 'Look how much we have achieved.',
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
