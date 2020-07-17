import 'package:flutter/material.dart';

class TrashTagButton extends StatelessWidget {
  final Stream stream;
  final Function function;
  final String text;

  // TODO Implement it in all forms
  const TrashTagButton({
    Key key,
    @required this.stream,
    @required this.function,
    @required this.text,
  })  : assert(stream != null, text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _button(context);
  }

  Widget _button(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        return Container(
          width: double.infinity,
          child: RaisedButton(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              '$text',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            onPressed: snapshot.hasData ? function : null,
          ),
        );
      },
    );
  }
}
