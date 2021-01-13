import 'package:dalma/src/providers/como_gasto_localizations.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:dalma/src/providers/ciclo_provider.dart';
import 'package:dalma/src/providers/circulo_provider.dart';
import 'package:flutter_html/flutter_html.dart';
//import 'package:dalma/src/models/ciclos_model.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:dalma/src/utils/utils.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dalma/src/models/cicloV_model.dart';

class ActividadPage extends StatefulWidget {
  @override
  _ActividadPageState createState() => _ActividadPageState();
}

class _ActividadPageState extends State<ActividadPage>
    with TickerProviderStateMixin {
  List producto = new List();

  final ciclo = new CicloProvider();

  final circulo = new CicloVTwoProvider();

  AudioPlayer audioPlayer = AudioPlayer();

  List arregloBotonMasV = new List();

  CarouselController buttonCarouselController = CarouselController();

  List<Ciclo> list = new List();

  List<FieldArticleAudio> listAudio = new List();

  int p = 0;

  AnimationController _animationController;
  List<bool> listBool = new List();
  List<AnimationController> listAnima = new List();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 450));
  }

  @override
  Widget build(BuildContext context) {
    //_audioList();

    final List prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      producto = prodData;
    }
    if (producto[1] == '') {
      if (int.parse(producto[0]) <= 7) {
        arregloBotonMasV.add('Grupo235');
        arregloBotonMasV.add(Color.fromRGBO(236, 25, 39, 1));
      } else if (int.parse(producto[0]) > 7 && int.parse(producto[0]) <= 13) {
        arregloBotonMasV.add('Grupo236');
        arregloBotonMasV.add(Color.fromRGBO(255, 113, 30, 1));
      } else if (int.parse(producto[0]) > 13 && int.parse(producto[0]) <= 18) {
        arregloBotonMasV.add('Grupo237');
        arregloBotonMasV.add(Color.fromRGBO(232, 197, 13, 1));
      } else if (int.parse(producto[0]) > 18 && int.parse(producto[0]) <= 22) {
        arregloBotonMasV.add('Grupo239');
        arregloBotonMasV.add(Color.fromRGBO(113, 219, 22, 1));
      } else if (int.parse(producto[0]) > 22 && int.parse(producto[0]) <= 25) {
        arregloBotonMasV.add('Grupo240');
        arregloBotonMasV.add(Color.fromRGBO(22, 227, 203, 1));
      } else if (int.parse(producto[0]) > 25 && int.parse(producto[0]) <= 27) {
        arregloBotonMasV.add('Grupo238');
        arregloBotonMasV.add(Color.fromRGBO(42, 158, 231, 1));
      } else {
        arregloBotonMasV.add('Grupo241');
        arregloBotonMasV.add(Color.fromRGBO(230, 77, 171, 1));
      }
    }
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor:
            (producto[6] == '') ? arregloBotonMasV[1] : producto[6],
        body: CustomScrollView(
          slivers: <Widget>[
            _crearAppbar(context),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              _posterTitulo(context),
              (producto[1] == '') ? Container() : _diasPorcentaje(context),
              (producto[1] == '') ? Container() : _crearSlider(context),
              _titulo(context),
              _playList(context),
              _descripcionIndices(context),
              _descripcion(context),
            ]))
          ],
        ),
        //floatingActionButton: _creaBoton(context),
        //floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    /*return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;*/
    await audioPlayer.stop();
    Navigator.of(context).pop(true);
    return true;
  }

  Widget _crearAppbar(BuildContext context) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    var desision = int.parse(producto[0]);

    if (desision >= 29) {
      desision = int.parse(producto[0]) - 30;
    } else {
      desision = 1;
    }
    return SliverAppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () async {
          await audioPlayer.stop();
          Navigator.of(context).pop();
        },
      ),
      elevation: 2.0,
      backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          background: ClipRRect(
        // borderRadius: BorderRadius.circular(20.0),
        child: FutureBuilder(
          future: ciclo.cargarImage(producto[0], localizations.localeName),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return FadeInImage(
                image: NetworkImage('${snapshot.data[0].url}'),
                placeholder:
                    AssetImage('assets/lottie/animation_500_kicn7t6y.gif'),
                fadeInDuration: Duration(milliseconds: 150),
                fit: BoxFit.cover,
              );
            } else {
              return FadeInImage(
                image: AssetImage(
                    'assets/lottie/11ebecc7ef79b915f6ee2ca33a5b526a.gif'),
                placeholder:
                    AssetImage('assets/lottie/animation_500_kicn7t6y.gif'),
                fadeInDuration: Duration(milliseconds: 250),
                fit: BoxFit.cover,
              );
            }
          },
        ),
      )),
    );
  }

  Widget _posterTitulo(BuildContext context) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Hero(
            tag: 'image',
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                    color: _escogerColor((producto[1] == '')
                        ? arregloBotonMasV[1]
                        : producto[6]),
                    child: Container(
                      width: size.width * 0.25,
                      height: size.width * 0.25,
                      padding: EdgeInsets.all(size.width * 0.06),
                      child: SvgPicture.asset(
                        'assets/svg/${(producto[7] == '') ? arregloBotonMasV[0] : producto[7]}.svg',
                      ),
                    ))),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FutureBuilder(
                  future:
                      ciclo.cargarTitulo(producto[0], localizations.localeName),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.hasData) {
                      return Text('${snapshot.data[0].value}',
                          style: TextStyle(
                              fontSize: size.height * 0.025,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis);
                    } else {
                      return Skeleton(height: 10, style: SkeletonStyle.text);
                    }
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                FutureBuilder(
                  future: ciclo.cargarSubTitulo(
                      producto[0], localizations.localeName),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.hasData) {
                      return Text('${snapshot.data[0].value}',
                          style: TextStyle(
                              fontSize: size.height * 0.030,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis);
                    } else {
                      return Skeleton(height: 16, style: SkeletonStyle.text);
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _descripcionIndices(BuildContext context) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: ciclo.cargarParrafoCiclo(producto[0], localizations.localeName),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.11),
            child: Html(
              data: """
         ${snapshot.data[0].value}
        """,
              style: {
                "*": Style(color: Colors.white),
                "p": Style(
                    margin: EdgeInsets.all(0),
                    fontSize: FontSize.xLarge,
                    padding: EdgeInsets.all(0),
                    color: Colors.white),
              },
            ),
          );
        } else {
          return Container(
              alignment: Alignment.centerLeft,
              height: 100.0,
              width: 70.0,
              child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _descripcion(BuildContext context) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: ciclo.cargarTextoCiclo(producto[0], localizations.localeName),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.11),
            child: Html(
              data: """
         ${snapshot.data[0].value}
        """,
              style: {
                "*": Style(color: Colors.white),
                "p": Style(
                    margin: EdgeInsets.all(0),
                    fontSize: FontSize.xLarge,
                    padding: EdgeInsets.all(0),
                    color: Colors.white),
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _diasPorcentaje(BuildContext context) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    final size = MediaQuery.of(context).size;
    double temp = ((producto[3] == '') ? 0.0 : producto[3] / producto[4]) * 100;
    double division = double.parse((temp).toStringAsFixed(2));
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.11),
      margin: EdgeInsets.only(left: 7.0, right: 7.0, top: 30.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '${producto[3]} ${localizations.t('start.of')} ${producto[4]} ${localizations.t('start.days')}',
            style:
                TextStyle(color: Colors.white, fontSize: FontSize.large.size),
          ),
          Text(
            '${division.toString()}%',
            style:
                TextStyle(color: Colors.white, fontSize: FontSize.large.size),
          )
        ],
      ),
    );
  }

  Widget _crearSlider(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.11),
      margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
      child: LinearPercentIndicator(
        lineHeight: 7.0,
        percent: (producto[2] == '') ? 0 : producto[2] * producto[3],
        backgroundColor: Colors.grey[400],
        progressColor: Colors.green,
      ),
    );
  }

  Widget _titulo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.11),
      margin: EdgeInsets.only(left: 7.0, right: 7.0, top: 15.0, bottom: 10.0),
      child: Text('Grabaciones',
          style: TextStyle(
              fontSize: size.height * 0.022,
              color: Colors.white,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _playList(BuildContext context) {
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    final size = MediaQuery.of(context).size;

    List<Widget> items = new List();
    return FutureBuilder(
      future: circulo.cargarAudios(producto[0], localizations.localeName),
      builder: (BuildContext context, AsyncSnapshot<List<Ciclo>> snapshot) {
        if (snapshot.hasData) {
          listAudio = snapshot.data[0].fieldArticleAudio;
          if (listAudio.length > 0) {
            for (int i = 0; i < _numeroTarjetas(listAudio.length); i++) {
              items.add(Container(
                margin: EdgeInsets.all(0),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (Widget item in _playListlItem(context, listAudio))
                        item,
                      //Text('${snapshot.data[0].fieldArticleAudio[1].url}')
                      //Text('${i + 1}')
                    ]),
              ));
            }

            p = 0;
            return Container(
                //padding: EdgeInsets.symmetric(horizontal: size.width * 0.11),
                margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      //padding: EdgeInsets.all(0.0),
                      iconSize: 20.0,
                      icon: SvgPicture.asset(
                        'assets/svg/left-arrow.svg',
                        height: 23.0,
                        color: Colors.white,
                      ),
                      onPressed: () => buttonCarouselController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.linear),
                    ),
                    Expanded(
                      child: CarouselSlider(
                        items: <Widget>[for (Widget item in items) item],
                        carouselController: buttonCarouselController,
                        options: CarouselOptions(
                            //enableInfiniteScroll: false,
                            height: size.height * 0.25,
                            autoPlay: false,
                            //enlargeCenterPage: true,
                            viewportFraction: 1.0,
                            //aspectRatio: 2.0,
                            initialPage: 0,
                            onPageChanged: (value, _) {}),
                      ),
                    ),
                    IconButton(
                      //padding: EdgeInsets.all(0.0),
                      iconSize: 20.0,
                      icon: SvgPicture.asset(
                        'assets/svg/right-arrow.svg',
                        height: 23.0,
                        color: Colors.white,
                      ),
                      onPressed: () => buttonCarouselController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.linear),
                    ),
                  ],
                ));
          } else {
            return Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.11),
                margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
                child: Skeleton(
                    height: size.height * 0.25, style: SkeletonStyle.text));
          }
        } else {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.11),
              margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
              child: Skeleton(
                  height: size.height * 0.25, style: SkeletonStyle.text));
        }
      },
    );
  }

  _playListlItem(BuildContext context, List<FieldArticleAudio> list) {
    final size = MediaQuery.of(context).size;

    List<Widget> items = new List();

    for (int j = 0; j < 3; j++) {
      listAnima.add(AnimationController(
          vsync: this, duration: Duration(milliseconds: 450)));
      listBool.add(false);
      int posicion = p;
      if (p < list.length) {
        items.add(Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          height: size.height * 0.08333,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white))
              //color: Color.fromRGBO(0, 0, 0, 0.2),
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (list[p].description == '')
                  ? Text(
                      'untitled',
                      style: TextStyle(
                          color: Colors.white, fontSize: FontSize.large.size),
                    )
                  : Text(
                      '${list[p].description}',
                      style: TextStyle(
                          color: Colors.white, fontSize: FontSize.large.size),
                    ),
              Container(
                width: size.height * 0.05,
                height: size.height * 0.05,
                child: IconButton(
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: listAnima[posicion],
                    color: Colors.black,
                    size: size.height * 0.03,
                  ),
                  onPressed: () {
                    _handleOnPressed(list[posicion].url, listBool, posicion);
                    //playAudio(context, list[p].url);
                  },
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
        p++;
      } else {
        break;
      }
    }
    return items;
  }

  void _handleOnPressed(String url, List<bool> play, int pos) async {
    await audioPlayer.stop();
    for (int i = 0; i < play.length; i++) {
      if (i == pos) {
        play[pos] = !play[pos];
      } else {
        play[i] = false;
        listAnima[i].reverse();
      }
    }

    setState(() {
      if (play[pos]) {
        playAudio(context, url, pos);
        listAnima[pos].forward();
      } else {
        listAnima[pos].reverse();
      }
    });
  }

  _numeroTarjetas(int size) {
    int numero_tarjetas = (size ~/ 3);
    if (!(size % 3 == 0)) {
      numero_tarjetas++;
    }
    return numero_tarjetas;
  }

  _creaBoton(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.white,
        child: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: _animationController,
          color: Colors.greenAccent,
        ),
        onPressed: () {
          //_handleOnPressed();
          play(context);
        });
  }

  play(BuildContext context) async {
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    int result = await audioPlayer
        .play('https://mariachipotrosdetijuana.com/Disenchanted.mp3');
    if (result == 1) {
      // success
    }
  }

  playAudio(BuildContext context, String url, int pos) async {
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    /*int result = await audioPlayer.play(url);
    if (result == 1) {
      // success
      print('music');
    }*/
    await audioPlayer.setUrl(url);
    await audioPlayer.setReleaseMode(ReleaseMode.STOP);

    await audioPlayer.resume();

    /*audioPlayer.onDurationChanged.listen((Duration d) {
      var string = d.toString();
      string.split(".");
      //d.toString().split('.');
      print('Max duration: ${string[0]}');
      //setState(() => duration = d);
    });*/

    /*audioPlayer.onAudioPositionChanged.listen((Duration p) {
      var string1 = p.toString();
      string1.split('.');
      var string2 = string1[0].toString();
      //string2.split(':');
      print('barra ${string1[1]}');
    });*/

    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        listAnima[pos].reverse();
        //position = duration;
      });
    });
  }

  _escogerColor(Color color) {
    if (color == Color.fromRGBO(236, 25, 39, 1)) {
      return Color.fromRGBO(255, 0, 17, 1.0);
    } else if (color == Color.fromRGBO(255, 113, 30, 1)) {
      return Color.fromRGBO(255, 94, 0, 1.0);
    } else if (color == Color.fromRGBO(232, 197, 13, 1)) {
      return Color.fromRGBO(255, 214, 0, 1.0);
    } else if (color == Color.fromRGBO(113, 219, 22, 1)) {
      return Color.fromRGBO(118, 255, 0, 1.0);
    } else if (color == Color.fromRGBO(22, 227, 203, 1)) {
      return Color.fromRGBO(0, 255, 225, 1.0);
    } else if (color == Color.fromRGBO(42, 158, 231, 1)) {
      return Color.fromRGBO(0, 157, 255, 1.0);
    } else {
      return Color.fromRGBO(255, 0, 157, 1.0);
    }
  }

  _diaOCiclo(List varibles) {
    print(varibles.length);
    if (varibles.length > 8) {
      return true;
    } else {
      return false;
    }
  }
}
