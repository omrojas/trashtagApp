import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/authentication/authentication_bloc.dart';
import 'package:trashtagApp/src/bloc/signup/independent/independent_signup_bloc.dart';
import 'package:trashtagApp/src/repository/auth_repository.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';
import 'package:trashtagApp/src/widgets/scaffold_scroll.dart';
import 'package:trashtagApp/src/widgets/trashtag_logo.dart';

import 'independent_volunteer_form.dart';

class IndependentVolunteerPage extends StatelessWidget {
  final AuthRepository authRepository;

  IndependentVolunteerPage({Key key, @required this.authRepository})
      : assert(authRepository != null),
        super(key: key);

  Widget build(BuildContext context) {
    return ScaffoldScroll(
      child: _blocProvider(context),
    );
  }

  Widget _blocProvider(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return IndependentSignUpBloc(
          authRepository: authRepository,
        );
      },
      child: _content(context),
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
            style: TextStyle(
              fontSize: 16.0,
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
          onPressed: () {
            _onLoginButtonPressed(context);
          },
        )
      ],
    );
  }

  void _onLoginButtonPressed(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(
      AuthenticationLoggedOut(),
    );
  }

}
