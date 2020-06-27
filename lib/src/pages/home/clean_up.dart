import 'package:flutter/material.dart';

class CleanUp extends StatefulWidget {
  CleanUp({Key key}) : super(key: key);

  @override
  _CleanUpState createState() => _CleanUpState();
}

class _CleanUpState extends State<CleanUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.0,
      child: _content(),
    );
  }

  Widget _content() {
    return Card(
      elevation: 4.0,
      color: Colors.amber[200],
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 120.0),
            _title(),
            SizedBox(height: 20.0),
            _subTitle(),
            SizedBox(height: 20.0),
            _startCleanigButton(),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      'Clean up!',
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _subTitle() {
    return Text(
      'Help us to collect information about littering in public open spaces.',
      style: TextStyle(
        fontSize: 20.0,
      ),
    );
  }

  Widget _startCleanigButton() {
    return RaisedButton(
      padding: EdgeInsets.all(12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.teal,
      child: Text(
        'START CLEANING',
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
      onPressed: () => {},
    );
  }
}
