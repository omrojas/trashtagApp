import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/login/login_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  _onLoginButtonPressed() {
    BlocProvider.of<LoginBloc>(context).add(
      LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return _form(state);
        },
      ),
    );
  }

  Widget _form(LoginState state) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: 'Enter your email'),
            keyboardType: TextInputType.emailAddress,
            controller: _usernameController,
          ),
          SizedBox(height: 25.0),
          TextFormField(
            decoration: InputDecoration(hintText: 'Enter your password'),
            obscureText: true,
            controller: _passwordController,
          ),
          SizedBox(height: 40.0),
          _loginButton(state),
          _progressIndicator(state)
        ],
      ),
    );
  }

  Widget _loginButton(LoginState state) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          'GO TO MY DASHBOARD',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        onPressed: state is! LoginInProgress ? _onLoginButtonPressed : null,
      ),
    );
  }

  Widget _progressIndicator(LoginState state) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: state is LoginInProgress ? CircularProgressIndicator() : null,
    );
  }
}
