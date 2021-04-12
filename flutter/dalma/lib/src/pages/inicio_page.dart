import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dalma/src/bloc/provider.dart';
import 'package:dalma/src/models/ciclos_model.dart';
import 'package:dalma/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:dalma/src/providers/ciclo_provider.dart';
import 'package:dalma/src/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:circle_list/circle_list.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:lottie/lottie.dart';
import 'dart:math';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:dalma/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dalma/src/providers/como_gasto_localizations.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
/*import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:giffy_dialog/src/asset.dart';*/
//import 'package:path_provider/path_provider.dart';

class InicioPage extends StatefulWidget {
  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  CarouselController buttonCarouselController = CarouselController();
  final prefs = new PreferenciasUsuario();

  final ciclo = new CicloProvider();

  List arregloImage = [];
  List arregloBotonMas = [];
  List arregloBotonMasV = [];
  List colorBarra = [];

  @override
  Widget build(BuildContext context) {
    colorBarra.add(Colors.teal);

    arregloImage.add(
        'https://llandscapes-10674.kxcdn.com/wp-content/uploads/2019/07/lighting.jpg');

    calcularCiclos(prefs.cumpleanos);

    prefs.ultimaPagina = 'home';
    return Scaffold(
      backgroundColor: Color.fromRGBO(225, 241, 244, 1),
      body: Stack(children: <Widget>[
        Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: <Widget>[
                _circulo(context),
                _calendar(context),
                _tarjetaCicloCalendario(context),
                for (Widget item in _ciclofor(context)) item,
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _circulo(BuildContext context) {
    final bloc = ProviderL.ooof(context);
    final List<double> opciones = [
      3.50,
      2.80,
      2.34,
      2.00,
      1.75,
      1.55,
      1.40,
      1.27,
      1.16,
      1.075,
      1.0,
      0.932,
      0.874,
      0.823,
      0.777,
      0.737,
      0.700,
      0.666,
      0.636,
      0.609,
      0.583,
      0.560,
      0.5382,
      0.5185,
      0.5000,
      0.48255,
      0.4665,
      0.4515
    ];

    final List<Color> colores = [
      Color.fromRGBO(236, 25, 39, 1.0),
      Color.fromRGBO(236, 25, 39, 1.0),
      Color.fromRGBO(236, 25, 39, 1.0),
      Color.fromRGBO(236, 25, 39, 1.0),
      Color.fromRGBO(236, 25, 39, 1.0),
      Color.fromRGBO(236, 25, 39, 1.0),
      Color.fromRGBO(236, 25, 39, 1.0),
      Color.fromRGBO(255, 112, 30, 1.0),
      Color.fromRGBO(255, 112, 30, 1.0),
      Color.fromRGBO(255, 112, 30, 1.0),
      Color.fromRGBO(255, 112, 30, 1.0),
      Color.fromRGBO(255, 112, 30, 1.0),
      Color.fromRGBO(255, 112, 30, 1.0),
      Color.fromRGBO(232, 197, 13, 1.0),
      Color.fromRGBO(232, 197, 13, 1.0),
      Color.fromRGBO(232, 197, 13, 1.0),
      Color.fromRGBO(232, 197, 13, 1.0),
      Color.fromRGBO(232, 197, 13, 1.0),
      Color.fromRGBO(52, 182, 22, 1.0),
      Color.fromRGBO(52, 182, 22, 1.0),
      Color.fromRGBO(52, 182, 22, 1.0),
      Color.fromRGBO(52, 182, 22, 1.0),
      Color.fromRGBO(22, 227, 203, 1.0),
      Color.fromRGBO(22, 227, 203, 1.0),
      Color.fromRGBO(22, 227, 203, 1.0),
      Color.fromRGBO(19, 148, 229, 1.0),
      Color.fromRGBO(19, 148, 229, 1.0),
      Color.fromRGBO(224, 33, 151, 1.0),
    ];
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: size.height * 0.033),
      padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
      height: size.width * 1.05,
      decoration: BoxDecoration(
        //color: Colors.black,
        image: DecorationImage(
          image: AssetImage("assets/svg/fondo.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<Object>(
                stream: bloc.circleStream,
                builder: (context, snapshot) {
                  return Container(
                    padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                    width: size.width * 0.5,
                    alignment: Alignment.centerLeft,
                    child: CircleList(
                      isChildrenVertical: true,
                      rotateMode: RotateMode.onlyChildrenRotate,
                      centerWidget: Container(
                        decoration: BoxDecoration(
                          //color: Colors.amber,
                          image: DecorationImage(
                            image: AssetImage("assets/svg/flordelavida@2x.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: EdgeInsets.only(top: size.height * 0.0),
                        child: SizedBox(
                          width: size.width * 1.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              //Lottie.asset('assets/lottie/3583-yoga-girl-3.json', width: size.width * 0.35),
                              _crearimagen(context),
                              SizedBox(width: double.infinity),
                              _crearTextoCicloActual(),
                              SizedBox(width: double.infinity),
                              _crearTextoDiaActual(),
                              SizedBox(width: double.infinity),
                              _crearSlider()
                            ],
                          ),
                        ),
                      ),
                      showInitialAnimation: true,
                      origin: Offset(-size.width * 0.5, 0),
                      initialAngle: -pi /
                          opciones[snapshot.hasData
                              ? int.parse(snapshot.data)
                              : int.parse(prefs.day) - 1],
                      innerRadius: size.width * 0.4,
                      //outerRadius: size.height * 0.1,
                      dragAngleRange: DragAngleRange(-pi / 3.5, 0.0),
                      innerCircleColor: Colors.white,
                      children: List.generate(28, (index) {
                        return Container(
                          alignment: Alignment.center,
                          height: size.width * 0.06,
                          width: size.width * 0.06,
                          decoration: BoxDecoration(
                            color: colores[index],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                }),
            Container(
              //alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: size.width * 0.150),
              //padding: EdgeInsets.all(0.0),
              //decoration: BoxDecoration(color: Colors.blue),
              width: size.width * 0.5,
              height: double.infinity,
              child: _carousel(context),
              //_flechas()
            )
          ]),
    );
  }

  Widget _carousel(BuildContext context) {
    final bloc = ProviderL.ooof(context);
    //final size = MediaQuery.of(context).size;

    return CarouselSlider(
      items: <Widget>[for (Widget item in _carouselItem(context)) item],
      carouselController: buttonCarouselController,
      options: CarouselOptions(
          height: double.infinity,
          autoPlay: false,
          //enlargeCenterPage: true,
          viewportFraction: 1.0,
          //aspectRatio: 2.0,
          initialPage: int.parse(prefs.day) - 1,
          onPageChanged: (value, _) {
            bloc.changeCircle(value.toString());
          }),
    );
  }

  _carouselItem(BuildContext context) {
    //final size = MediaQuery.of(context).size;

    List<Widget> items = [];
    for (int i = 0; i < 28; i++) {
      items.add(Container(
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.only(left: 9.0),
        width: double.infinity,
        height: double.infinity,
        //decoration: BoxDecoration(color: Colors.blueGrey),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _textoDiaActual(context, (i + 1).toString()),
              _subTitle(context, (i + 1).toString()),
              _parafo((i + 1).toString()),
              _flechas(),
              _botonVerMas(context, (i + 1).toString())

              //Text('${i + 1}')
            ]),
      ));
    }
    return items;
  }

  Widget _flechas() {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: size.width * 0.19,
          //decoration: BoxDecoration(color: Colors.blue),
          child: IconButton(
            padding: EdgeInsets.all(0.0),
            iconSize: 30.0,
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/svg/left-arrow.svg',
                  height: 20.0,
                  color: Colors.orange[900],
                ),
                AutoSizeText(localizations.t('start.prev'),
                    style: TextStyle(
                        //fontSize: FontSize.large.size,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[900]),
                    presetFontSizes: [16, 14, 12],
                    maxLines: 1,
                    wrapWords: false),
                /*Text(
                  localizations.t('start.prev'),
                  style: TextStyle(
                      color: Colors.orange[900],
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.large.size),
                ),*/
              ],
            ),
            onPressed: () => buttonCarouselController.previousPage(
                duration: Duration(milliseconds: 300), curve: Curves.linear),
          ),
        ),
        SizedBox(
          //alignment: Alignment.bottomRight,
          width: size.width * 0.19,
          //decoration: BoxDecoration(color: Colors.blue),
          child: IconButton(
            padding: EdgeInsets.only(right: 0.0, left: 0.0),
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /*Text(
                  localizations.t('start.next'),
                  style: TextStyle(
                      color: Colors.orange[900],
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.large.size),
                ),*/
                AutoSizeText(localizations.t('start.next'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.orange[900]),
                    presetFontSizes: [16, 14, 12],
                    maxLines: 1,
                    wrapWords: false),
                SvgPicture.asset(
                  'assets/svg/right-arrow.svg',
                  height: 20.0,
                  color: Colors.orange[900],
                ),
              ],
            ),
            onPressed: () => buttonCarouselController.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.linear),
          ),
        ),
      ],
    );
  }

