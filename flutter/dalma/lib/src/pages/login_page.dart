import 'package:dalma/src/bloc/provider.dart';
import 'package:dalma/src/providers/como_gasto_localizations.dart';
import 'package:dalma/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dalma/src/providers/usuario_provider.dart';
import 'package:dalma/src/providers/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:dalma/src/preferencias_usuario/preferencias_usuario.dart';

class LoginPage extends StatelessWidget {
  final usuarioProvider = new UsuarioProvider();
  final prefs = new PreferenciasUsuario();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    prefs.cumpleanos = '';
    return Scaffold(
        body: Stack(
      children: <Widget>[_crearFondo(context), _loginForm(context)],
    ));
  }

  Widget _loginForm(BuildContext context) {
    final bloc = ProviderL.of(context);

    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(
                right: size.width * 0.05, left: size.width * 0.05),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: Color.fromRGBO(32, 147, 147, 1.0)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            ),
            height: 40.0,
            width: double.infinity,
          )),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 20.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: Column(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SvgPicture.asset(
                    'assets/svg/logoMod2.svg',
                    colorBlendMode: BlendMode.screen,
                  ),
                ),
                SizedBox(height: 20.0),
                _crearEmail(bloc, context),
                SizedBox(height: 15.0),
                _crearPassword(bloc, context),
                _crearBotonRecuperarPassword(context),
                SizedBox(height: 30.0),
                _crearBoton(context, bloc),
                SizedBox(height: 20.0),
                //_botonesGoogleFacebock(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc, BuildContext context) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);

    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
                //textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
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
                    hintText: 'Email',
                    labelText: localizations.t('login.email'),
                    suffixIcon: Icon(
                      Icons.email,
                      color: Color.fromRGBO(32, 147, 147, 0.3),
                    ),
                    errorText: snapshot.error,
                    errorStyle: TextStyle(fontSize: 11.0)),
                onChanged: (value) => bloc.changeEmail(value)));
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc, BuildContext context) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    final uiProvider = Provider.of<UiProvider>(context);
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: uiProvider.showHide,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(32, 147, 147, 1)),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  hintText: localizations.t('login.password'),
                  labelText: localizations.t('login.password'),
                  suffixIcon: IconButton(
                    icon: uiProvider.showHide
                        ? Icon(Icons.remove_red_eye_outlined)
                        : Icon(Icons.lock_outline),
                    color: Color.fromRGBO(32, 147, 147, 0.3),
                    onPressed: () {
                      if (uiProvider.showHide) {
                        uiProvider.showHide = false;
                      } else {
                        uiProvider.showHide = true;
                      }
                    },
                  ),
                  errorText: snapshot.error,
                  errorStyle: TextStyle(fontSize: 11.0)),
              onChanged: (value) => bloc.changePassword(value),
            ));
      },
    );
  }

  Widget _crearBoton(BuildContext context, LoginBloc bloc) {
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
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
        );
      },
    );
  }

  Widget _botones(BuildContext context) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        TextButton(
          child: Text(
            localizations.t('login.logIn'),
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () {},
        ),
        TextButton(
            child: Text(localizations.t('login.signIn'),
                style: TextStyle(fontSize: 18.0, color: Colors.grey[600])),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, 'registro'))
      ],
    );
  }

  /*Widget _botonesGoogleFacebock(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'O INICIA SESIÓN USANDO',
              style: TextStyle(color: Colors.blue[400]),
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.0),
                height: 70.0,
                width: 100.0,
                padding: EdgeInsets.only(left: 20.0, right: 10.0),
                child: RaisedButton(
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.blue[700],
                    ),
                    onPressed: () {},
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  elevation: 1.0,
                  color: Colors.grey[50],
                  onPressed: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                height: 70.0,
                width: 100.0,
                padding: EdgeInsets.only(left: 10.0, right: 20.0),
                child: RaisedButton(
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.google, color: Colors.red),
                    onPressed: () async {
                      /*if (await GoogleSignInService.signInWithGoogle() !=
                          null) {
                        Navigator.pushReplacementNamed(context, 'birthday');
                      } else {
                        mostrarAlerta(context, 'Error al iniciar sesion.');
                      }*/
                    },
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  elevation: 1.0,
                  color: Colors.grey[50],
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }*/

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

    final String assetName = 'assets/svg/florV2.png';

    final Widget svg = Image.asset(
      assetName,
    );

    final flores = Container(
      width: size.width * 1.4,
      height: size.width * 1.4,
      child: svg,
    );

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        fondoBlanco,
        Positioned(
          child: flores,
          top: size.height * 0.68,
        ),
        Positioned(
          child: flores,
          top: -430.0,
          left: -310.0,
        )
      ],
    );
  }

  Widget _crearBotonRecuperarPassword(BuildContext context) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              password(context, 'Holo');
            },
            child: Text(
              localizations.t('login.didyouforgetyourpassword'),
              style: TextStyle(color: Color.fromRGBO(32, 147, 147, 0.3)),
            ),
          ),
        ],
      ),
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {
    showLoadingDialog(context, _keyLoader);

    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);

    Map info = await usuarioProvider.login(bloc.email, bloc.password);
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'birthday');
    } else {
      mostrarAlerta(context, localizations.t('utils.incorrectInformation'),
          info['mensaje']);
    }
  }
}
