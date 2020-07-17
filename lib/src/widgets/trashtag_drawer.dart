import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/authentication/authentication_bloc.dart';
import 'package:trashtagApp/src/bloc/home/home_bloc.dart';

class TrashTagDrawer extends StatelessWidget {
  const TrashTagDrawer({Key key}) : super(key: key);

  void _onContactButtonPressed(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(
      ContactButtonPressed(),
    );
  }

  void _onLogOut(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(
      AuthenticationLoggedOut(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _endDrawer(context);
  }

  Widget _endDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: <Widget>[
            SizedBox(height: 40.0),
            _option(
              context: context,
              text: 'Contact',
              onPresed: () => _onContactButtonPressed(context),
            ),
            _option(
              context: context,
              text: 'Log out',
              onPresed: () => _onLogOut(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _option({
    @required BuildContext context,
    @required final String text,
    @required Function onPresed,
  }) {
    return ListTile(
      title: Text(
        '$text',
        style: TextStyle(color: Colors.white),
      ),
      onTap: () {
        Navigator.of(context).pop();
        onPresed();
      },
    );
  }
}
