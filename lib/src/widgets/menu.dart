import 'package:flutter/material.dart';
import 'package:trashtagApp/src/screens/collect/collect_page.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: _content(),
    );
  }

  Widget _content() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: _tems(),
    );
  }

  Widget _tems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _homeButton(),
        _collectButton(),
        _yourListButton(),
      ],
    );
  }

  Widget _homeButton() {
    return _menuButton(
      name: 'Home',
      assetName: 'assets/images/home.png',
      onPresed: () {
        print('home');
      },
    );
  }

  Widget _collectButton() {
    return _menuButton(
      name: 'Collect',
      assetName: 'assets/images/clean-up.png',
      onPresed: () {
        print('Collect');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CollectPage()),
        );
      },
    );
  }

  Widget _yourListButton() {
    return _menuButton(
      name: 'Your List',
      assetName: 'assets/images/my-list.png',
      onPresed: () {
        print('Your List');
      },
    );
  }

  Widget _menuButton({String name, String assetName, Function onPresed}) {
    return _buttonContainer(
        child: FlatButton(
      onPressed: onPresed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buttonIcon(assetName: assetName),
          _buttonText(text: name),
        ],
      ),
    ));
  }

  Widget _buttonContainer({FlatButton child}) {
    return Container(
      height: 65.0,
      child: child,
    );
  }

  Widget _buttonIcon({String assetName}) {
    return Container(
      height: 40.0,
      width: 60.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(assetName),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buttonText({String text}) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
