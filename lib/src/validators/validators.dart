import 'dart:async';

class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);
      if (email != null) {
        if (regExp.hasMatch(email)) {
          sink.add(email);
        } else {
          sink.addError('Enter a valid email');
        }
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password != null) {
        if (password.trim().length >= 8) {
          sink.add(password);
        } else {
          sink.addError('Enter a valid password');
        }
      }
    },
  );

  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if (name != null) {
        if (name.trim().length >= 1) {
          sink.add(name);
        } else {
          sink.addError('Enter a valid name');
        }
      }
    },
  );

  final validatePhone = StreamTransformer<String, String>.fromHandlers(
    handleData: (phone, sink) {
      Pattern pattern = r'[0-9]{10}';
      RegExp regExp = new RegExp(pattern);

      if (phone != null) {
        if (phone.toString().length == 10 && regExp.hasMatch(phone)) {
          sink.add(phone);
        } else {
          sink.addError('Enter a valid number');
        }
      }
    },
  );

  final validateSubject = StreamTransformer<String, String>.fromHandlers(
    handleData: (subject, sink) {
      if (subject != null) {
        if (subject.trim().length >= 10) {
          sink.add(subject);
        } else {
          sink.addError('Enter at least 10 characters');
        }
      }
    },
  );

  final validateMessage = StreamTransformer<String, String>.fromHandlers(
    handleData: (message, sink) {
      if (message != null) {
        if (message.trim().length >= 10) {
          sink.add(message);
        } else {
          sink.addError('Enter at least 10 characters');
        }
      }
    },
  );
}
