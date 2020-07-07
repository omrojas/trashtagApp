import 'package:rxdart/rxdart.dart';
import 'package:trashtagApp/src/validators/validators.dart';

class CreateOrganizationController with Validators {
  CreateOrganizationController();

  final _nameController = BehaviorSubject<String>();
  final _areaController = BehaviorSubject<String>();
  final _phone1Controller = BehaviorSubject<String>();
  final _phone2Controller = BehaviorSubject<String>();
  final _addressController = BehaviorSubject<String>();
  final _managerNameController = BehaviorSubject<String>();
  final _managerPhoneController = BehaviorSubject<String>();
  final _managerEmailController = BehaviorSubject<String>();

  Stream<String> get nameStream =>
      _nameController.stream.transform(validateName);
  Stream<String> get areaStream =>
      _areaController.stream.transform(validateName);
  Stream<String> get phone1Stream =>
      _phone1Controller.stream.transform(validatePhone);
  Stream<String> get phone2Stream =>
      _phone2Controller.stream.transform(validatePhone);
  Stream<String> get addressStream =>
      _addressController.stream.transform(validateName);
  Stream<String> get managerNameStream =>
      _managerNameController.stream.transform(validateName);
  Stream<String> get managerPhoneStream =>
      _managerPhoneController.stream.transform(validatePhone);
  Stream<String> get managerEmailStream =>
      _managerEmailController.stream.transform(validateEmail);

  Stream<bool> get validFormStream => Rx.combineLatest8(
      nameStream,
      areaStream,
      phone1Stream,
      phone2Stream,
      addressStream,
      managerNameStream,
      managerPhoneStream,
      managerEmailStream,
      (
        name,
        area,
        phone1,
        phone2,
        address,
        managerName,
        managerPhone,
        managerEmail,
      ) =>
          true);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeArea => _areaController.sink.add;
  Function(String) get changePhone1 => _phone1Controller.sink.add;
  Function(String) get changePhone2 => _phone2Controller.sink.add;
  Function(String) get changeAddress => _addressController.sink.add;
  Function(String) get changeManagerName => _managerNameController.sink.add;
  Function(String) get changeManagerPhone => _managerPhoneController.sink.add;
  Function(String) get changeManagerEmail => _managerEmailController.sink.add;

  String get name => _nameController.value;
  String get area => _areaController.value;
  String get phone1 => _phone1Controller.value;
  String get phone2 => _phone2Controller.value;
  String get address => _addressController.value;
  String get managerName => _managerNameController.value;
  String get managerPhone => _managerPhoneController.value;
  String get managerEmail => _managerEmailController.value;

  void dispose() {
    _nameController?.close();
    _areaController?.close();
    _phone1Controller?.close();
    _phone2Controller?.close();
    _addressController?.close();
    _managerNameController?.close();
    _managerPhoneController?.close();
    _managerEmailController?.close();
  }
}
