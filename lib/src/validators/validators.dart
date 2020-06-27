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
          sink.addError('Email no es correcto');
        }
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password != null) {
        if (password.trim().length >= 1) {
          sink.add(password);
        } else {
          sink.addError('Ingrese la contraseña por favor');
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
          sink.addError('Ingrese el nombre por favor');
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
          sink.addError('Ingrese un número valido por favor');
        }
      }
    },
  );
}
