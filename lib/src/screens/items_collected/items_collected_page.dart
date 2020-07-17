import 'package:flutter/material.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';

class ItemsCollectedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _content(context);
  }

  Widget _content(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          _title(),
          SizedBox(height: 25.0),
          _items(context),
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

  Widget _items(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).backgroundColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      height: 400.0,
      child: ListView(
        children: <Widget>[
          _item(),
          _item(),
          _item(),
        ],
      ),
    );
  }

  Widget _item() {
    return ListTile(
      leading: Icon(Icons.track_changes),
      title: Text('Cigarette buts'),
      trailing: Text('1'),
    );
  }
}
