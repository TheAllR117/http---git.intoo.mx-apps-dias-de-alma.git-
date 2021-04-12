import 'package:dalma/src/bloc/provider.dart';
import 'package:dalma/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:dalma/src/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:dalma/src/providers/como_gasto_localizations.dart';

final usuarioProvider = new UsuarioProvider();

bool isNumeric(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s);
  return (n == null) ? false : true;
}

void mostrarAlerta(BuildContext context, String titulo, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
          ],
        );
      });
}

void password(BuildContext context, String mensaje) {
  final bloc = ProviderL.resetPassword(context);
  ComoGastoLocalizations localizations =
      Localizations.of<ComoGastoLocalizations>(context, ComoGastoLocalizations);
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localizations.t('utils.passwordTitle')),
          content: StreamBuilder<Object>(
              stream: bloc.emailStream,
              builder: (context, snapshot) {
                return TextField(
                    //textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(32, 147, 147, 1)),
                        ),
                        hoverColor: Color.fromRGBO(32, 147, 147, 0.3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintText: 'Email',
                        labelText: localizations.t('login.email'),
                        suffixIcon: Icon(
                          Icons.email,
                          color: Color.fromRGBO(32, 147, 147, 0.3),
                        ),
                        //errorText: snapshot.error,
                        errorStyle: TextStyle(fontSize: 11.0)),
                    onChanged: (value) => bloc.changeEmail(value));
              }),
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  bool info = await usuarioProvider.reset(bloc.email);
                  if (info) {
                    Navigator.of(context).pop();
                    mostrarAlerta(context, localizations.t('utils.titleReset'),
                        localizations.t('utils.messageReset'));
                  }
                },
                child: Text(localizations.t('utils.send')))
          ],
        );
      });
}

bool mostrarAlertaV(BuildContext context, String mensaje) {
  final prefs = new PreferenciasUsuario();
  bool ban = false;
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Aviso'),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  prefs.language = (prefs.language == false) ? true : false;
                  ban = prefs.language;
                  Navigator.of(context).pop();
                },
                child: Text('Ok'))
          ],
        );
      });
  return ban;
}

int calcularCiclos(String fecha) {
  final _prefs = new PreferenciasUsuario();
  //Fecha de cumpleaños
  DateTime birthdate = DateTime.parse(fecha);
  DateTime now = new DateTime.now();
  //Numero de dias entre dos fechas
  Duration diff = now.difference(birthdate);
  _prefs.vividos = diff.inDays.toString();
  int days = (diff.inDays + 1) % 28;
  int cycles = ((diff.inDays + 1) ~/ 28).toInt();
  //print(fecha);
  //print("Número de ciclos: $cycles");
  if (days == 0) {
    //print("Día 28 de 28");
    _prefs.day = '28';
  } else {
    //print("Día $days de 28");
    cycles++;
    _prefs.day = days.toString();
  }

  return cycles;
}

Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
  ComoGastoLocalizations localizations =
      Localizations.of<ComoGastoLocalizations>(context, ComoGastoLocalizations);
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
                key: key,
                backgroundColor: Colors.white,
                children: <Widget>[
                  Center(
                    child: Column(children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${localizations.t('utils.pleaseWait')}...',
                        style: TextStyle(color: Colors.teal),
                      )
                    ]),
                  )
                ]));
      });
}
