import 'package:flutter/material.dart';

class Trash extends StatelessWidget {
  const Trash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _trash();
  }

  Widget _trash() {
    return Card(
      elevation: 4.0,
      child: Column(
        children: <Widget>[
          _imageAndName(),
          _actions(),
        ],
      ),
    );
  }

  Widget _imageAndName() {
    return Container(
      height: 130.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.amber,
        image: DecorationImage(
          image: AssetImage('assets/images/temp.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Text('Cigarette butt'),
    );
  }

  Widget _actions() {
    return Container(
      padding: EdgeInsets.only(top: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buttons(),
          _counter(),
        ],
      ),
    );
  }

  Widget _buttons() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo[800],
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.remove),
            color: Colors.white,
            onPressed: () => {},
          ),
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () => {},
          ),
        ],
      ),
    );
  }

  Widget _counter() {
    return Container(
      padding: EdgeInsets.all(12.0),
      height: 47.0,
      width: 80.0,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Text(
        '12',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
