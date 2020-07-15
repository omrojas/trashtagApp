import 'package:flutter/cupertino.dart';

class User {
  final String email;
  final String firstName;
  final String lastName;
  final String password;

  User({
    @required this.email,
    @required this.firstName,
    @required this.lastName,
    @required this.password,
  });
}
