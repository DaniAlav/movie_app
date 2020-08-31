import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/src/provider/peliculas_provider.dart';
import 'package:movie_app/src/widgets/lista_ver_mas.dart';

class VerMasPage extends StatelessWidget {
  final PeliculasProvider peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    final String texto = ModalRoute.of(context).settings.arguments;
    peliculasProvider.getRecientes();
    peliculasProvider.getPopulares();
    return Scaffold(
      body: Stack(
        children: [
          _fondo(context),
          SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 26.0,
                ),
                _titulo(texto),
                SizedBox(
                  height: 18.0,
                ),
                _listaRecientes(texto),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget _fondo(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromRGBO(28, 28, 38, 1));
  }

  Widget _titulo(String texto) {
    return Text(
      texto,
      style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontFamily: 'Averta Standard',
          fontWeight: FontWeight.normal,
          letterSpacing: -0.5),
    );
  }

  Widget _listaRecientes(String texto) {
    if (texto == 'Ver todas las populares') {
      return Expanded(
          child: StreamBuilder(
              stream: peliculasProvider.populares2Stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListaRecientesMas(
                      peliculas: snapshot.data,
                      siguiente: peliculasProvider.getPopulares);
                } else {
                  return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: SpinKitChasingDots(
                          color: Colors.white,
                        ),
                      ));
                }
              }));
    } else {
      return Expanded(
          child: StreamBuilder(
              stream: peliculasProvider.popularesStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListaRecientesMas(
                      peliculas: snapshot.data,
                      siguiente: peliculasProvider.getRecientes);
                } else {
                  return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: SpinKitChasingDots(
                          color: Colors.white,
                        ),
                      ));
                }
              }));
    }
  }
}
