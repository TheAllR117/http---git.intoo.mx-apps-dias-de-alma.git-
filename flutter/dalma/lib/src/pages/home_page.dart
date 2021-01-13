import 'package:dalma/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:dalma/src/widgets/custom_navigatorbar.dart';
import 'package:dalma/src/pages/inicio_page.dart';
import 'package:dalma/src/pages/birthdayV2_page.dart';
import 'package:dalma/src/providers/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:dalma/src/pages/settings_page.dart';

class HomePage extends StatelessWidget {
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_HomePageBody() != null) ? _HomePageBody() : InicioPage(),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    switch (currentIndex) {
      case 0:
        return BirthdayV2Page();
      case 1:
        return InicioPage();
      case 2:
        //uiProvider.selectedMenuOpt = 1;
        return SettingsPage();
      case 3:
        return SettingsPage();
      default:
        uiProvider.selectedMenuOpt = 1;
        return InicioPage();
    }
  }
}
