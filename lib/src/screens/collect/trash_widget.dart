import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/collect/collect_bloc.dart';
import 'package:trashtagApp/src/models/select_trash.dart';
import 'package:trashtagApp/src/widgets/opacity_image.dart';

class TrashWidget extends StatefulWidget {
  final SelectedTrash selectedTrash;

  const TrashWidget({Key key, @required final this.selectedTrash})
      : super(key: key);

  @override
  _TrashWidgetState createState() => _TrashWidgetState();
}

class _TrashWidgetState extends State<TrashWidget> {
  @override
  Widget build(BuildContext context) {
    return _trash(context);
  }

  Widget _trash(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Stack(
        children: <Widget>[
          _image(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              _counter(context),
              _name(),
              _actions(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _image() {
    return Stack(
      children: <Widget>[
        _getTrashImage(),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
          ),
        ),
      ],
    );
  }

  Widget _getTrashImage() {
    if (widget.selectedTrash?.trash?.imageUrl != null) {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/images/no-image.png',
        image: widget.selectedTrash?.trash?.imageUrl,
        height: 300.0,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
    return OpacityImage(assetName: 'assets/images/no-image.png');
  }

  Widget _counter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        '${widget.selectedTrash?.quantity ?? 0}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _name() {
    return ListTile(
      title: Text(
        '${widget.selectedTrash?.trash?.name ?? ''}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _actions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _actionButton(
          context: context,
          icon: Icons.remove,
          onClick: () => _onDecrement(context),
        ),
        _actionButton(
          context: context,
          icon: Icons.add,
          onClick: () => _onIncrement(context),
        ),
      ],
    );
  }

  Widget _actionButton({
    @required BuildContext context,
    @required IconData icon,
    @required Function onClick,
  }) {
    return Container(
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).backgroundColor,
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 30.0,
        ),
        onPressed: onClick,
      ),
    );
  }

  void _onIncrement(BuildContext context) {
    BlocProvider.of<CollectBloc>(context).add(
      IncrementTrash(widget.selectedTrash?.trash),
    );
    setState(() {});
  }

  void _onDecrement(BuildContext context) {
    BlocProvider.of<CollectBloc>(context).add(
      DecrementTrash(widget.selectedTrash?.trash),
    );
    setState(() {});
  }
}
