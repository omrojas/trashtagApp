import 'package:flutter/material.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';

import 'trash.dart';

class CollectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _content(context);
  }

  Widget _content(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          _title(),
          SizedBox(height: 25.0),
          _grid(context),
        ],
      ),
    );
  }

  Widget _grid(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .7,
      padding: EdgeInsets.only(bottom: 120.0),
      child: GridView.count(
        crossAxisCount: 2,
        children: _trashes(),
      ),
    );
  }

  List<Widget> _trashes() {
    List<Widget> list = <Widget>[];
    list.add(Trash());
    list.add(Trash());
    list.add(Trash());
    list.add(Trash());
    list.add(Trash());
    list.add(Trash());
    return list;
  }

  Widget _title() {
    return PageTitle(
      title: 'Collect!',
      subTitle: 'Mark the type of litter you are picking up',
    );
  }
}
