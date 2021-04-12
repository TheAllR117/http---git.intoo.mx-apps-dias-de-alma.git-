import 'dart:async';
import 'package:dalma/src/bloc/validator.dart';
import 'package:rxdart/subjects.dart';

class ResetPasswordBloc with Validators {
  final _emailController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);

  // insertar valores al string
  Function(String) get changeEmail => _emailController.sink.add;

  String get email => _emailController.value;

  dispose() {
    _emailController?.close();
  }
}
