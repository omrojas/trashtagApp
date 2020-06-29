import 'package:flutter/material.dart';
import 'package:trashtagApp/src/pages/collect/add_trash_page.dart';
import 'package:trashtagApp/src/widgets/menu.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';
import 'package:trashtagApp/src/widgets/trashtag_app_bar.dart';

import 'trash.dart';

class CollectPage extends StatefulWidget {
  CollectPage({Key key}) : super(key: key);

  @override
  _CollectPageState createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _content(),
        ),
      ),
      bottomNavigationBar: Menu(),
      floatingActionButton: _addTrash(),
    );
  }

  Widget _addTrash() {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).accentColor,
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 40.0,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTrahsPage()),
        );
      },
    );
  }

  Widget _content() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          _title(),
          SizedBox(height: 25.0),
          _trashes(),
        ],
      ),
    );
  }

  Widget _trashes() {
    return Container(
      height: 1000.0,
      child: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          Trash(),
          Trash(),
          Trash(),
          Trash(),
          Trash(),
          Trash(),
        ],
      ),
    );
  }

  Widget _title() {
    return PageTitle(
      title: 'Collect!',
      subTitle: 'Mark the type of litter you are picking up',
    );
  }
}
