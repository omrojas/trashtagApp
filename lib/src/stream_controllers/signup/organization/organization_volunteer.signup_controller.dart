import 'package:rxdart/rxdart.dart';
import 'package:trashtagApp/src/validators/validators.dart';

class OrganizationVolunterSignUpController with Validators {
  OrganizationVolunterSignUpController();

  final _nameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _organizationController = BehaviorSubject<int>();

  Stream<String> get nameStream =>
      _nameController.stream.transform(validateName);

  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<int> get organizationStream => _organizationController.stream;

  Stream<bool> get validFormStream => Rx.combineLatest4(
      nameStream,
      emailStream,
      passwordStream,
      organizationStream,
      (name, email, password, organization) => true);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(int) get changeOrganization => _organizationController.sink.add;

  String get name => _nameController.value;
  String get email => _emailController.value;
  String get password => _passwordController.value;
  int get organization => _organizationController.value;

  void dispose() {
    _nameController?.close();
    _emailController?.close();
    _passwordController?.close();
    _organizationController?.close();
  }
}
