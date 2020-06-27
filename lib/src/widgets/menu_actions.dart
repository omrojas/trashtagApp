import 'package:flutter/material.dart';

class MenuActions extends StatelessWidget {
  const MenuActions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _action();
  }

  Widget _action() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        Icons.more_vert,
        color: Colors.white,
        size: 30.0,
      ),
    );
  }
}
