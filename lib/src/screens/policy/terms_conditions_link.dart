import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/authentication/authentication_bloc.dart';

class TermsAndConditionsLink extends StatelessWidget {
  const TermsAndConditionsLink({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _termsAndConditionsLink(context);
  }

  Widget _termsAndConditionsLink(BuildContext context) {
    return FlatButton(
      child: Text(
        "Terms and Conditions.",
        style: TextStyle(
          fontSize: 16.0,
          color: Theme.of(context).primaryColor,
          decoration: TextDecoration.underline,
        ),
      ),
      onPressed: () => _onTermsButtonPressed(context),
    );
  }

  void _onTermsButtonPressed(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(
      TermsButtonPressed(),
    );
  }

}
