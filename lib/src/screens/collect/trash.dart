import 'package:flutter/material.dart';

class Trash extends StatelessWidget {
  const Trash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _trash(context);
  }

  Widget _trash(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        children: <Widget>[
          _imageAndName(),
          _actions(context),
        ],
      ),
    );
  }

  Widget _imageAndName() {
    return Container(
      height: 130.0,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/temp.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Text('Cigarette butt'),
    );
  }

  Widget _actions(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buttons(context),
          _counter(context),
        ],
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
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

  Widget _counter(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      height: 47.0,
      width: 80.0,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
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
