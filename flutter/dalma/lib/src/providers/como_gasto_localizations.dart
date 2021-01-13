import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';
import 'package:dalma/src/preferencias_usuario/preferencias_usuario.dart';

class ComoGastoLocalizations {
  final prefs = new PreferenciasUsuario();

  String localeName;

  ComoGastoLocalizations(this.localeName);

  static const LocalizationsDelegate<ComoGastoLocalizations> delegate =
      _ComoGastoLocalizationsDelegate();

  YamlMap translations;

  Future load() async {
    String yamlString = '';
    if (prefs.language) {
      yamlString = await rootBundle.loadString('lang/en.yml');
    } else {
      yamlString = await rootBundle.loadString('lang/$localeName.yml');
    }
    translations = loadYaml(yamlString);
  }

  String t(String key) {
    try {
      var keys = key.split(".");
      dynamic translated = translations;
      keys.forEach((k) => translated = translated[k]);
      if (translated == null) {
        return "key no found $key";
      }
      return translated;
    } catch (e) {
      return "key no found $key";
    }
  }

  /*String get cicloActual {
    return translations['start']['currentCycle'];
  }*/
}

class _ComoGastoLocalizationsDelegate
    extends LocalizationsDelegate<ComoGastoLocalizations> {
  const _ComoGastoLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['es', 'en'].contains(locale.languageCode);
  }

  @override
  Future<ComoGastoLocalizations> load(Locale locale) async {
    // TODO: implement load
    var t = ComoGastoLocalizations(locale.languageCode);
    await t.load();
    return t;
  }

  @override
  bool shouldReload(LocalizationsDelegate<ComoGastoLocalizations> old) {
    // TODO: implement shouldReload
    return false;
  }
}
