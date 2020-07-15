import 'package:rxdart/rxdart.dart';
import 'package:trashtagApp/src/validators/validators.dart';

class SignUpController with Validators {
  SignUpController();

  final _firstNameController = BehaviorSubject<String>();
  final _lastNameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get firstNameStream =>
      _firstNameController.stream.transform(validateName);

  Stream<String> get lastNameStream =>
      _lastNameController.stream.transform(validateName);

  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get validFormStream => Rx.combineLatest3(firstNameStream,
      emailStream, passwordStream, (firstName, email, password) => true);

  Function(String) get changeFirstName => _firstNameController.sink.add;
  Function(String) get changeLastName => _lastNameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String get firstName => _firstNameController.value;
  String get lastName => _lastNameController.value;
  String get email => _emailController.value;
  String get password => _passwordController.value;

  void dispose() {
    _firstNameController?.close();
    _lastNameController?.close();
    _emailController?.close();
    _passwordController?.close();
  }
}
