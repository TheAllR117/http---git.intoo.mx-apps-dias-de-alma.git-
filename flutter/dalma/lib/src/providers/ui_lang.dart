import 'package:flutter/material.dart';

class AppLanguage extends ChangeNotifier {
  bool _selectedLang = false;

  bool get selectedLang {
    return this._selectedLang;
  }

  set selectedLang(bool i) {
    this._selectedLang = i;
    notifyListeners();
  }
}
