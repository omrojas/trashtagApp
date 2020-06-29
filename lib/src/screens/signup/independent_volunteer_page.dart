import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/authentication/authentication_bloc.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';
import 'package:trashtagApp/src/widgets/trashtag_logo.dart';

import 'independent_volunteer_form.dart';

class IndependentVolunteerPage extends StatefulWidget {
  IndependentVolunteerPage({Key key}) : super(key: key);

  @override
  _IndependentVolunteerPageState createState() =>
      _IndependentVolunteerPageState();
}

class _IndependentVolunteerPageState extends State<IndependentVolunteerPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: _content(context),
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          TrashTagLogo(assetName: 'assets/images/TrashTagLogo02.png'),
          SizedBox(height: 25.0),
          _title(),
          SizedBox(height: 25.0),
          IdependentVolunteerForm(),
          SizedBox(height: 40.0),
          _logIn(context),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }

  Widget _title() {
    return PageTitle(
      title: 'Independent volunteer',
      subTitle:
          'Sign up as a solo volunteer if you are cleaning by your own. That is, without an environment organization',
    );
  }

  Widget _logIn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Already have an account?",
          style: TextStyle(fontSize: 16.0),
        ),
        FlatButton(
          child: Text(
            "Log in",
            style: TextStyle(fontSize: 16.0),
          ),
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(
              AuthenticationLoggedOut(),
            );
          },
        )
      ],
    );
  }
}
