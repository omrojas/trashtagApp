import 'package:rxdart/rxdart.dart';
import 'package:trashtagApp/src/validators/validators.dart';

class ContactController with Validators {
  ContactController();

  final _subjectController = BehaviorSubject<String>();
  final _messageController = BehaviorSubject<String>();

  Stream<String> get subjectStream =>
      _subjectController.stream.transform(validateSubject);

  Stream<String> get messageStream =>
      _messageController.stream.transform(validateMessage);

  Stream<bool> get validFormStream => Rx.combineLatest2(
      subjectStream, messageStream, (subject, message) => true);

  Function(String) get changeSubject => _subjectController.sink.add;

  Function(String) get changeMessage => _messageController.sink.add;

  String get subject => _subjectController.value;
  String get message => _messageController.value;

  void dispose() {
    _subjectController?.close();
    _messageController?.close();
  }
}
