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
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.teal[700],
          image: DecorationImage(
            image: AssetImage('assets/images/cleanUp.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(.5),
              BlendMode.dstATop,
            ),
          ),
        ),
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
        color: Colors.white,
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _subTitle() {
    return Text(
      'Help us to collect information about littering in public open spaces.',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
    );
  }

  Widget _startCleanigButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        'START CLEANING',
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
      onPressed: () => {},
    );
  }
}
