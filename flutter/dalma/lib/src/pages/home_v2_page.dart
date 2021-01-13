// import 'package:dalma/src/bloc/provider.dart';
import 'package:dalma/src/models/producto_model.dart';
import 'package:dalma/src/providers/productos_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeTwoPage extends StatefulWidget {
  @override
  _HomeTwoPageState createState() => _HomeTwoPageState();
}

class _HomeTwoPageState extends State<HomeTwoPage> {
  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('DÍAS DEL ALMA'),
        titleSpacing: 40.0,
        backgroundColor: Colors.cyan[800],
      ),
      body: _crearListado(),
      floatingActionButton: _creaBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, i) => _crearItem(context, productos[i]));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto) {
    // final size = MediaQuery.of(context).size;

    return Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        onDismissed: (direccion) {
          productosProvider.borrarProducto(producto.id);
        },
        child: Card(
          child: Column(
            children: <Widget>[
              (producto.fotoUrl == null)
                  ? Lottie.asset(
                      'assets/lottie/26240-waveloadingvariation.json',
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover)
                  : FadeInImage(
                      placeholder: AssetImage(
                          'assets/lottie/animation_500_kicn7t6y.gif'),
                      image: NetworkImage(producto.fotoUrl),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              ListTile(
                title: Text('${producto.titulo} - ${producto.valor}'),
                subtitle: Text(producto.id),
                onTap: () => Navigator.pushNamed(context, 'producto',
                        arguments: producto)
                    .then((value) {
                  setState(() {});
                }),
              ),
            ],
          ),
        ));

    /*ListTile(
        title: Text('${producto.titulo} - ${producto.valor}'),
        subtitle: Text(producto.id),
        onTap: () =>
            Navigator.pushNamed(context, 'producto', arguments: producto)
                .then((value) {
          setState(() {});
        }),
      ),*/
  }

  _creaBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'producto').then((value) {
        setState(() {});
      }),
    );
  }
}
