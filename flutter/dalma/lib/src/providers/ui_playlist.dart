import 'package:flutter/material.dart';

class UiPlayList extends ChangeNotifier {
  Duration _duracionVar = Duration(hours: 00, minutes: 00, seconds: 00);

  Duration get duracionVar {
    return this._duracionVar;
  }

  set duracionVar(Duration i) {
    this._duracionVar = i;
    notifyListeners();
  }
}
