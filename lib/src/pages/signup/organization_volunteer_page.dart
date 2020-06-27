import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/authentication/authentication_bloc.dart';
import 'package:trashtagApp/src/pages/signup/organization_volunteer_form.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';
import 'package:trashtagApp/src/widgets/trashtag_logo.dart';

class OrganizationVolunteerPage extends StatefulWidget {
  OrganizationVolunteerPage({Key key}) : super(key: key);

  @override
  _OrganizationVolunteerPageState createState() =>
      _OrganizationVolunteerPageState();
}

class _OrganizationVolunteerPageState extends State<OrganizationVolunteerPage> {
  @override
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
          TrashTagLogo(),
          SizedBox(height: 25.0),
          _title(),
          SizedBox(height: 25.0),
          OrganizationVolunteerForm(),
          SizedBox(height: 40.0),
          _logIn(context),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }

  Widget _title() {
    return PageTitle(
      title: 'Organizer volunteer',
      subTitle:
          'Sign up as an organization volunteer if you belong to an afficial organization.',
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
