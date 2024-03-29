import 'package:rxdart/rxdart.dart';

import 'package:trashtagApp/src/validators/validators.dart';

class LoginController with Validators {
  LoginController();

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get validFormStream =>
      Rx.combineLatest2(emailStream, passwordStream, (email, password) => true);

  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  String get email => _emailController.value;
  String get password => _passwordController.value;

  void dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
