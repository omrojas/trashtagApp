import 'package:rxdart/rxdart.dart';
import 'package:trashtagApp/src/validators/validators.dart';

class IndependentVolunterSignUpController with Validators {
  IndependentVolunterSignUpController();

  final _nameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get nameStream =>
      _nameController.stream.transform(validateName);

  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get validFormStream => Rx.combineLatest3(
      nameStream, emailStream, passwordStream, (name, email, password) => true);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String get name => _nameController.value;
  String get email => _emailController.value;
  String get password => _passwordController.value;

  void dispose() {
    _nameController?.close();
    _emailController?.close();
    _passwordController?.close();
  }
}
