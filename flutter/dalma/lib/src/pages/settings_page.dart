import 'package:dalma/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:dalma/src/providers/como_gasto_localizations.dart';
import 'package:flutter/material.dart';
import 'package:dalma/src/providers/ui_lang.dart';
import 'package:provider/provider.dart';
import 'package:dalma/src/utils/utils.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    final uiLang = Provider.of<AppLanguage>(context);
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
                //localizations.load();
                //prefs.language = value;
                //print(value);
              })
        ],
      ),
    );
  }
}
