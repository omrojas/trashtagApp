import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/login/login_bloc.dart';
import 'package:trashtagApp/src/stream_controllers/login/login_stream_controller.dart';
import 'package:trashtagApp/src/widgets/trashtag_button.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _streamController = LoginController();
  bool _passwordVisible = true;

  void _onLoginButtonPressed() {
    BlocProvider.of<LoginBloc>(context).add(
      LoginButtonPressed(
        username: _streamController.email,
        password: _streamController.password,
      ),
    );
  }

  void _changePasswordVisible() {
    setState(() => _passwordVisible = !_passwordVisible);
  }

  @override
  void dispose() {
    _streamController.dispose();
    super.dispose();
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
          _email(),
          SizedBox(height: 25.0),
          _password(),
          SizedBox(height: 40.0),
          _loginButton(state),
          _progressIndicator(state)
        ],
      ),
    );
  }

  Widget _email() {
    return StreamBuilder<String>(
      stream: _streamController.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter your email',
            errorText: snapshot.error,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: _streamController.changeEmail,
        );
      },
    );
  }

  Widget _password() {
    return StreamBuilder<String>(
      stream: _streamController.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter your password',
            errorText: snapshot.error,
            suffixIcon: IconButton(
              icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: _changePasswordVisible,
            ),
          ),
          obscureText: _passwordVisible,
          onChanged: _streamController.changePassword,
        );
      },
    );
  }

  Widget _loginButton(LoginState state) {
    return TrashTagButton(
      text: 'GO TO MY DASHBOARD',
      stream: _streamController.validFormStream,
      function: state is! LoginInProgress ? _onLoginButtonPressed : null,
    );
  }

  Widget _progressIndicator(LoginState state) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: state is LoginInProgress ? CircularProgressIndicator() : null,
    );
  }
}
