import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  const ErrorMessage({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: ListTile(
        title: Text(
          'Sorry',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.redAccent),
        ),
        subtitle: Text(
          '$message',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.redAccent),
        ),
      ),
    );
  }
}
