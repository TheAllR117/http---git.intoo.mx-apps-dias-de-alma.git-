import 'package:dalma/src/providers/ciclo_provider.dart';
import 'package:dalma/src/providers/como_gasto_localizations.dart';
import 'package:flutter/material.dart';
import 'package:dalma/src/providers/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:dalma/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:flutter_svg/svg.dart';

class CustomNavigationBar extends StatelessWidget {
  final prefs = new PreferenciasUsuario();
  final ciclo = new CicloProvider();
  //List list = [];

  @override
  Widget build(BuildContext context) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    //_cargarMenu();
    // print((list[0]['Calcular']) ? list[0]['Calcular'] : '');
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int i) {
          if (i == 2) {
            prefs.token = '';
            prefs.ultimaPagina = 'loginRegister';
            //prefs.cumpleanos = '';
            //uiProvider.selectedMenuOpt = 1;
            Navigator.pushReplacementNamed(context, 'loginRegister');
          }
          uiProvider.selectedMenuOpt = i;
        },
        currentIndex: currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon:
                SvgPicture.asset('assets/svg/activop.svg', color: Colors.blue),
            icon: SvgPicture.asset('assets/svg/activop.svg',
                color: Colors.grey[700]),
            label: localizations.t('tab.calculate'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: localizations.t('tab.start'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: localizations.t('tab.close'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: localizations.t('tab.settings'),
          ),
        ]);
  }
}
