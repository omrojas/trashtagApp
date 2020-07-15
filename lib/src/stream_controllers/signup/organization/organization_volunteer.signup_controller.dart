import 'package:rxdart/rxdart.dart';
import 'package:trashtagApp/src/stream_controllers/signup/signup_controller.dart';

class OrganizationVolunterSignUpController extends SignUpController {
  OrganizationVolunterSignUpController();

  final _organizationController = BehaviorSubject<int>();

  Stream<int> get organizationStream => _organizationController.stream;

  @override
  Stream<bool> get validFormStream => Rx.combineLatest5(
      firstNameStream,
      lastNameStream,
      emailStream,
      passwordStream,
      organizationStream,
      (firstName, lastName, email, password, organization) => true);

  Function(int) get changeOrganization => _organizationController.sink.add;

  int get organization => _organizationController.value;

  void dispose() {
    _organizationController?.close();
    super.dispose();
  }
}
