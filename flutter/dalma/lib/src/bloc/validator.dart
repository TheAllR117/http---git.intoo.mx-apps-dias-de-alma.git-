import 'dart:async';

class Validators {
  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Correo no valido');
    }
  });

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('La contraseña debe tener almenos 6 caracteres.');
    }
  });

  final validarName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length >= 3) {
      sink.add(name);
    } else {
      sink.addError('El nombre debe tener almenos 6 caracteres.');
    }
  });

  final validarLastName = StreamTransformer<String, String>.fromHandlers(
      handleData: (lastName, sink) {
    if (lastName.length >= 3) {
      sink.add(lastName);
    } else {
      sink.addError('Introduce tus apellidos');
    }
  });

  final validarBirthday = StreamTransformer<String, String>.fromHandlers(
      handleData: (birthday, sink) {
    if (birthday.length >= 10) {
      sink.add(birthday);
    } else {
      sink.addError(null);
    }
  });

  final validarCircle = StreamTransformer<String, String>.fromHandlers(
      handleData: (circle, sink) {
    if (circle.length != null) {
      sink.add(circle);
    } else {
      sink.addError(null);
    }
  });

  final validarPlay = StreamTransformer<Duration, Duration>.fromHandlers(
      handleData: (play, sink) {
    if (play != null) {
      sink.add(play);
    } else {
      sink.addError(null);
    }
  });
}
