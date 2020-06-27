import 'package:flutter/material.dart';
import 'package:trashtagApp/src/pages/collect/collect_page.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: _content(),
    );
  }

  Widget _content() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.indigo[800],
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: _tems(),
    );
  }

  Widget _tems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.teal,
            size: 40,
          ),
          onPressed: null,
        ),
        IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.teal,
            size: 40,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CollectPage()),
            );
          },
        ),
        IconButton(
          icon: Icon(
            Icons.list,
            color: Colors.teal,
            size: 40,
          ),
          onPressed: null,
        ),
      ],
    );
  }
}
