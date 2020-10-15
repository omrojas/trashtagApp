import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/authentication/authentication_bloc.dart'
    as authentication_bloc;
import 'package:trashtagApp/src/bloc/signup/organizer/organizer_signup_bloc.dart';
import 'package:trashtagApp/src/models/organization.dart';
import 'package:trashtagApp/src/models/user.dart';
import 'package:trashtagApp/src/screens/policy/terms_conditions_link.dart';
import 'package:trashtagApp/src/stream_controllers/signup/organization/organization_volunteer.signup_controller.dart';
import 'package:trashtagApp/src/widgets/trashtag_button.dart';

class OrganizationVolunteerForm extends StatefulWidget {
  const OrganizationVolunteerForm({Key key}) : super(key: key);

  @override
  _OrganizationVolunteerFormState createState() =>
      _OrganizationVolunteerFormState();
}

class _OrganizationVolunteerFormState extends State<OrganizationVolunteerForm> {
  final _streamController = OrganizationVolunterSignUpController();
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
    BlocProvider.of<OrganizerSignUpBloc>(context).add(
      CreateAccountButtonPressed(
        user: user,
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

  void _loadOrganizations() {
    BlocProvider.of<OrganizerSignUpBloc>(context).add(
      LoadOrganizations(),
    );
  }

  List<DropdownMenuItem> _getOrganizationsDropdownMenuItems(
    List<Organization> organizations,
  ) {
    List<DropdownMenuItem<int>> items = [];
    organizations.forEach((e) {
      final item = DropdownMenuItem<int>(
        value: int.parse('${e.id}'),
        child: Text('${e.name}'),
      );
      items.add(item);
    });
    return items;
  }

  @override
  void initState() {
    super.initState();
    _loadOrganizations();
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
        _form(state),
        SizedBox(height: 10),
        _message(),
        TermsAndConditionsLink(),
      ],
    );
  }

  Widget _form(OrganizerSignUpState state) {
    return Form(
      child: Column(
        children: <Widget>[
          _createOrganization(),
          _selectOrganization(),
          SizedBox(height: 25),
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
    return BlocBuilder<OrganizerSignUpBloc, OrganizerSignUpState>(
      builder: (BuildContext context, state) {
        if (state is OrganizationsLoaded) {
          return StreamBuilder<int>(
            stream: _streamController.organizationStream,
            builder: (context, snapshot) {
              return DropdownButton<int>(
                icon: Icon(Icons.arrow_drop_down),
                isExpanded: true,
                iconSize: 35,
                disabledHint: Text('No organizations available.'),
                hint: Text('Select organization'),
                value: _streamController.organization,
                items: _getOrganizationsDropdownMenuItems(state.organizations),
                onChanged: (int organization) {
                  setState(() {
                    _streamController.changeOrganization(organization);
                  });
                },
              );
            },
          );
        }
        return Text('Loading organizations...');
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

  Widget _createAccountButton(OrganizerSignUpState state) {
    return TrashTagButton(
      text: 'CREATE YOUR ACCOUNT',
      stream: _streamController.validFormStream,
      function:
          state is! OrganizerSignUpInProgress ? _onSignUpButtonPressed : null,
    );
  }

  Widget _message() {
    return Text('By creating an account, you agree to our Terms.');
  }
}
