import 'dart:async';
import 'package:dalma/src/bloc/validator.dart';
//import 'package:rxdart/rxdart.dart';

class CircleBloc with Validators {
  final _circleController = StreamController<String>.broadcast();

  // Recuperar los datos del Stream
  Stream<String> get circleStream =>
      _circleController.stream.transform(validarCircle);

  // Stream<String> get formValidStream => Rx.combineLatest(birthdayStream);

  // insertar valores al string
  Function(String) get changeCircle => _circleController.sink.add;

  // obtener el ultimo valor agregado
  //String get birthday => _birthdayController.value;

  dispose() {
    _circleController?.close();
  }
}
