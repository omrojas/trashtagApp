import 'package:flutter/material.dart';

class TrashTagLogo extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  const TrashTagLogo(
      {Key key, this.mainAxisAlignment = MainAxisAlignment.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _logo();
  }

  Widget _logo() {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: <Widget>[
        Container(
          height: 100.0,
          width: 180.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/trashtag.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
