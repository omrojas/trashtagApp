import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/home/home_bloc.dart';
import 'package:trashtagApp/src/widgets/green_button.dart';
import 'package:trashtagApp/src/widgets/link_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SuccessMessage extends StatelessWidget {
  final String message;
  const SuccessMessage({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 40.0),
        _titleAndSubtitle(),
        SizedBox(height: 30.0),
        _trophy(),
        SizedBox(height: 30.0),
        _goToDashboardButton(context),
        SizedBox(height: 30.0),
        Divider(),
        Text(
          "If you want to let us know how clean or dirty you left the beach go to this link",
          textAlign: TextAlign.center,
        ),
        LinkButton(text: 'Click me!', onPressed: _launchURL),
      ],
    );
  }

  Widget _titleAndSubtitle() {
    return ListTile(
      title: Text(
        'Thanks!',
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Text(
          '$message',
          style: TextStyle(fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _trophy() {
    return Image(
      image: AssetImage('assets/images/best.gif'),
      height: 200,
    );
  }

  Widget _goToDashboardButton(BuildContext context) {
    return GreenButton(
      text: 'GO TO MY DASHBOARD',
      onPressed: () => _goToDashboard(context),
    );
  }

  void _goToDashboard(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(
      HomeButtonPressed(),
    );
  }

  void _launchURL() async {
    const url = 'https://mahapach-5bf5a.firebaseapp.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Link could not be opened');
    }
  }
}
