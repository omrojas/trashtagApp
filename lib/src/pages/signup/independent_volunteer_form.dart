import 'package:flutter/material.dart';

class IdependentVolunteerForm extends StatefulWidget {
  IdependentVolunteerForm({Key key}) : super(key: key);

  @override
  _IdependentVolunteerFormState createState() =>
      _IdependentVolunteerFormState();
}

class _IdependentVolunteerFormState extends State<IdependentVolunteerForm> {
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
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your password',
              helperText: 'Password must contain 8 characters min.',
            ),
          ),
          SizedBox(height: 40),
          _createAccountButton(),
        ],
      ),
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
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        onPressed: null,
      ),
    );
  }

  Widget _message() {
    return Text('By creating an account, you agree to our ...');
  }
}
