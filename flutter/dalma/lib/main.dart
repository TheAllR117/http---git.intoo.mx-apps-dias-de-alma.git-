import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:dalma/src/bloc/provider.dart';
import 'package:dalma/src/pages/actividades_page.dart';
import 'package:dalma/src/pages/birthday_page.dart';
import 'package:dalma/src/pages/producto_page.dart';
import 'package:dalma/src/pages/home_page.dart';
import 'package:dalma/src/pages/home_v2_page.dart';
import 'package:dalma/src/pages/login_page.dart';
import 'package:dalma/src/pages/registro_page.dart';
import 'package:dalma/src/preferencias_usuario/preferencias_usuario.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:dalma/src/providers/ui_provider.dart';
import 'package:dalma/src/providers/ui_lang.dart';
import 'package:dalma/src/providers/como_gasto_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: (Platform.isAndroid) ? Colors.transparent : Colors.blue));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    // Firebase.initializeApp();
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _prefs = new PreferenciasUsuario();
    return ProviderL(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => new UiProvider()),
          ChangeNotifierProvider(create: (_) => new AppLanguage()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Días del Alma',
          initialRoute: _prefs.ultimaPagina,
          routes: {
            'login': (BuildContext context) => LoginPage(),
            'birthday': (BuildContext context) => BirthdayPage(),
            'actividades': (BuildContext context) => ActividadPage(),
            'producto': (BuildContext context) => ProductoPage(),
            'home': (BuildContext context) => HomePage(),
            'home_2': (BuildContext context) => HomeTwoPage(),
            'registro': (BuildContext context) => RegistroPage(),
          },
          supportedLocales: [Locale('en'), Locale('es')],
          localizationsDelegates: [
            ComoGastoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          theme: ThemeData(
              //primaryColor: Color.fromRGBO(24, 80, 93, 1),
              // bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Color.fromRGBO(24, 80, 93, 1))
              ),
        ),
      ),
    );
  }
}
