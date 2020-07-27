import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/collect/collect_bloc.dart';
import 'package:trashtagApp/src/models/select_trash.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';

class ItemsCollectedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          _title(),
          SizedBox(height: 25.0),
          panel(context),
        ],
      ),
    );
  }

  Widget _title() {
    return PageTitle(
      title: 'Items collected',
      subTitle:
          'Check your list of items, then submit it to create a new report with your cleanig session information.',
    );
  }

  Widget panel(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 3.0,
          color: Theme.of(context).backgroundColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      height: 400.0,
      child: _garbageBuilder(),
    );
  }

  Widget _garbageBuilder() {
    return BlocBuilder<CollectBloc, CollectState>(
      builder: (context, state) {
        if (state is LoadTrashesSuccess) {
          final trashes = _notEmptyTrashes(state.trashes);
          if (trashes.isEmpty) {
            return _noData();
          } else {
            return panelContent(context, trashes);
          }
        }
        return _noData();
      },
    );
  }

  Widget panelContent(BuildContext context, final List<SelectedTrash> trashes) {
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
          _submitButton(),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        'SUBMIT LIST',
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
      onPressed: _onSubmit,
    );
  }

  Widget _noData() {
    return Center(
      child: Text('No data selected'),
    );
  }

  List<SelectedTrash> _notEmptyTrashes(final List<SelectedTrash> trashes) {
    return trashes.where((value) => value.quantity > 0).toList();
  }

  void _onSubmit() {
    // TODO ADD EVENT TO BLOC
  }
}
