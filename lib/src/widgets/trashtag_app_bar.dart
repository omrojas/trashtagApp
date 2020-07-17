import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return AppBar(
    title: _logo(),
    elevation: 0.0,
    automaticallyImplyLeading: false,
    actions: [
      Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () => Scaffold.of(context).openEndDrawer(),
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
