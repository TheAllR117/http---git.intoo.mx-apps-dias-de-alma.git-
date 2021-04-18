import 'package:dalma/src/bloc/provider.dart';
import 'package:dalma/src/providers/como_gasto_localizations.dart';
import 'package:dalma/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dalma/src/providers/usuario_provider.dart';
import 'package:dalma/src/preferencias_usuario/preferencias_usuario.dart';

class LoginRegisterPage extends StatelessWidget {
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
            padding: EdgeInsets.only(right: size.width * 0.05),
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
                SizedBox(height: 51.0),
                _crearBoton(context, bloc),
                SizedBox(height: 50.0),
                _crearBotonRe(context, bloc)
                //_botonesGoogleFacebock(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearBoton(BuildContext context, LoginBloc bloc) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    final size = MediaQuery.of(context).size;

    return RaisedButton(
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.20, vertical: 15.0),
        child: Text(localizations.t('loginRegister.login')),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 0.0,
      color: Colors.orange[900],
      textColor: Colors.white,
      onPressed: () => Navigator.pushNamed(context, 'login'),
    );
  }

  Widget _crearBotonRe(BuildContext context, LoginBloc bloc) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    final size = MediaQuery.of(context).size;

    return RaisedButton(
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.22, vertical: 15.0),
        child: Text(localizations.t('loginRegister.register')),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 0.0,
      color: Colors.orange[900],
      textColor: Colors.white,
      onPressed: () => Navigator.pushNamed(context, 'registro'),
    );
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
}
