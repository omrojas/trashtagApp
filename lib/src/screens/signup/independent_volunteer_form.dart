import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/authentication/authentication_bloc.dart'
    as authentication_bloc;
import 'package:trashtagApp/src/bloc/signup/independent/independent_signup_bloc.dart';
import 'package:trashtagApp/src/models/user.dart';
import 'package:trashtagApp/src/screens/policy/terms_conditions_link.dart';
import 'package:trashtagApp/src/stream_controllers/signup/signup_controller.dart';
import 'package:trashtagApp/src/widgets/trashtag_button.dart';

class IdependentVolunteerForm extends StatefulWidget {
  IdependentVolunteerForm({Key key}) : super(key: key);

  @override
  _IdependentVolunteerFormState createState() =>
      _IdependentVolunteerFormState();
}

class _IdependentVolunteerFormState extends State<IdependentVolunteerForm> {
  final _streamController = SignUpController();
  bool _passwordVisible = true;

  void _changePasswordVisible() {
    setState(() => _passwordVisible = !_passwordVisible);
  }

  void _onSignUpButtonPressed() {
    final user = User(
      firstName: _streamController.firstName,
      lastName: _streamController.lastName,
      email: _streamController.email,
      password: _streamController.password,
    );
    BlocProvider.of<IndependentSignUpBloc>(context).add(
      CreateAccountButtonPressed(user: user),
    );
  }

  void _showMessage({
    @required final String message,
    @required Color backgroundColor,
  }) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  void _blocListener(context, state) {
    if (state is IndependentSignUpFailure) {
      _showMessage(
        message: state.error,
        backgroundColor: Colors.red,
      );
    }
    if (state is IndependentSignUpSuccess) {
      _showMessage(
        message: state.message,
        backgroundColor: Theme.of(context).primaryColor,
      );
      _onSignUpSuccess();
    }
  }

  void _onSignUpSuccess() async {
    await Future.delayed(Duration(seconds: 2));
    BlocProvider.of<authentication_bloc.AuthenticationBloc>(context).add(
      authentication_bloc.LoginButtonPressed(),
    );
  }

  @override
  void dispose() {
    _streamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IndependentSignUpBloc, IndependentSignUpState>(
      listener: _blocListener,
      child: _blocBuilder(),
    );
  }

  Widget _blocBuilder() {
    return BlocBuilder<IndependentSignUpBloc, IndependentSignUpState>(
      builder: (context, state) {
        return _content(state);
      },
    );
  }

  Widget _content(IndependentSignUpState state) {
    return Column(
      children: <Widget>[
        _form(state),
        SizedBox(height: 10),
        _message(),
        TermsAndConditionsLink(),
        _progressIndicator(state)
      ],
    );
  }

  Widget _form(IndependentSignUpState state) {
    return Form(
      child: Column(
        children: <Widget>[
          _firstName(),
          SizedBox(height: 25),
          _lastName(),
          SizedBox(height: 25),
          _email(),
          SizedBox(height: 25),
          _password(),
          SizedBox(height: 40),
          _createAccountButton(state),
        ],
      ),
    );
  }

  Widget _firstName() {
    return StreamBuilder<String>(
      stream: _streamController.firstNameStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter your first name',
            errorText: snapshot.error,
          ),
          onChanged: _streamController.changeFirstName,
        );
      },
    );
  }

  Widget _lastName() {
    return StreamBuilder<String>(
      stream: _streamController.lastNameStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter your last name',
            errorText: snapshot.error,
          ),
          onChanged: _streamController.changeLastName,
        );
      },
    );
  }

  Widget _email() {
    return StreamBuilder<String>(
      stream: _streamController.emailStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter your email',
            errorText: snapshot.error,
          ),
          onChanged: _streamController.changeEmail,
        );
      },
    );
  }

  Widget _password() {
    return StreamBuilder<String>(
      stream: _streamController.passwordStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter your password',
            helperText: 'Password must contain 8 characters min.',
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

  Widget _createAccountButton(IndependentSignUpState state) {
    return TrashTagButton(
      text: 'CREATE YOUR ACCOUNT',
      stream: _streamController.validFormStream,
      function:
          state is! IndependentSignUpInProgress ? _onSignUpButtonPressed : null,
    );
  }

  Widget _message() {
    return Text('By creating an account, you agree to our:');
  }

  Widget _progressIndicator(IndependentSignUpState state) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: state is IndependentSignUpInProgress
          ? CircularProgressIndicator()
          : null,
    );
  }

}