  Widget _crearimagen(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final String assetLogo =
        'assets/svg/${_imageActualCirculo(int.parse(prefs.day))}.svg';
    final Widget logo = SvgPicture.asset(
      assetLogo,
      alignment: Alignment.centerLeft,
      semanticsLabel: 'Acme Logo',
      colorBlendMode: BlendMode.screen,
      color: Color.fromRGBO(255, 255, 255, 0.0),
    );

    return Container(
      //decoration: BoxDecoration(color: Colors.blue),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 7.0),
      margin: EdgeInsets.only(
          left: size.height * 0.21,
          right: size.height * 0.023,
          top: size.height * 0.1),
      width: size.width * 0.24,
      height: size.width * 0.1,
      child: logo,
    );
  }

  Widget _crearTextoCicloActual() {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    final size = MediaQuery.of(context).size;
    return Container(
      //decoration: BoxDecoration(color: Colors.blue),
      width: size.width * 0.37,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
          left: size.height * 0.215,
          right: size.height * 0.010,
          top: size.height * 0.01),
      //margin: EdgeInsets.only(left: size.width * 0.5, bottom: 10.0, top: size.height * 0.008),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AutoSizeText(localizations.t('start.currentCycle'),
              style: TextStyle(
                  color: Color.fromRGBO(24, 80, 93, 1),
                  fontSize: FontSize.medium.size - 1.0,
                  fontWeight: FontWeight.bold),
              minFontSize: 13,
              maxFontSize: 17,
              maxLines: 1,
              textAlign: TextAlign.start,
              wrapWords: false),
          AutoSizeText(" ${calcularCiclos(prefs.cumpleanos).toString()}",
              style: TextStyle(
                  color: Colors.orange[900],
                  fontSize: FontSize.medium.size - 1.0,
                  fontWeight: FontWeight.bold),
              minFontSize: 13,
              maxFontSize: 17,
              maxLines: 1,
              textAlign: TextAlign.start,
              wrapWords: false),
          /*Text(
            localizations.t('start.currentCycle'),
            style: TextStyle(
                color: Color.fromRGBO(24, 80, 93, 1),
                fontSize: FontSize.large.size,
                fontWeight: FontWeight.bold),
          ),*/
          /*Text(
            " ${calcularCiclos(prefs.cumpleanos).toString()}",
            style: TextStyle(
                color: Colors.orange[900],
                fontSize: FontSize.large.size,
                fontWeight: FontWeight.bold),
          ),*/
        ],
      ),
    );
  }

  Widget _crearTextoDiaActual() {
    final size = MediaQuery.of(context).size;
    return Container(
      //decoration: BoxDecoration(color: Colors.blue),
      width: size.width * 0.32,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
          left: size.height * 0.215,
          right: size.height * 0.023,
          top: size.height * 0.01),
      child: Text(
        (int.parse(prefs.day) < 10) ? '0${prefs.day}/28' : '${prefs.day}/28',
        style: TextStyle(
            color: Color.fromRGBO(24, 80, 93, 1),
            fontSize: FontSize.xxLarge.size + 8.0,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _crearSlider() {
    final size = MediaQuery.of(context).size;
    return Container(
      //decoration: BoxDecoration(color: Colors.blue),
      width: size.width * 0.27,
      margin: EdgeInsets.only(
          left: size.height * 0.18,
          right: size.height * 0.023,
          top: size.height * 0.017),
      child: LinearPercentIndicator(
        //padding: EdgeInsets.all(0),
        lineHeight: 10.0,
        percent: 0.0357 * int.parse(prefs.day),
        backgroundColor: Color.fromRGBO(189, 189, 189, 0.7),
        progressColor: _colorBarra(int.parse(prefs.day)),
      ),
    );
  }

  /*Widget _tituloDiaActual(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: size.width * 0.033),
      alignment: Alignment.topLeft,
      child: Text(
        'Día ${prefs.day} de 28',
        style: TextStyle(
            color: Color.fromRGBO(24, 80, 93, 1),
            fontSize: 25.0,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
    );
  }*/

  Widget _swiperTarjetas(String dia) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    return FutureBuilder(
      future: ciclo.cargarTitulo(dia, localizations.localeName),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          arregloBotonMas.add(snapshot.data[0].value);
          return AutoSizeText(
            snapshot.data[0].value,
            style: TextStyle(
                color: Color.fromRGBO(24, 80, 93, 1),
                fontSize: FontSize.large.size + 2.5,
                fontWeight: FontWeight.normal),
            maxLines: 2,
            textAlign: TextAlign.start,
            minFontSize: 14,
            maxFontSize: 20,
          );
          /*Text(
            '${snapshot.data[0].value}',
            style: TextStyle(
                color: Color.fromRGBO(24, 80, 93, 1),
                fontSize: FontSize.large.size + 2.5,
                fontWeight: FontWeight.normal),
            textAlign: TextAlign.start,
          );*/
        } else {
          return SkeletonAnimation(
            child: Container(
              width: double.infinity,
              height: 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[400]),
            ),
          );
        }
      },
    );
  }

  Widget _textoDiaActual(BuildContext context, String dia) {
    final size = MediaQuery.of(context).size;
    return Container(
      //decoration: BoxDecoration(color: Colors.blue),
      margin: EdgeInsets.only(left: size.width * 0.0),
      width: size.width * 0.38,
      //height: size.width * 0.25,
      child: _swiperTarjetas(dia),
    );
  }

  Widget _swiperTarjetasSub(String dia) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    return FutureBuilder(
      future: ciclo.cargarSubTitulo(dia, localizations.localeName),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          arregloBotonMas.add(snapshot.data[0].value);
          return AutoSizeText(snapshot.data[0].value,
              style: TextStyle(
                  fontSize: FontSize.xLarge.size + 1.4,
                  fontWeight: FontWeight.bold),
              minFontSize: 14,
              maxLines: 2,
              textAlign: TextAlign.start,
              wrapWords: false);
          /*Text(
            '${snapshot.data[0].value}',
            style: TextStyle(
                color: Colors.black,
                fontSize: FontSize.large.size - 3.0,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          );*/
        } else {
          return Container();
          /*return SkeletonAnimation(
            child: Container(
              margin: EdgeInsets.only(top: 2.0),
              width: 80,
              height: 8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[300]),
            ),
          );*/
        }
      },
    );
  }

  Widget _subTitle(BuildContext context, String dia) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: size.width * 0.0),
      width: size.width * 0.38,
      child: _swiperTarjetasSub(dia),
    );
  }

  Widget _swiperTarjetasSE(String dia) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    return FutureBuilder(
      future: ciclo.cargarDia(dia, localizations.localeName),
      builder: (BuildContext context, AsyncSnapshot<List<Body>> snapshot) {
        if (snapshot.hasData) {
          return Html(
            data: """
         ${snapshot.data[0].value}
        """,
            style: {
              "p": Style(
                  margin: EdgeInsets.all(0),
                  fontSize: FontSize.small,
                  padding: EdgeInsets.all(0)),
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _parafo(String dia) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.all(0.0),
      padding: EdgeInsets.all(0),
      width: size.width * 0.38,
      height: size.height * 0.21,
      //decoration: BoxDecoration(color: Colors.black),
      child: SingleChildScrollView(child: _swiperTarjetasSE(dia)),
    );
  }

  Widget _botonVerMas(BuildContext context, String dia) {
    final uiProvider = Provider.of<UiProvider>(context);
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);

    final size = MediaQuery.of(context).size;

    return Container(
      //alignment: Alignment.center,
      //decoration: BoxDecoration(color: Colors.black),
      //padding: EdgeInsets.only(top: size.width * 0.015, bottom: size.width * 0.015),
      //margin: EdgeInsets.all(0),
      width: size.width * 0.38,
      height: size.height * 0.05,
      child: FlatButton(
        //padding: EdgeInsets.symmetric(vertical: 0.0),
        child: Text(localizations.t('start.seeMore'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: FontSize.large.size,
            )),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        //elevation: 0.0,
        color: Colors.orange[900],
        textColor: Colors.white,
        onPressed: () {
          //print(dia);
          Navigator.pushNamed(context, 'actividades',
                  arguments: (dia == prefs.day.toString())
                      ? arregloBotonMas
                      : [dia, '', '', '', '', '', '', '', ''])
              .then((value) {
            uiProvider.showHidenReproductor = false;
            //setState(() {});
          });
        },
      ),
    );
  }

  Widget _calendar(BuildContext context) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    final fechaMaximaArreglo = DateTime.now().toString().split(' ');
    var outputFormat = DateFormat('dd/MM/yyyy');
    String fecha = prefs.cumpleanos;
    final bloc = ProviderL.oof(context);
    final size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: bloc.birthdayStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return SizedBox(
          //alignment: Alignment.center,
          //padding: EdgeInsets.only(left: 0.0, right: 0.0),
          height: size.height * 0.10,
          width: size.width * 0.8,

          /*decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),*/
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                //decoration: BoxDecoration(color: Colors.black),
                width: size.width * 0.38,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /*Text(
                      localizations.t('start.birth'),
                      style: TextStyle(
                          color: Color.fromRGBO(24, 80, 93, 1),
                          fontSize: FontSize.large.size - 2.0,
                          fontWeight: FontWeight.bold),
                    ),*/
                    AutoSizeText(localizations.t('start.birth'),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(24, 80, 93, 1)),
                        minFontSize: 17.0,
                        maxFontSize: 22.0,
                        maxLines: 1,
                        wrapWords: false),
                    AutoSizeText(
                        (snapshot.data != null)
                            ? snapshot.data
                            : outputFormat.format(DateTime.parse(fecha)),
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[900]),
                        minFontSize: 18.0,
                        maxFontSize: double.infinity,
                        maxLines: 1,
                        wrapWords: false),
                    /*Text(
                        (snapshot.data != null)
                            ? snapshot.data
                            : outputFormat.format(DateTime.parse(fecha)),
                        style: TextStyle(
                            fontSize: FontSize.xLarge.size + 2.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[900])),*/
                  ],
                ),
              ),
              Container(
                //decoration: BoxDecoration(color: Colors.black),
                width: size.width * 0.38,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /*Text(
                      localizations.t('start.currentDate'),
                      style: TextStyle(
                          color: Color.fromRGBO(24, 80, 93, 1),
                          fontSize: FontSize.large.size - 2.0,
                          fontWeight: FontWeight.bold),
                    ),*/
                    AutoSizeText(localizations.t('start.currentDate'),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(24, 80, 93, 1)),
                        minFontSize: 17.0,
                        maxFontSize: 22.0,
                        maxLines: 1,
                        wrapWords: false),
                    AutoSizeText(
                        outputFormat
                            .format(DateTime.parse(fechaMaximaArreglo[0])),
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[900]),
                        minFontSize: 18.0,
                        maxFontSize: double.infinity,
                        maxLines: 1,
                        wrapWords: false),
                    /*Text(
                        outputFormat
                            .format(DateTime.parse(fechaMaximaArreglo[0])),
                        style: TextStyle(
                            fontSize: FontSize.xLarge.size + 2.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[900])),*/
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _tarjetaCicloCalendario(BuildContext context) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    final size = MediaQuery.of(context).size;
    return Container(
      //decoration: BoxDecoration(color: Colors.black),
      width: size.width * 0.8,
      margin: EdgeInsets.only(bottom: 25.0),
      padding: EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  localizations.t('start.daysLife'),
                  style: TextStyle(
                      color: Color.fromRGBO(24, 80, 93, 1),
                      fontSize: FontSize.large.size,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  (prefs.vividos),
                  style: TextStyle(
                      color: Colors.orange[900],
                      fontSize: FontSize.xLarge.size,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  localizations.t('start.cyclesLived'),
                  style: TextStyle(
                      color: Color.fromRGBO(24, 80, 93, 1),
                      fontSize: FontSize.large.size,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: SvgPicture.asset(
                        'assets/svg/002-cycle.svg',
                      ),
                      height: FontSize.xLarge.size,
                      width: FontSize.xLarge.size,
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      (calcularCiclos(prefs.cumpleanos) - 1).toString(),
                      style: TextStyle(
                          color: Colors.orange[900],
                          fontSize: FontSize.xxLarge.size,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            //margin: EdgeInsets.only(left: 30.0, right: 0.0),
            padding: EdgeInsets.only(
              top: size.height * 0.02,
              bottom: size.height * 0.02,
            ),
            height: size.width * 0.35,
            width: size.width * 0.38,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.amber[300]),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              /*boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 1,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],*/
            ),
          ),
          Container(
            child: TextButton(
              onPressed: () async {
                final fechaMinimaArreglo =
                    prefs.cumpleanos.toString().split('-');
                //final fechaMaximaArreglo = DateTime.now().toString().split('-');
                var datePicked = await DatePicker.showSimpleDatePicker(
                  context,
                  titleText: localizations.t('start.selectTheYear'),
                  initialDate: DateTime(int.parse(fechaMinimaArreglo[0])),
                  firstDate: DateTime(int.parse(fechaMinimaArreglo[0])),
                  lastDate: DateTime(int.parse('2025')),
                  dateFormat: "yyyy",
                  locale: DateTimePickerLocale.es,
                  looping: true,
                );

                if (datePicked != null) {
                  final newFecha = datePicked.toString().split('-');
                  final snackBar = SnackBar(
                      backgroundColor: Colors.blue,
                      content: Text(
                          "${localizations.t('start.generatingCalendaroftheyear')} ${newFecha[0]}"));
                  Scaffold.of(context).showSnackBar(snackBar);

                  final url =
                      'https://app.diasdelalma.com/calendario/app/?year=${newFecha[0]}&birthdate=${prefs.cumpleanos}';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }

                /*showDialog(
                    context: context,
                    builder: (_) => AssetGiffyDialog(
                          image: Image(
                            image: AssetImage(
                                'assets/lottie/11ebecc7ef79b915f6ee2ca33a5b526a.gif'),
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            'Men Wearing Jackets',
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w600),
                          ),
                          description: null,
                          entryAnimation: EntryAnimation.DEFAULT,
                          onOkButtonPressed: () {},
                        ));*/
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    localizations.t('start.calendar'),
                    style: TextStyle(
                        color: Color.fromRGBO(24, 80, 93, 1),
                        fontSize: FontSize.large.size,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.picture_as_pdf,
                    color: Color.fromRGBO(24, 80, 93, 1),
                    size: size.width * 0.10,
                  ),
                  Text(
                    localizations.t('start.download'),
                    style: TextStyle(
                        color: Color.fromRGBO(24, 80, 93, 1),
                        fontSize: FontSize.large.size,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            //margin: EdgeInsets.only(left: 0.0, right: 30.0),
            padding: EdgeInsets.only(
              top: size.height * 0.02,
              bottom: size.height * 0.02,
            ),
            height: size.width * 0.35,
            width: size.width * 0.38,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.amber[300]),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              /*boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],*/
            ),
          ),
        ],
      ),
    );
  }

  Widget _tarjetaCiclo(
      BuildContext context,
      double division,
      int dia,
      int diaMaximo,
      String ciclo,
      Color colorSe,
      String icono,
      String numCiclo,
      String descripcion) {
    final size = MediaQuery.of(context).size;
    final uiProvider = Provider.of<UiProvider>(context);
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    List<dynamic> argumentosPaso = [];
    argumentosPaso.add(numCiclo);
    argumentosPaso.add(arregloImage);
    argumentosPaso.add(division);
    argumentosPaso.add(dia);
    argumentosPaso.add(diaMaximo);
    argumentosPaso.add(ciclo);
    argumentosPaso.add(colorSe);
    argumentosPaso.add(icono);

    return Container(
        height: size.height * 0.1,
        alignment: Alignment.center,
        child: FlatButton(
            onPressed: () {
              // print(arregloImage[0]);
              Navigator.pushNamed(context, 'actividades',
                      arguments: argumentosPaso)
                  .then((value) {
                uiProvider.showHidenReproductor = false;
                //setState(() {});
              });
            },
            child: Container(
              padding: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0),
              height: size.height * 0.090,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                border: Border.all(color: colorSe),
                color: Colors.white,
                borderRadius: BorderRadius.circular(11.0),
                /*boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],*/
              ),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      /*Positioned(
                        child: _images(numCiclo),
                      ),*/
                      Positioned(
                        child: _cuadradoColor(colorSe),
                      ),
                      Positioned(
                        child: _iconoDentro(icono),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            //decoration: BoxDecoration(color: Colors.amber),
                            width: size.width * 0.248,
                            padding: EdgeInsets.only(left: 3.0, right: 0.0),
                            margin: EdgeInsets.only(top: size.height * 0.015),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                title(context, numCiclo, colorSe),
                                subTitle(context, numCiclo),
                              ],
                            ),
                          ),
                          Container(
                            //decoration: BoxDecoration(color: Colors.amber),
                            width: size.width * 0.190,
                            margin: EdgeInsets.only(
                                top: size.height * 0.015,
                                bottom: 0.0,
                                left: 15.0,
                                right: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(localizations.t('start.duration'),
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: FontSize.medium.size - 2.3)),
                                Text(
                                    '${dia.toString()} ${localizations.t('start.of')} ${diaMaximo.toString()} ${localizations.t('start.days')}',
                                    style: TextStyle(
                                      color: Color.fromRGBO(24, 80, 93, 1),
                                      fontSize: FontSize.medium.size - 2.5,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                              //decoration: BoxDecoration(color: Colors.amber),
                              width: size.height * 0.035,
                              height: size.height * 0.035,
                              padding: EdgeInsets.all(0.0),
                              margin: EdgeInsets.only(
                                top: 7.0,
                                bottom: 0.0,
                              ),
                              child: (dia == diaMaximo)
                                  ? Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: FontSize.xxLarge.size + 2.0,
                                    )
                                  : Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                      size: FontSize.xxLarge.size + 2.0,
                                    ))
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.height * 0.01,
                            bottom: size.height * 0.01),
                        width: size.width * 0.62,
                        child: LinearPercentIndicator(
                          backgroundColor: Colors.grey[400],
                          progressColor: Colors.green,
                          lineHeight: 5.0,
                          percent: division * dia,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )));
  }

  Widget title(BuildContext context, String dia, Color color) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    return FutureBuilder(
      future: ciclo.cargarTitulo(dia, localizations.localeName),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return AutoSizeText('${snapshot.data[0].value}',
              minFontSize: 10,
              maxFontSize: 15,
              style: TextStyle(
                  color: Color.fromRGBO(24, 80, 93, 1),
                  fontSize: FontSize.medium.size - 2.3));
        } else {
          return SkeletonAnimation(
            child: Container(
              width: 50,
              height: 10,
              margin: EdgeInsets.only(bottom: 5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), color: color),
            ),
          );
        }
      },
    );
  }

  Widget subTitle(BuildContext context, String dia) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    return FutureBuilder(
      future: ciclo.cargarSubTitulo(dia, localizations.localeName),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return AutoSizeText('${snapshot.data[0].value}',
              maxFontSize: 16,
              minFontSize: 10,
              style: TextStyle(
                  color: Color.fromRGBO(24, 80, 93, 1),
                  fontSize: FontSize.medium.size - 3.2,
                  fontWeight: FontWeight.bold));
        } else {
          return SkeletonAnimation(
            child: Container(
              width: 70,
              height: 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[300]),
            ),
          );
        }
      },
    );
  }

  /*Widget _images(String dia) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: ciclo.cargarImage(dia, localizations.localeName),
      builder:
          (BuildContext context, AsyncSnapshot<List<FieldImage>> snapshot) {
        if (snapshot.hasData) {
          // arregloImage.add(snapshot.data[0].url);
          return _mostrarFoto(snapshot.data[0].url);
        } else {
          // arregloImage.add('1');
          return Container(
              alignment: Alignment.centerLeft,
              height: size.height * 0.08,
              width: size.height * 0.08,
              child: Lottie.asset('assets/lottie/3583-yoga-girl-3.json',
                  width: size.width * 0.35));
        }
      },
    );
  }*/

  /*Widget _mostrarFoto(String url) {
    final size = MediaQuery.of(context).size;

    //if (producto.fotoUrl != null) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
      child: FadeInImage(
        image: NetworkImage(url),
        height: size.height * 0.08,
        width: size.height * 0.08,
        fit: BoxFit.cover,
        placeholder: AssetImage('assets/lottie/animation_500_kicn7t6y.gif'),
      ),
    );
    /*} else {
      return (foto != null)
          ? Image(image: AssetImage(foto.path), height: size.height * 0.2)
          : Lottie.asset('assets/lottie/5856-image-picture.json',
              width: size.width * 0.6);
    }*/
  }*/

  Widget _cuadradoColor(Color colorSe) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        child: Container(
          height: size.height * 0.095,
          width: size.height * 0.08,
          decoration: BoxDecoration(color: colorSe),
        ));
  }

  Widget _iconoDentro(String icono) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        child: Container(
          child: SvgPicture.asset(
            'assets/svg/$icono.svg',
          ),
          height: size.height * 0.04,
          width: size.height * 0.04,
        ));
  }

  /*_infoCicloDia() async {
    Future<List> productos = ciclo.cargarDia(prefs.day);
    List<Body> list = await productos;

    setState(() {
      this.infoDia = list[0].value;
    });
    // return list[0].value;
  }*/

  List<int> fibonacci(dayOfCycle) {
    int add = 0;
    List<int> data = [];
    for (int i = 7; i >= 1; i--) {
      add += i;
      if (dayOfCycle <= add) {
        int index = add - dayOfCycle;
        index = i - index;
        data.add(index);
        data.add(i);
        return data;
      }
    }
    return data;
  }

  Widget progreso(
      BuildContext context,
      double div,
      int maxday,
      String ciclo,
      var rango,
      int day,
      Color colorSe,
      String icono,
      String numCiclo,
      String descripcion) {
    switch (rango) {
      case true:
        return _tarjetaCiclo(context, div, maxday, maxday, ciclo, colorSe,
            icono, numCiclo, descripcion);
        // return "DIVISION: $div DIA MAXIMO: $maxday CICLO: $ciclo RANGO completo DIA $maxday de $maxday";
        break;
      case false:
        return _tarjetaCiclo(context, div, 0, maxday, ciclo, colorSe, icono,
            numCiclo, descripcion);
        // return "DIVISION: $div DIA MAXIMO: $maxday CICLO: $ciclo RANGO incompleto DIA 0 de $maxday";
        break;
      default:
        return _tarjetaCiclo(context, div, day, maxday, ciclo, colorSe, icono,
            numCiclo, descripcion);
        // return "DIVISION: $div DIA MAXIMO: $maxday CICLO: $ciclo RANGO $rango DIA $day de $maxday";
        break;
    }
  }

  _ciclofor(BuildContext context) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);

    double barra = 1;
    List<String> ciclos = [];
    List<Widget> tarjetas = [];

    ciclos.add(localizations.t('start.casualCycle'));
    ciclos.add(localizations.t('start.astralCycle'));
    ciclos.add(localizations.t('start.ethericCycle'));
    ciclos.add(localizations.t('start.cordialCycle'));
    ciclos.add(localizations.t('start.mentalCycle'));
    ciclos.add(localizations.t('start.emotionalCycle'));
    ciclos.add(localizations.t('start.physicalCycle'));

    List<Color> colors = [];
    colors.add(Color.fromRGBO(230, 77, 171, 1));
    colors.add(Color.fromRGBO(42, 158, 231, 1));
    colors.add(Color.fromRGBO(22, 227, 203, 1));
    colors.add(Color.fromRGBO(113, 219, 22, 1));
    colors.add(Color.fromRGBO(232, 197, 13, 1));
    colors.add(Color.fromRGBO(255, 113, 30, 1));
    colors.add(Color.fromRGBO(236, 25, 39, 1));

    List<String> iconos = [];
    iconos.add('Grupo241');
    iconos.add('Grupo238');
    iconos.add('Grupo240');
    iconos.add('Grupo239');
    iconos.add('Grupo237');
    iconos.add('Grupo236');
    iconos.add('Grupo235');

    List<String> nuCiclo = [];
    nuCiclo.add('36');
    nuCiclo.add('35');
    nuCiclo.add('34');
    nuCiclo.add('33');
    nuCiclo.add('32');
    nuCiclo.add('31');
    nuCiclo.add('30');

    List<String> descripcion = [];
    descripcion.add(localizations.t('start.seventhChakra'));
    descripcion.add(localizations.t('start.sixthChakra'));
    descripcion.add(localizations.t('start.fifthChakra'));
    descripcion.add(localizations.t('start.fourthChakra'));
    descripcion.add(localizations.t('start.thirdChakra'));
    descripcion.add(localizations.t('start.secondChakra'));
    descripcion.add(localizations.t('start.firstChakra'));

    List<int> rango = fibonacci(int.parse(prefs.day));

    for (int i = 7; i >= 1; i--) {
      if (rango[1] < i) {
        tarjetas.add(progreso(
            context,
            barra / i,
            i,
            ciclos[i - 1],
            true,
            rango[0],
            colors[i - 1],
            iconos[i - 1],
            nuCiclo[i - 1],
            descripcion[i - 1]));
        // print(progreso(barra / i, i, ciclos[i - 1], true, rango[0]));

      } else if (rango[1] == i) {
        // print(progreso(barra / i, i, ciclos[i - 1], rango[1], rango[0]));
        tarjetas.add(progreso(
            context,
            barra / i,
            i,
            ciclos[i - 1],
            rango[1],
            rango[0],
            colors[i - 1],
            iconos[i - 1],
            nuCiclo[i - 1],
            descripcion[i - 1]));

        arregloBotonMas = [];

        arregloBotonMas.add(prefs.day);
        arregloBotonMas.add(arregloImage);
        arregloBotonMas.add(barra / i);
        arregloBotonMas.add(rango[0]);
        arregloBotonMas.add(i);
        arregloBotonMas.add(ciclos[i - 1]);
        arregloBotonMas.add(colors[i - 1]);
        arregloBotonMas.add(iconos[i - 1]);
      } else {
        // print(progreso(barra / i, i, ciclos[i - 1], false, rango[0]));
        tarjetas.add(progreso(
            context,
            barra / i,
            i,
            ciclos[i - 1],
            false,
            rango[0],
            colors[i - 1],
            iconos[i - 1],
            nuCiclo[i - 1],
            descripcion[i - 1]));
      }
    }
    return tarjetas;
  }

  Color _colorBarra(int dia) {
    if (dia <= 7) {
      return Color.fromRGBO(236, 25, 39, 1);
    } else if (dia > 7 && dia <= 13) {
      return Color.fromRGBO(255, 113, 30, 1);
    } else if (dia > 13 && dia <= 18) {
      return Color.fromRGBO(232, 197, 13, 1);
    } else if (dia > 18 && dia <= 22) {
      return Color.fromRGBO(113, 219, 22, 1);
    } else if (dia > 22 && dia <= 25) {
      return Color.fromRGBO(22, 227, 203, 1);
    } else if (dia > 25 && dia <= 27) {
      return Color.fromRGBO(42, 158, 231, 1);
    } else {
      return Color.fromRGBO(230, 77, 171, 1);
    }
  }

  _imageActualCirculo(int dia) {
    if (dia <= 7) {
      return 'grupo179';
    } else if (dia > 7 && dia <= 13) {
      return 'Grupo180';
    } else if (dia > 13 && dia <= 18) {
      return 'Grupo181';
    } else if (dia > 18 && dia <= 22) {
      return 'Grupo183';
    } else if (dia > 22 && dia <= 25) {
      return 'Grupo184';
    } else if (dia > 25 && dia <= 27) {
      return 'Grupo182';
    } else {
      return 'Grupo185';
    }
  }
}
