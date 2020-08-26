import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/collect/collect_bloc.dart';
import 'package:trashtagApp/src/bloc/garbage_list/garbage_list_bloc.dart';
import 'package:trashtagApp/src/models/select_trash.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';

import 'trash_widget.dart';

class CollectPage extends StatefulWidget {
  @override
  _CollectPageState createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage> {
  @override
  void initState() {
    super.initState();
    _loadTrashes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          _title(),
          SizedBox(height: 25.0),
          _trashesBuilder(context),
        ],
      ),
    );
  }

  Widget _trashesBuilder(BuildContext context) {
    return BlocListener<CollectBloc, CollectState>(
      listener: (context, state) => _listener(context, state),
      child: BlocBuilder<CollectBloc, CollectState>(
        builder: (context, state) {
          if (state is LoadingTrashes) {
            return CircularProgressIndicator();
          }

          if (state is LoadTrashesSuccess) {
            return _trashesGrid(state.trashes);
          }

          return Container();
        },
      ),
    );
  }

  Widget _trashesGrid(final List<SelectedTrash> trashes) {
    return Flexible(
      child: GridView.count(
        crossAxisCount: 2,
        children: _trashes(trashes),
      ),
    );
  }

  List<Widget> _trashes(List<SelectedTrash> trashes) {
    return trashes.map((e) => TrashWidget(selectedTrash: e)).toList();
  }

  Widget _title() {
    return PageTitle(
      title: 'Collect!',
      subTitle: 'Mark the type of litter you are picking up',
    );
  }

  void _loadTrashes() {
    BlocProvider.of<CollectBloc>(context).add(
      LoadTrashes(),
    );
  }

  void _listener(BuildContext contex, CollectState state) {
    if (state is LoadTrashesSuccess) {
      BlocProvider.of<GarbageListBloc>(context).add(
        SetGarbageList(trashes: state.trashes),
      );
    }

    if (state is LoadTrashesFailure) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('${state.error}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
