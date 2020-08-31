import 'package:flutter/material.dart';
import 'package:movie_app/src/provider/peliculas_provider.dart';
import 'package:movie_app/src/widgets/list_horizontal.dart';
import 'package:movie_app/src/widgets/lista_populares.dart';

class HomePage extends StatelessWidget {
  final PeliculasProvider peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondo(context),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  _titulos(context),
                  _tituloRecientes(context),
                  SizedBox(
                    height: 26.0,
                  ),
                  _listaRecientes(context),
                  _tituloPopulares(context),
                  _listaPopulares(context)
                ],
              ),
            ),
          )
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

  Widget _titulos(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Buscar',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontFamily: 'Averta Standard',
                  fontWeight: FontWeight.normal,
                  letterSpacing: -0.5),
            ),
            // _textField(context),
            SizedBox(
              height: 16.0,
            ),
            _searchField(context)
          ],
        ),
      ),
    );
  }

  Widget _searchField(BuildContext context) {
    final search = Container(
      width: double.infinity,
      height: 34,
      child: Text(
        'Peliculas, Actores, Directores...',
        style: TextStyle(
            color: Color.fromRGBO(93, 93, 108, 1),
            fontSize: 21.0,
            letterSpacing: -0.5),
      ),
      decoration: BoxDecoration(
          // color: Colors.white,
          border: Border(
              bottom:
                  BorderSide(color: Color.fromRGBO(93, 93, 108, 1), width: 1),
              top: BorderSide.none,
              right: BorderSide.none,
              left: BorderSide.none)),
    );

    return Hero(
      tag: 'searchField',
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          child: search,
          onTap: () {
            Navigator.pushNamed(context, 'search');
          },
        ),
      ),
    );
  }

  Widget _tituloRecientes(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            'Recientes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontFamily: 'Averta Standard',
              fontWeight: FontWeight.normal,
              letterSpacing: -0.5,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'verMas', arguments: 'Ver todas las recientes');
            },
            child: Text(
              'VER TODAS',
              style: TextStyle(
                color: Color.fromRGBO(155, 161, 178, 1),
                fontSize: 10.0,
                fontFamily: 'Averta Standard',
                fontWeight: FontWeight.normal,
                letterSpacing: -0.5,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _listaRecientes(BuildContext context) {
    return FutureBuilder(
        future: peliculasProvider.getRecientes(),
        builder: (BuildContext context, AsyncSnapshot data) {
          if (data.hasData) {
            return ListaHorizontal(peliculas: data.data);
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }

  Widget _tituloPopulares(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            'Populares',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontFamily: 'Averta Standard',
              fontWeight: FontWeight.normal,
              letterSpacing: -0.5,
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, 'verMas', arguments: 'Ver todas las populares');
            },
            child: Text(
              'VER TODAS',
              style: TextStyle(
                color: Color.fromRGBO(155, 161, 178, 1),
                fontSize: 10.0,
                fontFamily: 'Averta Standard',
                fontWeight: FontWeight.normal,
                letterSpacing: -0.5,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _listaPopulares(BuildContext context) {
    return FutureBuilder(
      future: peliculasProvider.getPopulares(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListaPopulares(peliculas: snapshot.data);
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
