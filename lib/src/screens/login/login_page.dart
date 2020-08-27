import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/authentication/authentication_bloc.dart';
import 'package:trashtagApp/src/bloc/login/login_bloc.dart';
import 'package:trashtagApp/src/screens/login/login_form.dart';
import 'package:trashtagApp/src/repository/auth_repository.dart';
import 'package:trashtagApp/src/widgets/scaffold_scroll.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';
import 'package:trashtagApp/src/widgets/trashtag_logo.dart';

class LoginPage extends StatelessWidget {
  final AuthRepository authRepository;

  LoginPage({Key key, @required this.authRepository})
      : assert(authRepository != null),
        super(key: key);

  _onSignUpButtonPressed(context) {
    BlocProvider.of<AuthenticationBloc>(context).add(
      AuthenticationStarted(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldScroll(
      child: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          TrashTagLogo(
            assetName: 'assets/images/TrashTagLogo02.png',
          ),
          SizedBox(height: 25.0),
          _title(),
          SizedBox(height: 40.0),
          _loginForm(),
          _signUp(context),
        ],
      ),
    );
  }

  Widget _title() {
    return PageTitle(
      title: 'Welcome back',
      subTitle: 'Log in to your account to continue your journey.',
    );
  }

  Widget _loginForm() {
    return BlocProvider(
      create: (context) {
        return LoginBloc(
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          authRepository: authRepository,
        );
      },
      child: LoginForm(),
    );
  }

  Widget _signUp(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Don't have an account?",
          style: TextStyle(fontSize: 16.0),
        ),
        FlatButton(
          child: Text(
            "Sign up",
            style: TextStyle(
              fontSize: 16.0,
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
          onPressed: () {
            return _onSignUpButtonPressed(context);
          },
        )
      ],
    );
  }
}
