import 'dart:async';
import 'package:dalma/src/bloc/validator.dart';
import 'package:rxdart/rxdart.dart';

class RegisteBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _lastNameController = BehaviorSubject<String>();
  final _birthdateController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<String> get nameStream =>
      _nameController.stream.transform(validarName);

  Stream<String> get lastNameStream =>
      _lastNameController.stream.transform(validarLastName);

  Stream<String> get birthdateStream =>
      _birthdateController.stream.transform(validarBirthday);

  Stream<bool> get formValidStream => Rx.combineLatest5(
      emailStream,
      passwordStream,
      nameStream,
      lastNameStream,
      birthdateStream,
      (e, p, n, l, b) => true);

  // insertar valores al string
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeLastName => _lastNameController.sink.add;
  Function(String) get changeBirthdate => _birthdateController.sink.add;

  // obtener el ultimo valor agregado
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get name => _nameController.value;
  String get lastName => _lastNameController.value;
  String get birthdate => _birthdateController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _nameController?.close();
    _lastNameController?.close();
    _birthdateController?.close();
  }
}
