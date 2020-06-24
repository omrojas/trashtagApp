import 'package:flutter/material.dart';
import 'package:trashtagApp/src/pages/home/home_page.dart';
import 'package:trashtagApp/src/pages/signup/signup_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: _content(),
          ),
        ),
      ),
    );
  }

  Widget _content() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          _meesage(),
          _loginForm(),
          SizedBox(height: 20.0),
          _signUp(),
        ],
      ),
    );
  }

  Widget _meesage() {
    return ListTile(
      title: Text(
        'Welcome, back',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
      ),
      subtitle: Text(
        'Log in to your account to continue your journey',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
        child: Column(
      children: <Widget>[
        SizedBox(height: 40.0),
        TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(hintText: 'Enter your email'),
        ),
        SizedBox(height: 25.0),
        TextField(
          obscureText: true,
          decoration: InputDecoration(hintText: 'Enter your password'),
        ),
        SizedBox(height: 25.0),
        Container(
          width: double.infinity,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              'GO TO DASHBOARD',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              )
            },
          ),
        ),
      ],
    ));
  }

  Widget _signUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Don't have an account?",
          style: TextStyle(fontSize: 16.0),
        ),
        FlatButton(
          child: Text(
            "Sign up",
            style: TextStyle(fontSize: 16.0),
          ),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupPage()),
            )
          },
        )
      ],
    );
  }
}
