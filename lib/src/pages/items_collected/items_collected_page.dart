import 'package:flutter/material.dart';
import 'package:trashtagApp/src/widgets/menu.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';
import 'package:trashtagApp/src/widgets/trashtag_app_bar.dart';

class ItemsCollectedPage extends StatefulWidget {
  ItemsCollectedPage({Key key}) : super(key: key);

  @override
  _ItemsCollectedPageState createState() => _ItemsCollectedPageState();
}

class _ItemsCollectedPageState extends State<ItemsCollectedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _content(),
        ),
      ),
      bottomNavigationBar: Menu(),
    );
  }

  Widget _content() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          _title(),
          SizedBox(height: 25.0),
          _items(),
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

  Widget _items() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Colors.indigo[700]),
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
