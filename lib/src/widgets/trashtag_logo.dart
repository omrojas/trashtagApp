import 'package:flutter/material.dart';

class TrashTagLogo extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final String assetName;
  const TrashTagLogo({
    Key key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.assetName = 'assets/images/trashtag.png',
  }) : super(key: key);

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
              image: AssetImage(assetName),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
