import 'package:flutter/material.dart';

class OpacityImage extends StatelessWidget {
  final String assetName;
  final Widget child;
  const OpacityImage({Key key, @required final this.assetName, this.child})
      : assert(assetName != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _content();
  }

  Widget _content() {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.teal[700],
        image: DecorationImage(
          image: AssetImage(assetName),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(.5),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: child,
    );
  }
}
