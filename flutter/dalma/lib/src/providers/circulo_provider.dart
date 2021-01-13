import 'dart:convert';
import 'package:dalma/src/models/cicloV_model.dart';
//import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'dart:async';

class CicloVTwoProvider {
  final String _urlEs = 'https://app.diasdelalma.com/es/node';
  final String _urlEn = 'https://app.diasdelalma.com/node';

  Future<List<Ciclo>> cargarAudios(String dia, String idioma) async {
    String url = '';
    if (idioma == 'es') {
      url = '$_urlEs/$dia?_format=json#';
    } else {
      url = '$_urlEn/$dia?_format=json#';
    }
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<Ciclo> productos = new List();

    if (decodeData == null) return [];

    //decodeData.forEach((id, prod) {
    final prodTemp = Ciclo.fromJson(decodeData);
    productos.add(prodTemp);
    //});

    //print('siiiii ${prodTemp.fieldArticleAudio[0].url}');

    return productos;
  }
}
