import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // GET y SET del nombre
  get cookie {
    return _prefs.getString('cookie') ?? '';
  }

  set cookie(String value) {
    _prefs.setString('cookie', value);
  }

  // GET y SET de la última págin
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'loginRegister';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }

  // GET y SET cumpleaños

  get cumpleanos {
    return _prefs.getString('birthday') ?? '';
  }

  set cumpleanos(String value) {
    _prefs.setString('birthday', value);
  }

  // GET y SET days

  get day {
    return _prefs.getString('day') ?? '';
  }

  set day(String value) {
    _prefs.setString('day', value);
  }

  // GET y SET idioma

  get vividos {
    return _prefs.getString('vividos') ?? '';
  }

  set vividos(String value) {
    _prefs.setString('vividos', value);
  }

  // GET y SET idioma

  get language {
    return _prefs.getBool('language') ?? false;
  }

  set language(bool value) {
    _prefs.setBool('language', value);
  }

  // GET y SET id User

  get idUser {
    return _prefs.getString('idUser') ?? '';
  }

  set idUser(String value) {
    _prefs.setString('idUser', value);
  }

  // GET y SET nombre

  get name {
    return _prefs.getString('name') ?? '';
  }

  set name(String value) {
    _prefs.setString('name', value);
  }

  // GET y SET apellidos

  get lastName {
    return _prefs.getString('lastName') ?? '';
  }

  set lastName(String value) {
    _prefs.setString('lastName', value);
  }
}
