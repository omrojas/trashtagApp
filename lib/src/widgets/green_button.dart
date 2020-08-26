import 'package:flutter/material.dart';

class GreenButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  const GreenButton({Key key, @required this.onPressed, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        '$text',
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
      onPressed: onPressed,
    );
  }
}
