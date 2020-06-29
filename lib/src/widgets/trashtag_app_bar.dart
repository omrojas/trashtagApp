import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return AppBar(
    title: _logo(),
    actions: [
      Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () => Scaffold.of(context).openEndDrawer(),
          // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
      ),
    ],
  );
}

Widget _logo() {
  return Container(
    height: 40.0,
    width: 100.0,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/trashtag.png'),
        fit: BoxFit.cover,
      ),
    ),
  );
}
