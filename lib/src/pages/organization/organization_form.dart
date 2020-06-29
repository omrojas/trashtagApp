import 'package:flutter/material.dart';

class OrganizationForm extends StatefulWidget {
  OrganizationForm({Key key}) : super(key: key);

  @override
  _OrganizationFormState createState() => _OrganizationFormState();
}

class _OrganizationFormState extends State<OrganizationForm> {
  @override
  Widget build(BuildContext context) {
    return _form();
  }

  Widget _form() {
    return Form(
      child: Column(
        children: <Widget>[
          SizedBox(height: 40.0),
          _organizationInformation(),
          SizedBox(height: 40),
          _managerAccountInformation(),
          SizedBox(height: 60),
          _createOrganizationButton(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _organizationInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Organization information',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 25),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter a name',
          ),
        ),
        SizedBox(height: 25),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter an area',
          ),
        ),
        SizedBox(height: 25),
        _phones(),
        SizedBox(height: 25),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter their address',
          ),
        ),
      ],
    );
  }

  Widget _phones() {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: (size.width / 2) * .8,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter a phone',
            ),
          ),
        ),
        Container(
          width: (size.width / 2) * .8,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter a phone',
            ),
          ),
        ),
      ],
    );
  }

  Widget _managerAccountInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Manager contact information',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 25.0),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter a name',
          ),
        ),
        SizedBox(height: 25.0),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter a phone',
          ),
        ),
        SizedBox(height: 25.0),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter a email',
          ),
        ),
      ],
    );
  }

  Widget _createOrganizationButton() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          'SUBMIT ORGANIZATION',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        onPressed: () => {},
      ),
    );
  }
}
