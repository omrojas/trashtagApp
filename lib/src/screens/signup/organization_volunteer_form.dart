import 'package:flutter/material.dart';
import 'package:trashtagApp/src/screens/organization/create_organization_page.dart';

class OrganizationVolunteerForm extends StatefulWidget {
  const OrganizationVolunteerForm({Key key}) : super(key: key);

  @override
  _OrganizationVolunteerFormState createState() =>
      _OrganizationVolunteerFormState();
}

class _OrganizationVolunteerFormState extends State<OrganizationVolunteerForm> {
  List<DropdownMenuItem<String>> _organizations = [];

  @override
  void initState() {
    super.initState();
    final organization = new DropdownMenuItem(
      child: Text('Create organization page'),
      value: 'id',
    );

    _organizations.add(organization);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your name',
            ),
          ),
          SizedBox(height: 25),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your email',
            ),
          ),
          SizedBox(height: 25),
          _selectOrganization(),
          SizedBox(height: 25),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your passwords',
              helperText: 'Password must contain 8 characters min.',
            ),
          ),
          SizedBox(height: 40),
          _createAccountButton(),
        ],
      ),
    );
  }

  Widget _selectOrganization() {
    return DropdownButton<String>(
      icon: Icon(Icons.arrow_drop_down),
      isExpanded: true,
      iconSize: 35,
      hint: Text('Select organization'),
      // value: _organizations,
      items: _organizations,
      onChanged: (String organization) {},
    );
  }

  Widget _createAccountButton() {
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateOrganizationPage()),
          );
        },
      ),
    );
  }

  Widget _message() {
    return Text('By creating an account, you agree to our ...');
  }
}
