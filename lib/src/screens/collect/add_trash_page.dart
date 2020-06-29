import 'package:flutter/material.dart';
import 'package:trashtagApp/src/screens/collect/collect_page.dart';
import 'package:trashtagApp/src/widgets/menu.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';
import 'package:trashtagApp/src/widgets/trashtag_app_bar.dart';

class AddTrahsPage extends StatefulWidget {
  AddTrahsPage({Key key}) : super(key: key);

  @override
  _AddTrahsPageState createState() => _AddTrahsPageState();
}

class _AddTrahsPageState extends State<AddTrahsPage> {
  void _onSubmitItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) => _successAlert(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _content(),
        ),
      ),
      bottomNavigationBar: Menu(),
    );
  }

  Widget _content() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          _title(),
          SizedBox(height: 25),
          _form(),
        ],
      ),
    );
  }

  Widget _title() {
    return PageTitle(
      title: 'New item',
      subTitle: 'Submit a petition for a non-listed item you found.',
    );
  }

  Widget _form() {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(hintText: 'Enter a name'),
          keyboardType: TextInputType.emailAddress,
          // controller: _messageController,
        ),
        SizedBox(height: 25.0),
        TextFormField(
          decoration: InputDecoration(hintText: 'Upload an image'),
          keyboardType: TextInputType.emailAddress,
          // controller: _messageController,
        ),
        SizedBox(height: 40.0),
        _submitItemButton(),
      ],
    );
  }

  Widget _submitItemButton() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          'SUBMIT ITEM',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        onPressed: _onSubmitItem,
      ),
    );
  }

  Widget _successAlert() {
    return AlertDialog(
      title: Text('Thanks!'),
      content: Text('We will inspect the item and upload to our database.'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CollectPage()),
            );
          },
          child: Text(
            'RESUME CLEAN UP',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
    );
  }
}
