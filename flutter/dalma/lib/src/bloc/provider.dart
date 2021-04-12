import 'package:dalma/src/bloc/update_register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dalma/src/bloc/login_bloc.dart';
export 'package:dalma/src/bloc/login_bloc.dart';
import 'package:dalma/src/bloc/bithday_bloc.dart';
export 'package:dalma/src/bloc/bithday_bloc.dart';
import 'package:dalma/src/bloc/circulo_bloc.dart';
export 'package:dalma/src/bloc/circulo_bloc.dart';
import 'package:dalma/src/bloc/reset_password_bloc.dart';
export 'package:dalma/src/bloc/reset_password_bloc.dart';
import 'package:dalma/src/bloc/register_bloc.dart';
export 'package:dalma/src/bloc/register_bloc.dart';

class ProviderL extends InheritedWidget {
  static ProviderL _instancia;

  factory ProviderL({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new ProviderL._internal(key: key, child: child);
    }

    return _instancia;
  }

  final loginBloc = LoginBloc();
  final registerBloc = RegisteBloc();
  final birthdayBloc = BirthdayBloc();
  final circleBloc = CircleBloc();
  final resetPasswordBloc = ResetPasswordBloc();
  final updateRegisterBloc = UpdateRegisterBloc();

  ProviderL._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderL>().loginBloc;
  }

  static RegisteBloc register(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderL>().registerBloc;
  }

  static BirthdayBloc oof(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderL>().birthdayBloc;
  }

  static CircleBloc ooof(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderL>().circleBloc;
  }

  static ResetPasswordBloc resetPassword(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProviderL>()
        .resetPasswordBloc;
  }

  static UpdateRegisterBloc updateRegister(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProviderL>()
        .updateRegisterBloc;
  }
}
