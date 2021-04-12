import 'package:dalma/src/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:dalma/src/providers/como_gasto_localizations.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:dalma/src/providers/ciclo_provider.dart';
import 'package:dalma/src/providers/circulo_provider.dart';
import 'package:flutter_html/flutter_html.dart';
//import 'package:dalma/src/models/ciclos_model.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:dalma/src/utils/utils.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dalma/src/models/cicloV_model.dart';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dalma/src/player/PlayingControlsSmall.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:dalma/src/player/PositionSeekWidget.dart';
import 'package:dalma/src/models/MyAudio.dart';

class ActividadPage extends StatefulWidget {
  @override
  _ActividadPageState createState() => _ActividadPageState();
}

class _ActividadPageState extends State<ActividadPage>
    with TickerProviderStateMixin {
  final audios = <MyAudio>[
    /*MyAudio(
        name: "Online",
        audio: Audio.network(
            "https://app.diasdelalma.com/sites/default/files/2021-01/Jindupe%20-%20Lauren%20Duski.mp3"),
        imageUrl:
            "https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg"),*/
  ];

  //final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  List producto = [];

  final ciclo = new CicloProvider();

  final circulo = new CicloVTwoProvider();

  AudioPlayer audioPlayer = AudioPlayer();

  List arregloBotonMasV = [];

  CarouselController buttonCarouselController = CarouselController();

  List<Ciclo> list = [];

  List<FieldArticleAudio> listAudio = [];

  int p = 0;

  List<bool> listBool = [];
  List<Duration> listDura = [];
  List<AnimationController> listAnima = [];
  bool isPlaying = false;

  Duration duracionVar = Duration(hours: 00, minutes: 00, seconds: 00);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
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
              uiProvider.showHidenReproductor ? _titulo(context) : Container(),
              Visibility(
                visible: uiProvider.showHidenReproductor,
                child: _playList(context),
              ),
              _descripcionIndices(context),
              _descripcion(context),
            ]))
          ],
        ),
        /*floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.audiotrack),
          onPressed: () {},
        ),*/
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
      pinned: false,
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
                image: AssetImage('assets/lottie/animation_500_kicn7t6y.gif'),
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
    final uiProvider = Provider.of<UiProvider>(context);
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.bottomLeft,
      padding:
          EdgeInsets.only(left: size.width * 0.08, right: size.width * 0.02),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    /*Container(
                      margin: EdgeInsets.only(
                          bottom: 0.0, right: size.width * 0.12, top: 0.0),
                      padding: EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        //borderRadius: BorderRadius.circular(25.0),
                        /*boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],*/
                      ),
                      child: IconButton(
                        padding: EdgeInsets.all(1.0),
                        splashRadius: 2.0,
                        color: Colors.white,
                        icon: Icon(Icons.volume_up),
                        iconSize: size.height * 0.030,
                        onPressed: () {
                          if (uiProvider.showHidenReproductor) {
                            uiProvider.showHidenReproductor = false;
                          } else {
                            uiProvider.showHidenReproductor = true;
                          }
                        },
                      ),
                    ),*/
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(0.0),
                      margin: EdgeInsets.all(0.0),
                      width: size.width * 0.35,
                      child: FutureBuilder(
                        future: ciclo.cargarTitulo(
                            producto[0], localizations.localeName),
                        builder: (BuildContext context,
                            AsyncSnapshot<List> snapshot) {
                          if (snapshot.hasData) {
                            return Text('${snapshot.data[0].value}',
                                style: TextStyle(
                                    fontSize: size.height * 0.021,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis);
                          } else {
                            return Skeleton(
                                height: size.height * 0.021,
                                style: SkeletonStyle.text);
                          }
                        },
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.all(0.0),
                      //splashRadius: 1.0,
                      color: Colors.white,
                      icon: SvgPicture.asset(
                        'assets/svg/volume.svg',
                        height: size.height * 0.035,
                        color: Colors.white,
                      ),
                      iconSize: size.height * 0.029,
                      onPressed: () {
                        if (uiProvider.showHidenReproductor) {
                          uiProvider.showHidenReproductor = false;
                        } else {
                          uiProvider.showHidenReproductor = true;
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.0,
                ),
                FutureBuilder(
                  future: ciclo.cargarSubTitulo(
                      producto[0], localizations.localeName),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.hasData) {
                      return Text('${snapshot.data[0].value}',
                          style: TextStyle(
                            fontSize: size.height * 0.032,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis);
                    } else {
                      return Skeleton(
                          height: size.height * 0.032,
                          style: SkeletonStyle.text);
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
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Html(
              data: """
         ${snapshot.data[0].value}
        """,
              style: {
                "*": Style(
                  color: Colors.white,
                  fontSize: FontSize.large,
                ),
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
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
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
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
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
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
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
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
      margin: EdgeInsets.only(left: 7.0, right: 7.0, top: 15.0, bottom: 10.0),
      child: Text('Audios',
          style: TextStyle(
              fontSize: size.height * 0.022,
              color: Colors.white,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _playList(BuildContext context) {
    // instancia para determinar el idioma
    ComoGastoLocalizations localizations =
        Localizations.of<ComoGastoLocalizations>(
            context, ComoGastoLocalizations);

    // varible para determinar el tamaño de algunos componentes
    final size = MediaQuery.of(context).size;

    // list tipo widget para llenarlo con los slides del carusel
    List<Widget> items = [];

    return FutureBuilder(
      future: circulo.cargarAudios(producto[0], localizations.localeName),
      builder: (BuildContext context, AsyncSnapshot<List<Ciclo>> snapshot) {
        if (snapshot.hasData) {
          listAudio = snapshot.data[snapshot.data.length - 1].fieldArticleAudio;
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
                        height: 20.0,
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
                            enableInfiniteScroll: false,
                            height: size.height * 0.25,
                            autoPlay: false,
                            //enlargeCenterPage: true,
                            viewportFraction: 1.0,
                            //aspectRatio: 2.0,
                            initialPage: 0,
                            onPageChanged: (value, _) {
                              if (items.length == value) {
                                print(value);
                              }
                            }),
                      ),
                    ),
                    IconButton(
                      //padding: EdgeInsets.all(0.0),
                      iconSize: 20.0,
                      icon: SvgPicture.asset(
                        'assets/svg/right-arrow.svg',
                        height: 20.0,
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
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
                child: Skeleton(
                    height: size.height * 0.25, style: SkeletonStyle.text));
          }
        } else {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
              child: Skeleton(
                  height: size.height * 0.25, style: SkeletonStyle.text));
        }
      },
    );
  }

  _playListlItem(BuildContext context, List<FieldArticleAudio> list) {
    List<Widget> items = [];

    for (int j = 0; j < 3; j++) {
      int posicion = p;
      if (posicion < list.length) {
        listAnima.add(AnimationController(
            vsync: this, duration: Duration(milliseconds: 450)));
        listBool.add(false);
        listDura.add(Duration(hours: 00, minutes: 00, seconds: 00));

        audios.add(MyAudio(
            name: (list[p].description == '')
                ? 'untitled'
                : '${list[p].description}',
            audio: Audio.network("${list[p].url}"),
            imageUrl:
                "https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg"));

        items.add(
          PlayerWidget(myAudio: audios[p]),
        );

        /*items.add(Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          height: size.height * 0.08333,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white))
              //color: Color.fromRGBO(0, 0, 0, 0.2),
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (list[p].description == '')
                      ? Text(
                          'untitled',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSize.large.size),
                        )
                      : Text(
                          '${list[p].description}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSize.large.size),
                        ),
                  Text(
                    format(listDura[p]),
                    style: TextStyle(
                        color: Colors.white, fontSize: FontSize.medium.size),
                  )
                ],
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
                    _handleOnPressed(
                        list[posicion].url, listBool, posicion, listDura);
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
        ));*/

        p++;
      } else {
        break;
      }
    }
    return items;
  }

  /*void _handleOnPressed(
      String url, List<bool> play, int pos, List<Duration> duracion) async {
    print(audios);
    await audioPlayer.stop();
    for (int i = 0; i < play.length; i++) {
      if (i == pos) {
        play[pos] = !play[pos];
        //duracion[pos] = Duration(hours: pos, minutes: 20, seconds: 00);
      } else {
        play[i] = false;
        //duracion[i] = Duration(hours: 00, minutes: 00, seconds: 00);
        listAnima[i].reverse();
      }
    }

    //final uiPlayList = Provider.of<UiPlayList>(context);

    if (play[pos]) {
      await playAudio(context, url, pos, duracion);
    }

    //print('la posicion $pos');

    //setState(() {
    if (play[pos]) {
      listDura[pos] = duracionVar;
      listAnima[pos].forward();
    } else {
      listAnima[pos].reverse();
    }
    //});
  }*/

  _numeroTarjetas(int size) {
    int numeroTarjetas = (size ~/ 3);
    if (!(size % 3 == 0)) {
      numeroTarjetas++;
    }
    return numeroTarjetas;
  }

  playAudio(BuildContext context, String url, int pos,
      List<Duration> duracion) async {
    await audioPlayer.setUrl(url);

    await audioPlayer.setReleaseMode(ReleaseMode.STOP);

    await audioPlayer.resume();

    audioPlayer.onPlayerCompletion.listen((event) {
      listAnima[pos].reverse();
    });
  }

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

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
}

class PlayerWidget extends StatefulWidget {
  final MyAudio myAudio;

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();

  const PlayerWidget({
    @required this.myAudio,
  });
}

class _PlayerWidgetState extends State<PlayerWidget> {
  AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

  @override
  void initState() {
    _assetsAudioPlayer.playlistFinished.listen((data) {
      print("finished : $data");
    });
    _assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print("playlistAudioFinished : $data");
    });
    _assetsAudioPlayer.current.listen((data) {
      print("current : $data");
    });
    super.initState();
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  MyAudio find(List<MyAudio> source, String fromPath) {
    return source.firstWhere((element) => element.audio.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return StreamBuilder(
        stream: _assetsAudioPlayer.loopMode,
        builder: (context, snapshotLooping) {
          final LoopMode loopMode = snapshotLooping.data;
          return StreamBuilder(
              stream: _assetsAudioPlayer.isPlaying,
              initialData: false,
              builder: (context, snapshotPlaying) {
                final isPlaying = snapshotPlaying.data;
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  height: size.height * 0.08333,
                  //padding: EdgeInsets.only(top: size.height * 0.015),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.white))
                      //color: Color.fromRGBO(0, 0, 0, 0.2),
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: <Widget>[
                                /*Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Neumorphic(
                                    style: NeumorphicStyle(
                                      boxShape: NeumorphicBoxShape.circle(),
                                      depth: 8,
                                      surfaceIntensity: 1,
                                      shape: NeumorphicShape.concave,
                                    ),
                                    child: Image.network(
                                      widget.myAudio.imageUrl,
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),*/
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Text(
                                      this.widget.myAudio.name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: FontSize.large.size),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: PlayingControlsSmall(
                              loopMode: loopMode,
                              isPlaying: isPlaying,
                              toggleLoop: () {
                                _assetsAudioPlayer.toggleLoop();
                              },
                              onPlay: () {
                                if (_assetsAudioPlayer.current.value == null) {
                                  _assetsAudioPlayer.open(widget.myAudio.audio,
                                      autoStart: true);
                                } else {
                                  _assetsAudioPlayer.playOrPause();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      StreamBuilder(
                          stream: _assetsAudioPlayer.realtimePlayingInfos,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox();
                            }
                            RealtimePlayingInfos infos = snapshot.data;
                            return PositionSeekWidget(
                              seekTo: (to) {
                                _assetsAudioPlayer.seek(to);
                              },
                              duration: infos.duration,
                              currentPosition: infos.currentPosition,
                            );
                          }),
                    ],
                  ),
                );
              });
        });
  }
}
