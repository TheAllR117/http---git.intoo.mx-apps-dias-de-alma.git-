import 'package:dalma/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:dalma/src/providers/como_gasto_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:dalma/src/bloc/provider.dart';
import 'package:dalma/src/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class BirthdayPage extends StatelessWidget {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(225, 241, 244, 1),
        body: Stack(
          children: <Widget>[
            _crearFondo(context),
            _calendar(context),
            _crearBoton(context)
          ],
        ));
  }

  Widget _crearFondo(BuildContext context) {
    final fondoBlanco = Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
          Color.fromRGBO(255, 255, 255, 1.0),
          Color.fromRGBO(250, 250, 250, 1.0)
        ])));

    final size = MediaQuery.of(context).size;

    final Widget logo = Lottie.asset('assets/lottie/circulo_animado.json',
        width: size.width * 0.6);

    /*final Widget logo = SvgPicture.asset(
      'assets/svg/grupo227.svg',
      semanticsLabel: 'Acme Logo',
      colorBlendMode: BlendMode.dstOut,
      color: Color.fromRGBO(0, 0, 0, 0.0),
    );*/

    final logoFinal = Container(
      width: size.width * 0.9,
      height: size.width * 0.9,
      child: logo,
    );

    return Stack(
      children: <Widget>[
        fondoBlanco,
        Hero(
          tag: 'logo',
          child: Container(
            padding: EdgeInsets.only(top: size.height * 0.1),
            child: Column(
              children: <Widget>[
                logoFinal,
                // Lottie.asset('assets/lottie/3583-yoga-girl-3.json', width: size.width * 0.6),
                SizedBox(width: double.infinity)
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _calendar(BuildContext context) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    String fecha = 'YYYY-MM-DD';
    DateTime fechaSel;

    final bloc = ProviderL.oof(context);
    final size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: bloc.birthdayStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            margin: EdgeInsets.only(top: size.height * 0.28),
            alignment: Alignment.center,
            child: FlatButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1900, 1, 1),
                    maxTime: DateTime.now(), onChanged: (date) {
                  final newFecha = date.toString().split(' ');
                  bloc.changeBirthday(newFecha[0]);
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
              },
              child: Container(
                height: size.height * 0.075,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      localizations.t('birthday.birthdate'),
                      style: TextStyle(color: Colors.blue, fontSize: 16.0),
                    ),
                    Text((snapshot.data != null) ? snapshot.data : fecha,
                        style: TextStyle(fontSize: 14.0)),
                  ],
                ),
              ),
            ));
      },
    );
  }

  Widget _crearBoton(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    final bloc = ProviderL.oof(context);
    final size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: bloc.birthdayStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          margin: EdgeInsets.only(top: size.height * 0.45),
          alignment: Alignment.center,
          child: RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.30, vertical: 15.0),
              child: Text(localizations.t('birthday.calculate')),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            elevation: 0.0,
            color: Colors.orange[900],
            textColor: Colors.white,
            onPressed: snapshot.hasData
                ? () => {
                      _home(context, snapshot.data),
                      uiProvider.selectedMenuOpt = 1
                    }
                : null,
          ),
        );
      },
    );
  }

  _home(BuildContext context, String birthday) {
    final _prefs = new PreferenciasUsuario();

    _prefs.cumpleanos = birthday;

    Navigator.pushReplacementNamed(context, 'home');
  }
}
