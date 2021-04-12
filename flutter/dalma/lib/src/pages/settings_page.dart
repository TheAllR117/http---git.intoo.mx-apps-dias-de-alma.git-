import 'package:dalma/src/bloc/update_register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dalma/src/bloc/provider.dart';
import 'package:dalma/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:dalma/src/providers/como_gasto_localizations.dart';
import 'package:dalma/src/utils/utils.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final prefs = new PreferenciasUsuario();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    //final uiLang = Provider.of<AppLanguage>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(225, 241, 244, 1),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              localizations.t('settings.title'),
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          SwitchListTile(
              value: prefs.language,
              title: Text(localizations.t('settings.englishLanguage')),
              onChanged: (value) {
                if (mostrarAlertaV(
                    context, localizations.t('settings.message'))) {
                  setState(() {});
                }
              }),
          Divider(),
          _loginForm(context)
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = ProviderL.updateRegister(context);

    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 20.0),
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                _crearName(bloc, context),
                SizedBox(height: 15.0),
                _crearLastName(bloc, context),
                SizedBox(height: 15.0),
                _calendar(bloc, context),
                SizedBox(height: 15.0),
                _crearBoton(context, bloc)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearName(UpdateRegisterBloc bloc, BuildContext context) {
    TextEditingController _controller = TextEditingController();
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    return StreamBuilder(
      stream: bloc.nameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        _controller.value = _controller.value
            .copyWith(text: (bloc.name != null) ? bloc.name : prefs.name);
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
                controller: _controller,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(32, 147, 147, 1)),
                    ),
                    hoverColor: Color.fromRGBO(32, 147, 147, 0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: localizations.t('login.name'),
                    labelText: localizations.t('login.name'),
                    suffixIcon: Icon(
                      Icons.person_outline,
                      color: Color.fromRGBO(32, 147, 147, 0.3),
                    ),
                    //counterText: snapshot.data,
                    errorText: snapshot.error),
                onChanged: (value) => bloc.changeName(value)));
      },
    );
  }

  Widget _crearLastName(UpdateRegisterBloc bloc, BuildContext context) {
    TextEditingController _controller = TextEditingController();
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    return StreamBuilder(
      stream: bloc.lastNameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        _controller.value = _controller.value.copyWith(
            text: (bloc.lastName != null) ? bloc.lastName : prefs.lastName);
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
                controller: _controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(32, 147, 147, 1)),
                    ),
                    hoverColor: Color.fromRGBO(32, 147, 147, 0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: localizations.t('login.lastname'),
                    labelText: localizations.t('login.lastname'),
                    suffixIcon: Icon(
                      Icons.person_outline,
                      color: Color.fromRGBO(32, 147, 147, 0.3),
                    ),
                    //counterText: snapshot.data,
                    errorText: snapshot.error),
                onChanged: (value) => bloc.changeLastName(value)));
      },
    );
  }

  Widget _calendar(UpdateRegisterBloc bloc, BuildContext context) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    String fecha = 'YYYY-MM-DD';
    DateTime fechaSel;

    //final size = MediaQuery.of(context).size;
    TextEditingController _controller = TextEditingController();

    return StreamBuilder(
      stream: bloc.birthdateStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        _controller.value = _controller.value.copyWith(
            text: (bloc.birthdate != null) ? bloc.birthdate : prefs.cumpleanos);
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
                readOnly: true,
                enableInteractiveSelection: false,
                controller: _controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(32, 147, 147, 1)),
                    ),
                    hoverColor: Color.fromRGBO(32, 147, 147, 0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: localizations.t('login.birthdate'),
                    labelText: localizations.t('login.birthdate'),
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: Color.fromRGBO(32, 147, 147, 0.3),
                    ),
                    //counterText: snapshot.data,
                    errorText: snapshot.error),
                onTap: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(1900, 1, 1),
                      maxTime: DateTime.now(), onChanged: (date) {
                    final newFecha = date.toString().split(' ');
                    bloc.changeBirthdate(newFecha[0]);
                    fecha = snapshot.data;
                  }, onConfirm: (date) {
                    fecha = snapshot.data;
                    fechaSel = date;
                  },
                      currentTime:
                          (fecha != 'YYYY-MM-DD') ? fechaSel : DateTime.now(),
                      locale: (localizations.localeName == 'es')
                          ? LocaleType.es
                          : LocaleType.en,
                      theme: DatePickerTheme(
                        cancelStyle: TextStyle(color: Colors.red),
                        doneStyle: TextStyle(color: Colors.green),
                      ));
                }));
      },
    );
  }

  Widget _crearBoton(BuildContext context, UpdateRegisterBloc bloc) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    final size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.3, vertical: 15.0),
            child: Text(localizations.t('login.getIn')),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          elevation: 0.0,
          color: Colors.orange[900],
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _register(bloc, context) : null,
        );
      },
    );
  }

  _register(UpdateRegisterBloc bloc, BuildContext context) async {
    showLoadingDialog(context, _keyLoader);
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    Map info = await usuarioProvider.actualizarUsuario(
        (bloc.name != '') ? bloc.name : prefs.name,
        (bloc.lastName != '') ? bloc.lastName : prefs.lastName,
        (bloc.birthdate != '') ? bloc.birthdate : prefs.cumpleanos);

    if (info['ok']) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      mostrarAlerta(context, 'Actualización de información',
          'Datos actualizados correctamente.');
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      mostrarAlerta(context, localizations.t('utils.incorrectInformation'),
          info['mensaje']);
    }

    // Navigator.pushReplacementNamed(context, 'birthday');
  }
}
