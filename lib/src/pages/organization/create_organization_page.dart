import 'package:flutter/material.dart';
import 'package:trashtagApp/src/pages/organization/organization_form.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';
import 'package:trashtagApp/src/widgets/trashtag_logo.dart';

class CreateOrganizationPage extends StatefulWidget {
  CreateOrganizationPage({Key key}) : super(key: key);

  @override
  _CreateOrganizationPageState createState() => _CreateOrganizationPageState();
}

class _CreateOrganizationPageState extends State<CreateOrganizationPage> {
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
          _title(),
          OrganizationForm(),
          SizedBox(height: 20.0),
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
}
