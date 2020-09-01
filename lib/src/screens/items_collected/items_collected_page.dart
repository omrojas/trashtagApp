import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/collect/collect_bloc.dart';
import 'package:trashtagApp/src/bloc/garbage_list/garbage_list_bloc.dart';
import 'package:trashtagApp/src/bloc/home/home_bloc.dart';
import 'package:trashtagApp/src/models/select_trash.dart';
import 'package:trashtagApp/src/models/trash.dart';
import 'package:trashtagApp/src/screens/items_collected/error_message.dart';
import 'package:trashtagApp/src/screens/items_collected/location.dart';
import 'package:trashtagApp/src/screens/items_collected/success_message.dart';
import 'package:trashtagApp/src/widgets/green_button.dart';
import 'package:trashtagApp/src/widgets/link_button.dart';
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
            return SuccessMessage(message: state.message);
          }

          if (state is SendError) {
            return ErrorMessage(message: state.error);
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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _title(),
        SizedBox(height: 10.0),
        _goToCollect(context),
        panel(context, selectedTrashes),
      ],
    );
  }

  Widget _goToCollect(BuildContext context) {
    return LinkButton(
      text: 'If you wish to edit this list go to Collect',
      onPressed: () {
        BlocProvider.of<HomeBloc>(context).add(
          CollectButtonPressed(),
        );
      },
    );
  }

  Widget _title() {
    return PageTitle(
      title: 'Items collected',
      subTitle:
          'Check your list of items, then submit it to create a new report with your cleaning session information.',
    );
  }

  Widget panel(
    BuildContext context,
    final List<SelectedTrash> selectedTrashes,
  ) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 3.0,
          color: Theme.of(context).backgroundColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      height: height * .6,
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
      contentPadding: EdgeInsets.only(right: 20.0),
      leading: _trashIcon(selectedTrash?.trash),
      title: Text(selectedTrash?.trash?.name ?? '-'),
      trailing: Text("${selectedTrash?.quantity ?? '-'}"),
    );
  }

  Widget _trashIcon(final Trash trash) {
    if (trash?.iconUrl != null) {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/images/no-image.png',
        image: trash.iconUrl,
        width: 70.0,
        fit: BoxFit.cover,
      );
    } else {
      return Image(
        height: 30,
        width: 70,
        image: AssetImage('assets/images/no-image.png'),
        fit: BoxFit.contain,
      );
    }
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
    return GreenButton(
      text: 'SUBMIT LIST',
      onPressed: () => _onSubmit(context),
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

  void _onSubmit(BuildContext context) async {
    final location = Location();
    final coordinate = await location.getCoordinate();

    BlocProvider.of<GarbageListBloc>(context).add(
      SubmitList(coordinate: coordinate),
    );
  }

  void _listener(BuildContext context, GarbageListState state) {
    if (state is SuccessfulSend) {
      BlocProvider.of<CollectBloc>(context).add(
        ResetCounters(),
      );
    }
  }
}
