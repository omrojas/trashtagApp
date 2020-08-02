import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/collect/collect_bloc.dart';
import 'package:trashtagApp/src/bloc/garbage_list/garbage_list_bloc.dart';
import 'package:trashtagApp/src/bloc/home/home_bloc.dart';
import 'package:trashtagApp/src/models/select_trash.dart';
import 'package:trashtagApp/src/widgets/loading_indicator.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';

class ItemsCollectedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: _garbageBuilder(context),
      ),
    );
  }

  Widget _garbageBuilder(BuildContext context) {
    return BlocListener<GarbageListBloc, GarbageListState>(
      listener: (context, state) => _listener(context, state),
      child: BlocBuilder<GarbageListBloc, GarbageListState>(
        builder: (context, state) {
          if (state is GarbageList) {
            return _garbage(context, state.trashes);
          }

          if (state is SendingCollect) {
            return LoadingIndicator();
          }

          if (state is SuccessfulSend) {
            return _successMessage(context, state.message);
          }

          if (state is SendError) {
            return _errorMessage(state.error);
          }

          return _noData();
        },
      ),
    );
  }

  Widget _garbage(
    BuildContext context,
    final List<SelectedTrash> selectedTrashes,
  ) {
    return Column(
      children: <Widget>[
        _title(),
        SizedBox(height: 25.0),
        panel(context, selectedTrashes),
      ],
    );
  }

  Widget _title() {
    return PageTitle(
      title: 'Items collected',
      subTitle:
          'Check your list of items, then submit it to create a new report with your cleanig session information.',
    );
  }

  Widget panel(
    BuildContext context,
    final List<SelectedTrash> selectedTrashes,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 3.0,
          color: Theme.of(context).backgroundColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      height: 400.0,
      child: panelContent(context, selectedTrashes),
    );
  }

  Widget panelContent(
    BuildContext context,
    final List<SelectedTrash> selectedTrashes,
  ) {
    final trashes = _notEmptyTrashes(selectedTrashes);
    if (trashes.isEmpty) {
      return _noData();
    }
    final widgets = trashes.map((e) => _item(e)).toList();
    widgets.add(_actions(context));

    return ListView(children: widgets);
  }

  Widget _item(final SelectedTrash selectedTrash) {
    return ListTile(
      leading: Icon(Icons.track_changes),
      title: Text(selectedTrash?.trash?.name ?? '-'),
      trailing: Text("${selectedTrash?.quantity ?? '-'}"),
    );
  }

  Widget _actions(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Divider(),
          _submitButton(context),
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return _button(
      text: 'SUBMIT LIST',
      onPressed: () => _onSubmit(context),
    );
  }

  Widget _noData() {
    return Center(
      child: Text('No data selected'),
    );
  }

  Widget _successMessage(BuildContext context, final String message) {
    return Column(
      children: <Widget>[
        SizedBox(height: 40.0),
        ListTile(
          title: Text(
            'Thanks!',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              '$message',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: 40.0),
        _trophy(),
        SizedBox(height: 40.0),
        _goToDashboardButton(context),
      ],
    );
  }

  Widget _errorMessage(final String errorMessage) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: ListTile(
        title: Text(
          'Sorry',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.redAccent),
        ),
        subtitle: Text(
          '$errorMessage',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.redAccent),
        ),
      ),
    );
  }

  Widget _trophy() {
    return Image(
      image: AssetImage('assets/images/best.gif'),
      height: 200,
    );
  }

  Widget _goToDashboardButton(BuildContext context) {
    return _button(
      text: 'GO TO MY DASHBOARD',
      onPressed: () => _goToDashboard(context),
    );
  }

  List<SelectedTrash> _notEmptyTrashes(final List<SelectedTrash> trashes) {
    return trashes.where((value) => value.quantity > 0).toList();
  }

  Widget _button({
    @required final String text,
    @required final Function onPressed,
  }) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        '$text',
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
      onPressed: onPressed,
    );
  }

  void _onSubmit(BuildContext context) {
    BlocProvider.of<GarbageListBloc>(context).add(
      SubmitList(),
    );
  }

  void _listener(BuildContext context, GarbageListState state) {
    if (state is SuccessfulSend) {
      BlocProvider.of<CollectBloc>(context).add(
        ResetCounters(),
      );
    }
  }

  void _goToDashboard(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(
      HomeButtonPressed(),
    );
  }
}
