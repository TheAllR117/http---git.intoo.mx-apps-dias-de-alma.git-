import 'dart:async';
import 'package:dalma/src/bloc/validator.dart';
//import 'package:rxdart/rxdart.dart';

class CircleBloc with Validators {
  final _circleController = StreamController<String>.broadcast();
  final _playController = StreamController<Duration>.broadcast();

  // Recuperar los datos del Stream
  Stream<String> get circleStream =>
      _circleController.stream.transform(validarCircle);

  Stream<Duration> get playStream => _playController.stream.transform(validarPlay);

  // Stream<String> get formValidStream => Rx.combineLatest(birthdayStream);

  // insertar valores al string
  Function(String) get changeCircle => _circleController.sink.add;
  Function(Duration) get changePlay => _playController.sink.add;

  // obtener el ultimo valor agregado
  //String get birthday => _birthdayController.value;

  dispose() {
    _circleController?.close();
    _playController?.close();
  }
}
