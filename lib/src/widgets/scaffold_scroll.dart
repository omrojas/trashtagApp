import 'package:flutter/material.dart';
import 'package:trashtagApp/src/widgets/trashtag_container.dart';

class ScaffoldScroll extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  const ScaffoldScroll({Key key, @required this.child, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: TrashTagContainer(
            child: child,
          ),
        ),
      ),
    );
  }
}
