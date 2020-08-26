import 'package:flutter/material.dart';

class LinkButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  const LinkButton({Key key, @required this.onPressed, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(
        '$text',
        overflow: TextOverflow.fade,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
