import 'dart:async';
import 'package:dalma/src/bloc/validator.dart';
//import 'package:rxdart/rxdart.dart';

class BirthdayBloc with Validators {
  final _birthdayController = StreamController<String>.broadcast();

  // Recuperar los datos del Stream
  Stream<String> get birthdayStream =>
      _birthdayController.stream.transform(validarBirthday);

  // Stream<String> get formValidStream => Rx.combineLatest(birthdayStream);

  // insertar valores al string
  Function(String) get changeBirthday => _birthdayController.sink.add;

  // obtener el ultimo valor agregado
  //String get birthday => _birthdayController.value;

  dispose() {
    _birthdayController?.close();
  }
}
