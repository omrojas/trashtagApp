import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/create_organization/create_organization_bloc.dart';
import 'package:trashtagApp/src/bloc/signup/organizer/organizer_signup_bloc.dart';
import 'package:trashtagApp/src/repository/organization_repository.dart';
import 'package:trashtagApp/src/screens/organization/create_organization_form.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';
import 'package:trashtagApp/src/widgets/scaffold_scroll.dart';
import 'package:trashtagApp/src/widgets/trashtag_logo.dart';

class CreateOrganizationPage extends StatelessWidget {
  final OrganizationRepository organizationRepository;
  CreateOrganizationPage({Key key, @required this.organizationRepository})
      : assert(organizationRepository != null),
        super(key: key);

  void _onCancelButtonPressed(BuildContext context) async {
    BlocProvider.of<OrganizerSignUpBloc>(context).add(
      OrganizerSignUpStarted(),
    );
  }

  Widget build(BuildContext context) {
    return ScaffoldScroll(
      child: _blocProvider(context),
    );
  }

  Widget _blocProvider(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CreateOrganizationBloc(
          repository: organizationRepository,
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
          TrashTagLogo(
            assetName: 'assets/images/TrashTagLogo02.png',
          ),
          _title(),
          SizedBox(height: 40.0),
          CreateOrganizationForm(),
          _cancel(context),
          SizedBox(height: 25.0),
        ],
      ),
    );
  }

  Widget _title() {
    return PageTitle(
      title: 'New Organization',
      subTitle: 'Submit a new Organization to our database.',
    );
  }

  Widget _cancel(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('I am not sure,'),
        FlatButton(
          onPressed: () {
            _onCancelButtonPressed(context);
          },
          child: Text(
            'Cancel !',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
