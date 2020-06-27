import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final String subTitle;
  const PageTitle({Key key, this.title, this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0.0),
      title: Text(
        this.title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Text(
          this.subTitle,
          style: TextStyle(fontSize: 20.0),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
