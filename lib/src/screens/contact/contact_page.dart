import 'package:flutter/material.dart';
import 'package:trashtagApp/src/screens/home/home_page.dart';
import 'package:trashtagApp/src/widgets/menu.dart';
import 'package:trashtagApp/src/widgets/trashtag_app_bar.dart';

class ContactPage extends StatefulWidget {
  ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onSendButton() {
    showDialog(
      context: context,
      builder: (BuildContext context) => _successAlert(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: _content(context),
        ),
      ),
      bottomNavigationBar: Menu(),
    );
  }

  Widget _content(BuildContext context) {
    return Stack(
      children: <Widget>[
        _background(),
        _foreground(context),
      ],
    );
  }

  Widget _background() {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).backgroundColor,
          height: 270.0,
        ),
      ],
    );
  }

  Widget _foreground(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width * 0.85,
        child: Column(
          children: <Widget>[
            SizedBox(height: 80.0),
            _title(),
            SizedBox(height: 40.0),
            _input(context),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Column(
      children: <Widget>[
        Text(
          'Say hello!',
          style: TextStyle(fontSize: 40.0, color: Colors.white),
        ),
        Text(
          'Contact us by email or leave us your message',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25.0, color: Colors.white),
        ),
      ],
    );
  }

  Widget _input(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(hintText: 'Enter your subject'),
            keyboardType: TextInputType.emailAddress,
            // controller: _subjectController,
          ),
          SizedBox(height: 25.0),
          TextFormField(
            maxLines: 4,
            decoration: InputDecoration(hintText: 'Enter your message'),
            keyboardType: TextInputType.emailAddress,
            // controller: _messageController,
          ),
          SizedBox(height: 40.0),
          _sendButton(),
        ],
      ),
    );
  }

  Widget _sendButton() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          'SEND MESSAGE',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        onPressed: _onSendButton,
      ),
    );
  }

  Widget _successAlert() {
    return AlertDialog(
      title: Text('Thanks!'),
      content: Text('We will send you a message as soon as we can.'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: Text(
            'GO TO MY DASHBOARD',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
    );
  }
}
