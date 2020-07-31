import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/home/home_bloc.dart';

class Menu extends StatelessWidget {
  void _onHomeButtonPressed(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(
      HomeButtonPressed(),
    );
  }

  void _onCollectButtonPressed(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(
      CollectButtonPressed(),
    );
  }

  void _onListButtonPressed(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(
      UserListButtonPressed(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: _tems(context),
    );
  }

  Widget _tems(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _homeButton(context),
        _collectButton(context),
        _yourListButton(context),
      ],
    );
  }

  Widget _homeButton(BuildContext context) {
    return _menuButton(
      context: context,
      name: 'Home',
      assetName: 'assets/images/home.png',
      onPresed: () {
        _onHomeButtonPressed(context);
      },
    );
  }

  Widget _collectButton(BuildContext context) {
    return _menuButton(
      context: context,
      name: 'Collect',
      assetName: 'assets/images/collect.png',
      onPresed: () {
        _onCollectButtonPressed(context);
      },
    );
  }

  Widget _yourListButton(BuildContext context) {
    return _menuButton(
      context: context,
      name: 'Your List',
      assetName: 'assets/images/my-list.png',
      onPresed: () {
        _onListButtonPressed(context);
      },
    );
  }

  Widget _menuButton({
    @required BuildContext context,
    @required String name,
    @required String assetName,
    @required Function onPresed,
  }) {
    return _buttonContainer(
      child: FlatButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buttonIcon(assetName: assetName),
            _buttonText(context: context, text: name),
          ],
        ),
        onPressed: onPresed,
      ),
    );
  }

  Widget _buttonContainer({@required FlatButton child}) {
    return Container(
      height: 65.0,
      child: child,
    );
  }

  Widget _buttonIcon({@required String assetName}) {
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

  Widget _buttonText({
    @required BuildContext context,
    @required String text,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
