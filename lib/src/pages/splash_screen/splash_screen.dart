import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/authentication/authentication_bloc.dart';
import 'package:trashtagApp/src/widgets/trashtag_logo.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _onLoginButtonPressed() {
    print('_onLoginButtonPressed');
    BlocProvider.of<AuthenticationBloc>(context).add(
      LoginButtonPressed(),
    );
  }

  _onSignUpAsIndependentVolunteer() {
    BlocProvider.of<AuthenticationBloc>(context).add(
      SignUpAsIndependentVolunterrButtonPresed(),
    );
  }

  _onSignUpAsOrganizationVolunteer() {
    BlocProvider.of<AuthenticationBloc>(context).add(
      SignUpAsOrganizationVolunterrButtonPresed(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: _content(),
        ),
      ),
    );
  }

  Widget _content() {
    return Container(
      padding: EdgeInsets.all(25.0),
      child: Column(
        children: <Widget>[
          TrashTagLogo(
            mainAxisAlignment: MainAxisAlignment.end,
          ),
          SizedBox(height: 20.0),
          _welcomeMessage(),
          SizedBox(height: 40.0),
          _loginButton(),
          SizedBox(height: 40.0),
          _signUp(),
        ],
      ),
    );
  }

  Widget _welcomeMessage() {
    return Container(
      child: ListTile(
        title: Text(
          'Join us in this adveture.',
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.amber,
        child: Text(
          'LOG IN',
          style: TextStyle(color: Colors.white70, fontSize: 18.0),
        ),
        onPressed: _onLoginButtonPressed,
      ),
    );
  }

  Widget _signUp() {
    return Container(
      child: Column(
        children: <Widget>[
          Text('New member? Sign up as a'),
          SizedBox(height: 20.0),
          FlatButton(
            child: Text(
              'INDEPENDENT VOLUNTEER',
              style: TextStyle(color: Colors.amber, fontSize: 18.0),
            ),
            onPressed: _onSignUpAsIndependentVolunteer,
          ),
          FlatButton(
            child: Text(
              'ORGANIZATION VOLUNTEER',
              style: TextStyle(color: Colors.amber, fontSize: 18.0),
            ),
            onPressed: _onSignUpAsOrganizationVolunteer,
          )
        ],
      ),
    );
  }
}
