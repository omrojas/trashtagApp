import 'package:flutter/material.dart';
import 'package:trashtagApp/src/models/trash.dart';
import 'package:trashtagApp/src/widgets/opacity_image.dart';

class TrashWidget extends StatelessWidget {
  final Trash trash;
  const TrashWidget({Key key, @required final this.trash}) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    if (trash != null && trash.imageUrl != null) {
      return FadeInImage(
        image: NetworkImage(trash?.imageUrl),
        placeholder: AssetImage('assets/images/cleanUp.jpeg'),
        height: 300.0,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else {
      return OpacityImage(assetName: 'assets/images/cleanUp.jpeg');
    }
  }

  Widget _counter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        '23',
        style: TextStyle(
          color: Theme.of(context).backgroundColor,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _name() {
    return ListTile(
      title: Text(
        '${trash?.name ?? ''}',
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _actionButton(
          context: context,
          icon: Icons.remove,
          onClick: () {
            print('remove');
          },
        ),
        _actionButton(
          context: context,
          icon: Icons.add,
          onClick: () {
            print('add');
          },
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
}
