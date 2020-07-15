import 'package:rxdart/rxdart.dart';
import 'package:trashtagApp/src/validators/validators.dart';

class CreateOrganizationController with Validators {
  CreateOrganizationController();

  final _nameController = BehaviorSubject<String>();
  final _areaController = BehaviorSubject<String>();
  final _phoneOneController = BehaviorSubject<String>();
  final _phoneTwoController = BehaviorSubject<String>();
  final _addressController = BehaviorSubject<String>();
  final _managerNameController = BehaviorSubject<String>();
  final _managerPhoneController = BehaviorSubject<String>();
  final _managerEmailController = BehaviorSubject<String>();

  Stream<String> get nameStream =>
      _nameController.stream.transform(validateName);
  Stream<String> get areaStream =>
      _areaController.stream.transform(validateName);
  Stream<String> get phoneOneStream =>
      _phoneOneController.stream.transform(validatePhone);
  Stream<String> get phoneTwoStream =>
      _phoneTwoController.stream.transform(validatePhone);
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
      phoneOneStream,
      phoneTwoStream,
      addressStream,
      managerNameStream,
      managerPhoneStream,
      managerEmailStream,
      (
        name,
        area,
        phoneOne,
        phoneTwo,
        address,
        managerName,
        managerPhone,
        managerEmail,
      ) =>
          true);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeArea => _areaController.sink.add;
  Function(String) get changePhoneOne => _phoneOneController.sink.add;
  Function(String) get changePhoneTwo => _phoneTwoController.sink.add;
  Function(String) get changeAddress => _addressController.sink.add;
  Function(String) get changeManagerName => _managerNameController.sink.add;
  Function(String) get changeManagerPhone => _managerPhoneController.sink.add;
  Function(String) get changeManagerEmail => _managerEmailController.sink.add;

  String get name => _nameController.value;
  String get area => _areaController.value;
  String get phoneOne => _phoneOneController.value;
  String get phoneTwo => _phoneTwoController.value;
  String get address => _addressController.value;
  String get managerName => _managerNameController.value;
  String get managerPhone => _managerPhoneController.value;
  String get managerEmail => _managerEmailController.value;

  void dispose() {
    _nameController?.close();
    _areaController?.close();
    _phoneOneController?.close();
    _phoneTwoController?.close();
    _addressController?.close();
    _managerNameController?.close();
    _managerPhoneController?.close();
    _managerEmailController?.close();
  }
}
