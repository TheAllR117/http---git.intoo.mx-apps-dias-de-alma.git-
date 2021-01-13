import 'package:flutter/material.dart';
import 'package:dalma/src/bloc/login_bloc.dart';
export 'package:dalma/src/bloc/login_bloc.dart';
import 'package:dalma/src/bloc/bithday_bloc.dart';
export 'package:dalma/src/bloc/bithday_bloc.dart';
import 'package:dalma/src/bloc/circulo_bloc.dart';
export 'package:dalma/src/bloc/circulo_bloc.dart';

class ProviderL extends InheritedWidget {
  static ProviderL _instancia;

  factory ProviderL({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new ProviderL._internal(key: key, child: child);
    }

    return _instancia;
  }

  final loginBloc = LoginBloc();
  final birthdayBloc = BirthdayBloc();
  final circleBloc = CircleBloc();

  ProviderL._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderL>().loginBloc;
  }

  static BirthdayBloc oof(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderL>().birthdayBloc;
  }

  static CircleBloc ooof(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderL>().circleBloc;
  }
}
