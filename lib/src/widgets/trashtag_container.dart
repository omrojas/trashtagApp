import 'package:flutter/material.dart';

class TrashTagContainer extends StatelessWidget {
  final Widget child;
  const TrashTagContainer({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 500,
        ),
        child: child,
      ),
    );
  }
}
