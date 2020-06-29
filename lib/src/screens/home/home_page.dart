import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/authentication/authentication_bloc.dart';
import 'package:trashtagApp/src/screens/contact/contact_page.dart';
import 'package:trashtagApp/src/screens/home/clean_up.dart';
import 'package:trashtagApp/src/screens/items_collected/items_collected_page.dart';
import 'package:trashtagApp/src/widgets/menu.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';
import 'package:trashtagApp/src/widgets/trashtag_app_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      endDrawer: _endDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _content(),
        ),
      ),
      bottomNavigationBar: Menu(),
    );
  }

  Widget _endDrawer() {
    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: <Widget>[
            SizedBox(height: 40.0),
            ListTile(
              title: Text(
                'Contact',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactPage()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Temp : items collected',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemsCollectedPage()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Log out',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLoggedOut());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _content() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 40.0),
          _message(),
          SizedBox(height: 40.0),
          _options(),
        ],
      ),
    );
  }

  Widget _message() {
    final name = 'Natasha';
    return PageTitle(
      title: 'Hello, $name!',
      subTitle: 'Select an option to continue.',
    );
  }

  Widget _options() {
    return CleanUp();
  }
}
