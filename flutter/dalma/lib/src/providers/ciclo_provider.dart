import 'dart:convert';
import 'package:dalma/src/models/ciclos_model.dart';

//import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'dart:async';

class CicloProvider {
  final String _urlEs = 'https://app.diasdelalma.com/es/node';
  final String _urlEn = 'https://app.diasdelalma.com/node';
  List<dynamic> opciones = [];

  Future<List<Title>> cargarTitulo(String dia, String idioma) async {
    String url = '';
    if (idioma == 'es') {
      url = '$_urlEs/$dia?_format=json#';
    } else {
      url = '$_urlEn/$dia?_format=json#';
    }
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<Title> productos = [];

    if (decodeData == null) return [];

    decodeData.forEach((id, prod) {
      if (id == 'title') {
        final prodTemp = Title.fromJson(prod[0]);
        productos.add(prodTemp);
      }
    });

    return productos;
  }

  Future<List<Title>> cargarSubTitulo(String dia, String idioma) async {
    String url = '';
    if (idioma == 'es') {
      url = '$_urlEs/$dia?_format=json#';
    } else {
      url = '$_urlEn/$dia?_format=json#';
    }
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<Title> productos = [];

    if (decodeData == null) return [];

    decodeData.forEach((id, prod) {
      if (id == 'field_article_subtitulo') {
        final prodTemp = Title.fromJson(prod[0]);
        productos.add(prodTemp);
      }
    });

    return productos;
  }

  Future<List<Body>> cargarDia(String dia, String idioma) async {
    String url = '';
    if (idioma == 'es') {
      url = '$_urlEs/$dia?_format=json#';
    } else {
      url = '$_urlEn/$dia?_format=json#';
    }
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<Body> productos = [];

    if (decodeData == null) return [];
    decodeData.forEach((id, prod) {
      if (id == 'body') {
        final prodTemp = Body.fromJson(prod[0]);
        //print(prodTemp.value);
        productos.add(prodTemp);
        //print(productos[0].value);
        /*final prodTemp = Body.fromJson(prod);
          prodTemp.value = prod;*/

        //productos.add(prodTemp);

      }
    });

    // print(productos[0]);

    return productos;
  }

  Future<List<FieldImage>> cargarImage(String dia, String idioma) async {
    String url = '';
    if (idioma == 'es') {
      url = '$_urlEs/$dia?_format=json#';
    } else {
      url = '$_urlEn/$dia?_format=json#';
    }
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<FieldImage> images = [];

    decodeData.forEach((id, prod) {
      if (id == 'field_image') {
        final prodTemp = FieldImage.fromJson(prod[0]);
        images.add(prodTemp);
        // print(images[0].url);
      }
    });

    return images;
  }

  Future<List<FieldArticleTextoPremium>> cargarTextoCiclo(
      String dia, String idioma) async {
    String url = '';
    if (idioma == 'es') {
      url = '$_urlEs/$dia?_format=json#';
    } else {
      url = '$_urlEn/$dia?_format=json#';
    }
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<FieldArticleTextoPremium> texto = [];

    decodeData.forEach((id, prod) {
      if (id == 'field_article_texto_premium') {
        final prodTemp = FieldArticleTextoPremium.fromJson(prod[0]);
        texto.add(prodTemp);
        // print(images[0].url);
      }
    });

    return texto;
  }

  Future<List<Body>> cargarParrafoCiclo(String dia, String idioma) async {
    String url = '';
    if (idioma == 'es') {
      url = '$_urlEs/$dia?_format=json#';
    } else {
      url = '$_urlEn/$dia?_format=json#';
    }
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<Body> texto = [];

    decodeData.forEach((id, prod) {
      if (id == 'body') {
        if (prod[0] != null) {
          final prodTemp = Body.fromJson(prod[0]);
          texto.add(prodTemp);
        } else {
          return [];
        }

        // print(images[0].url);
      }
    });

    return texto;
  }

  Future<List<FieldArticleAudio>> numeroAudios(
      String dia, String idioma) async {
    String url = '';
    if (idioma == 'es') {
      url = '$_urlEs/$dia?_format=json#';
    } else {
      url = '$_urlEn/$dia?_format=json#';
    }
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<FieldArticleAudio> texto = [];
    //print(decodeData);
    decodeData.forEach((id, prod) {
      if (id == 'field_article_audio') {
        //final prodTemp = FieldArticleAudio.fromJson(prod);

        texto.add(prod);
        print('simf $texto');
      }
    });

    return texto;
  }

  descargarPDF() async {
    final url =
        'https://app.diasdelalma.com/calendario/app/?year=2020&birthdate=1994-05-15';
    final resp = await http.get(url);

    return resp.isRedirect;
  }

  /*Future<Map<String, dynamic>> cargarDia(String dia) async {
    final url = '$_urlEs/$dia?_format=json#';
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);

    if (decodeData == null) return null;

    return decodeData;
  }*/

  /*Future<Map<String, dynamic>> cargarDia(String dia) async {
    final url = '$_urlEs/$dia?_format=json#';
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);

    if (decodeData == null) return null;

    return decodeData;
  }*/
}
