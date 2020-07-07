import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/authentication/authentication_bloc.dart'
    as authentication_bloc;
import 'package:trashtagApp/src/bloc/signup/organizer/organizer_signup_bloc.dart';
import 'package:trashtagApp/src/stream_controllers/signup/organization/organization_volunteer.signup_controller.dart';

class OrganizationVolunteerForm extends StatefulWidget {
  const OrganizationVolunteerForm({Key key}) : super(key: key);

  @override
  _OrganizationVolunteerFormState createState() =>
      _OrganizationVolunteerFormState();
}

class _OrganizationVolunteerFormState extends State<OrganizationVolunteerForm> {
  final _streamController = OrganizationVolunterSignUpController();
  List<DropdownMenuItem<int>> _organizations = [];
  bool _passwordVisible = true;

  void _changePasswordVisible() {
    setState(() => _passwordVisible = !_passwordVisible);
  }

  void _onSignUpButtonPresed() {
    BlocProvider.of<OrganizerSignUpBloc>(context).add(
      CreateAccountButtonPressed(
        name: _streamController.name,
        email: _streamController.email,
        password: _streamController.password,
        organizationId: _streamController.organization,
      ),
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
    if (state is OrganizerSignUpFailure) {
      _showMessage(
        message: state.error,
        backgroundColor: Colors.red,
      );
    }
    if (state is OrganizerSignUpSuccess) {
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

  void _onCreateOrganizationButtonPressed() {
    BlocProvider.of<OrganizerSignUpBloc>(context).add(
      CreateOrganizationButtonPressed(),
    );
  }

  @override
  void dispose() {
    _streamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrganizerSignUpBloc, OrganizerSignUpState>(
      listener: _blocListener,
      child: _blocBuilder(),
    );
  }

  Widget _blocBuilder() {
    return BlocBuilder<OrganizerSignUpBloc, OrganizerSignUpState>(
      builder: (context, state) {
        return _content(state);
      },
    );
  }

  Widget _content(OrganizerSignUpState state) {
    return Column(
      children: <Widget>[
        _form(),
        SizedBox(height: 10),
        _message(),
      ],
    );
  }

  Widget _form() {
    return Form(
      child: Column(
        children: <Widget>[
          _createOrganization(),
          _selectOrganization(),
          SizedBox(height: 25),
          _name(),
          SizedBox(height: 25),
          _email(),
          SizedBox(height: 25),
          _password(),
          SizedBox(height: 40),
          _createAccountButton(),
        ],
      ),
    );
  }

  Widget _name() {
    return StreamBuilder<String>(
      stream: _streamController.nameStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter your name',
            errorText: snapshot.error,
          ),
          onChanged: _streamController.changeName,
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

  Widget _createOrganization() {
    return ListTile(
      contentPadding: EdgeInsets.all(0.0),
      title: Text(
        'Add your organization',
        textAlign: TextAlign.end,
      ),
      trailing: Icon(Icons.add),
      onTap: _onCreateOrganizationButtonPressed,
    );
  }

  Widget _selectOrganization() {
    return StreamBuilder<int>(
      stream: _streamController.organizationStream,
      builder: (context, snapshot) {
        return DropdownButton<int>(
          icon: Icon(Icons.arrow_drop_down),
          isExpanded: true,
          iconSize: 35,
          hint: Text('Select organization'),
          value: _streamController.organization,
          items: _organizations,
          onChanged: (int organization) {
            _streamController.changeOrganization(organization);
            setState(() {});
          },
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
            hintText: 'Enter your passwords',
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

  Widget _createAccountButton() {
    return StreamBuilder<bool>(
      stream: _streamController.validFormStream,
      builder: (context, snapshot) {
        return Container(
          width: double.infinity,
          child: RaisedButton(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              'CREATE YOUR ACCOUNT',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: snapshot.hasData ? _onSignUpButtonPresed : null,
          ),
        );
      },
    );
  }

  Widget _message() {
    return Text('By creating an account, you agree to our ...');
  }
}
