import 'dart:convert';

import 'package:dalma/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  //final String _firebaseToken = 'AIzaSyDdNWwnj0sTpn4SN_RKrg_5DLMGiRZ3aEE';
  final _prefs = new PreferenciasUsuario();

  /*get onGoogleCurrentUserChanged => _googleSignIn.onCurrentUserChanged;

  Future<void> signInWithGoogle() async {
    await _googleSignIn.signIn();
  }

  Future<void> signInFirebase(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOutFirebase() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
  }*/

  /*login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
        body: json.encode(authData));

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      _prefs.token = decodeResp['idToken'];
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodeResp['error']['message']};
    }
  }*/

  login(String email, String password) async {
    final resp = await http.post(
      'https://app.diasdelalma.com/user/login?_format=json',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'name': email, 'pass': password}),
    );
    //print('siiiii  ${resp.headers['set-cookie']}');

    Map<String, dynamic> decodeResp = json.decode(resp.body);
    if (decodeResp.containsKey('csrf_token')) {
      _prefs.cookie = resp.headers['set-cookie'];
      _prefs.idUser = decodeResp['current_user']['uid'];
      //print(decodeResp['current_user']['uid']);
      _prefs.token = decodeResp['csrf_token'];
      return {'ok': true, 'token': decodeResp['csrf_token']};
    } else {
      return {'ok': false, 'mensaje': decodeResp['message']};
    }
  }

  reset(String email) async {
    final resp = await http.post(
      'https://app.diasdelalma.com/user/password?_format=hal_json',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'mail': email}),
    );
    return true;
  }

  nuevoUsuario(String email, String password, String nombre, String apellidos,
      String cumpleanos) async {
    final token = await http.get('https://app.diasdelalma.com/session/token');
    // print(token.body);

    final resp = await http.post(
      'https://app.diasdelalma.com/user/register?_format=hal_json',
      headers: <String, String>{
        'Content-Type': 'application/hal+json; charset=UTF-8',
        'X-CSRF-Token': token.body
      },
      body: jsonEncode(<String, dynamic>{
        "_links": {
          "type": {"href": "https://app.diasdelalma.com/rest/type/user/user"}
        },
        "name": [
          {"value": email}
        ],
        "mail": [
          {"value": email}
        ],
        "pass": [
          {"value": password}
        ],
        "field_user_nombre": [
          {"value": nombre}
        ],
        "field_user_apellidos": [
          {"value": apellidos}
        ],
        "field_user_nacimiento": [
          {"value": cumpleanos}
        ],
        "preferred_langcode": [
          {"value": "es"}
        ]
      }),
    );

    // print(resp.body);
    Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (decodeResp.isNotEmpty) {
      if (decodeResp['name'][0]['value'] != null &&
          decodeResp['name'][0]['value'] == email) {
        _prefs.idUser = decodeResp['current_user'][0]['uid'];
        _prefs.name = nombre;
        _prefs.lastName = apellidos;
        return login(decodeResp['name'][0]['value'], password);
      } else {
        return {'ok': false, 'mensaje': decodeResp['message']};
      }
    } else {
      return {'ok': false, 'mensaje': decodeResp['message']};
    }
  }

  actualizarUsuario(String nombre, String apellidos, String cumpleanos) async {
    final resp = await http.patch(
      'https://app.diasdelalma.com/user/${_prefs.idUser}?_format=hal_json',
      headers: <String, String>{
        'Cookie': _prefs.cookie,
        'Content-Type': 'application/hal+json; charset=UTF-8',
        'X-CSRF-Token': _prefs.token
      },
      body: jsonEncode(<String, dynamic>{
        "_links": {
          "type": {"href": "https://app.diasdelalma.com/rest/type/user/user"}
        },
        "field_user_nombre": [
          {"value": nombre}
        ],
        "field_user_apellidos": [
          {"value": apellidos}
        ],
        "field_user_nacimiento": [
          {"value": cumpleanos}
        ],
      }),
    );

    //print(resp.body);
    Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (decodeResp.isNotEmpty) {
      if (decodeResp['name'][0]['value'] != null) {
        //_prefs.idUser = decodeResp['current_user'][0]['uid'];
        _prefs.name = nombre;
        _prefs.lastName = apellidos;
        return {'ok': true};
      } else {
        return {'ok': false, 'mensaje': decodeResp['message']};
      }
    } else {
      return {'ok': false, 'mensaje': decodeResp['message']};
    }
  }

  /*Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
        body: json.encode(authData));

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      _prefs.token = decodeResp['idToken'];
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodeResp['error']['message']};
    }
  }*/
}
