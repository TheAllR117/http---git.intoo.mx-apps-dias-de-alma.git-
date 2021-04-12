import 'dart:async';
import 'package:dalma/src/bloc/validator.dart';
import 'package:rxdart/rxdart.dart';

class UpdateRegisterBloc with Validators {
  final _nameController = BehaviorSubject<String>();
  final _lastNameController = BehaviorSubject<String>();
  final _birthdateController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get nameStream =>
      _nameController.stream.transform(validarName);

  Stream<String> get lastNameStream =>
      _lastNameController.stream.transform(validarLastName);

  Stream<String> get birthdateStream =>
      _birthdateController.stream.transform(validarBirthday);

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(nameStream, lastNameStream, (n, l) => true);

  // insertar valores al string
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeLastName => _lastNameController.sink.add;
  Function(String) get changeBirthdate => _birthdateController.sink.add;

  // obtener el ultimo valor agregado
  String get name => _nameController.value;
  String get lastName => _lastNameController.value;
  String get birthdate => _birthdateController.value;

  dispose() {
    _nameController?.close();
    _lastNameController?.close();
    _birthdateController?.close();
  }
}
