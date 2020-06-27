import 'package:flutter/material.dart';

Widget appBar() {
  return AppBar(
    title: _logo(),
    backgroundColor: Colors.indigo[800],
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
