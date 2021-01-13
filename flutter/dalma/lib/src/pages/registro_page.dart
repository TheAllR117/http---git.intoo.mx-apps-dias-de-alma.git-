import 'package:dalma/src/bloc/provider.dart';
import 'package:dalma/src/providers/como_gasto_localizations.dart';
import 'package:dalma/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:lottie/lottie.dart';
import 'package:dalma/src/providers/usuario_provider.dart';
import 'package:dalma/src/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class RegistroPage extends StatelessWidget {
  final usuarioProvider = new UsuarioProvider();

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
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
            child: _botones(context),
            height: 40.0,
            width: double.infinity,
          )),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 20.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: Column(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/svg/logoMod2.svg',
                  colorBlendMode: BlendMode.screen,
                ),
                SizedBox(height: 20.0),
                _crearEmail(bloc, context),
                SizedBox(height: 15.0),
                _crearPassword(bloc, context),
                SizedBox(height: 30.0),
                _crearBoton(context, bloc)
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
                    //counterText: snapshot.data,
                    errorText: snapshot.error),
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
              obscureText: uiProvider.showHideR,
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
                      if (uiProvider.showHideR) {
                        uiProvider.showHideR = false;
                      } else {
                        uiProvider.showHideR = true;
                      }
                    },
                  ),
                  errorText: snapshot.error),
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
          onPressed: snapshot.hasData ? () => _register(bloc, context) : null,
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
            style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
          ),
          onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
        ),
        TextButton(
            child: Text(localizations.t('login.signIn'),
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            onPressed: () {})
      ],
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

    /*final String assetName = 'assets/svg/image2vector.svg';
    final Widget svg = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Acme Logo',
      colorBlendMode: BlendMode.screen,
    );*/

    final String assetName = 'assets/svg/florV2.png';

    final Widget svg = Image.asset(
      assetName,
    );

    final String assetLogo = 'assets/svg/grupo226.svg';
    final Widget logo = SvgPicture.asset(
      assetLogo,
      semanticsLabel: 'Acme Logo',
      colorBlendMode: BlendMode.screen,
      color: Color.fromRGBO(255, 255, 255, 0.6),
    );

    final logoFinal = Container(
      width: size.width * 0.45,
      height: size.width * 0.45,
      child: logo,
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
        ),
        /*Hero(
          tag: 'logo',
          child: Container(
            padding: EdgeInsets.only(top: 100.0),
            child: Column(
              children: <Widget>[
                logoFinal,
                //Lottie.asset('assets/lottie/3583-yoga-girl-3.json', width: size.width * 0.6),
                SizedBox(width: double.infinity)
              ],
            ),
          ),
        )*/
      ],
    );
  }

  _register(LoginBloc bloc, BuildContext context) async {
    showLoadingDialog(context, _keyLoader);
    Map info = await usuarioProvider.nuevoUsuario(bloc.email, bloc.password);

    if (info['ok']) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      Navigator.pushReplacementNamed(context, 'birthday');
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      mostrarAlerta(context, info['mensaje']);
    }

    // Navigator.pushReplacementNamed(context, 'birthday');
  }
}
