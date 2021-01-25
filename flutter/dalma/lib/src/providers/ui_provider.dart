import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 1;

  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  set selectedMenuOpt(int i) {
    this._selectedMenuOpt = i;
    notifyListeners();
  }

  // mostrar/ocular contraseña login
  bool _showHide = true;

  bool get showHide {
    return this._showHide;
  }

  set showHide(bool i) {
    this._showHide = i;
    notifyListeners();
  }

  // mostrar/ocular contraseña registro
  bool _showHideR = true;

  bool get showHideR {
    return this._showHideR;
  }

  set showHideR(bool i) {
    this._showHideR = i;
    notifyListeners();
  }

  // mostrar reproductor

  bool _showHidenReproductor = false;

  bool get showHidenReproductor {
    return this._showHidenReproductor;
  }

  set showHidenReproductor(bool i) {
    this._showHidenReproductor = i;
    notifyListeners();
  }
}
