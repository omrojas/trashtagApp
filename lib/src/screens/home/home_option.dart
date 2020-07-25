import 'package:flutter/material.dart';
import 'package:trashtagApp/src/widgets/opacity_image.dart';

class HomeOption extends StatelessWidget {
  final String assetName;
  final String title;
  final String subtitle;
  final String buttonText;
  final Function onClick;

  const HomeOption({
    Key key,
    @required this.assetName,
    @required this.title,
    @required this.subtitle,
    @required this.buttonText,
    @required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10.0),
      width: 360.0,
      child: _content(),
    );
  }

  Widget _content() {
    return Card(
      elevation: 4.0,
      child: OpacityImage(
        assetName: assetName,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _title(),
            SizedBox(height: 20.0),
            _subTitle(),
            SizedBox(height: 20.0),
            _button(),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _subTitle() {
    return Text(
      subtitle,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
    );
  }

  Widget _button() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
      onPressed: onClick,
    );
  }
}
