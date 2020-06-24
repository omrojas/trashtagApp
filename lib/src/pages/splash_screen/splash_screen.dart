import 'package:flutter/material.dart';
import 'package:trashtagApp/src/pages/login/login_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: _content(),
        ),
      ),
    );
  }

  Widget _content() {
    return Container(
      padding: EdgeInsets.all(25.0),
      child: Column(
        children: <Widget>[
          _logo(),
          SizedBox(height: 20.0),
          _welcomeMessage(),
          SizedBox(height: 20.0),
          _loginButton(),
          SizedBox(height: 20.0),
          _signUp(),
        ],
      ),
    );
  }

  Widget _logo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          height: 100.0,
          width: 180.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.center,
              image: AssetImage('assets/images/trashtag.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _welcomeMessage() {
    return Container(
      child: ListTile(
        title: Text(
          'Join us in this adveture.',
          style: TextStyle(fontSize: 70),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.amber,
        child: Text(
          'LOG IN',
          style: TextStyle(color: Colors.white70, fontSize: 18.0),
        ),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          )
        },
      ),
    );
  }

  Widget _signUp() {
    return Container(
      child: Column(
        children: <Widget>[
          Text('New member? Sign up as a'),
          SizedBox(height: 20.0),
          FlatButton(
            child: Text(
              'INDEPENDENT VOLUNTEER',
              style: TextStyle(color: Colors.amber, fontSize: 18.0),
            ),
            onPressed: null,
          ),
          SizedBox(height: 20.0),
          FlatButton(
            child: Text(
              'ORGANIZATION VOLUNTEER',
              style: TextStyle(color: Colors.amber, fontSize: 18.0),
            ),
            onPressed: null,
          )
        ],
      ),
    );
  }
}
