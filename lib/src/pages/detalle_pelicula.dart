import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/src/models/pelicula_model.dart';
import 'package:movie_app/src/provider/peliculas_provider.dart';
import 'package:movie_app/src/widgets/lista_actores.dart';
import 'package:movie_app/src/widgets/persistent_header.dart';

class DetallePelicula extends StatelessWidget {
  final Pelicula pelicula;


  DetallePelicula({@required this.pelicula});

  @override
  Widget build(BuildContext context) {
    // final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    final _size = MediaQuery.of(context).size.height;
    // print(pelicula.getGeneros());
    return Scaffold(
      backgroundColor: Color.fromRGBO(29, 29, 39, 1),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: HeaderDetalle(
                minExtent: _size * 0.4,
                maxExtent: _size * 0.65,
                pelicula: pelicula),
          ),
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24.0,
                  ),
                  Divider(
                    color: Color.fromRGBO(47, 47, 58, 1),
                    thickness: 1,
                    height: 15,
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  _crearDetalles(pelicula),
                  SizedBox(
                    height: 18.0,
                  ),
                  Divider(
                    color: Color.fromRGBO(47, 47, 58, 1),
                    thickness: 1,
                    height: 15,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  _crearTitulo(),
                  SizedBox(
                    height: 20.0,
                  ),
                  _crearDescripcion(pelicula),
                  SizedBox(
                    height: 16.0,
                  ),
                  Divider(
                    color: Color.fromRGBO(47, 47, 58, 1),
                    thickness: 1,
                    height: 15,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _crearActores(pelicula),
                ],
              ),
            )
          ]))
        ],
      ),
    );
  }

  Widget _crearDescripcion(Pelicula pelicula) {
    return Text(
      pelicula.overview,
      style: TextStyle(
          color: Color.fromRGBO(134, 139, 155, 1),
          fontSize: 15.0,
          fontFamily: 'Averta Standard',
          fontWeight: FontWeight.normal,
          height: 1.3),
      textAlign: TextAlign.justify,
    );
  }

  Widget _crearDetalles(Pelicula pelicula) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _crearPuntuacion(pelicula),
        _crearAverage(pelicula),
        _crearBotonValorar(pelicula)
      ],
    );
  }

  Widget _crearPuntuacion(Pelicula pelicula) {
    return Column(
      children: [
        Text(
          pelicula.voteCount.toString(),
          style: TextStyle(
            color: Color.fromRGBO(113, 193, 128, 1),
            fontSize: 26.0,
            fontFamily: 'Averta Standard',
            fontWeight: FontWeight.normal,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(
          height: 6.0,
        ),
        Text(
          'Votos',
          style: TextStyle(
            color: Color.fromRGBO(233, 233, 234, 1),
            fontSize: 18.0,
            fontFamily: 'Averta Standard',
            fontWeight: FontWeight.normal,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _crearTitulo() {
    return Text(
      'Sipnosis',
      style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontFamily: 'Averta Standard',
          fontWeight: FontWeight.normal,
          letterSpacing: -0.5,
          height: 1),
    );
  }

  Widget _crearAverage(Pelicula pelicula) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset('assets/img/icons8_star.svg'),
        // Icon(
        //   Icons.star,
        //   color: Color.fromRGBO(249, 88, 98, 1),
        //   size: 26.0,
        // ),
        SizedBox(
          height: 6.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              pelicula.voteAverage.toString(),
              style: TextStyle(
                color: Color.fromRGBO(233, 233, 234, 1),
                fontSize: 18.0,
                fontFamily: 'Averta Standard',
                fontWeight: FontWeight.normal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Text(
                ' / 10',
                style: TextStyle(
                  color: Color.fromRGBO(233, 233, 234, 1),
                  fontSize: 11.0,
                  fontFamily: 'Averta Standard',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _crearBotonValorar(Pelicula pelicula) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset('assets/img/icons8_star_half_empty.svg'),
        SizedBox(
          height: 6.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Valorar',
              style: TextStyle(
                color: Color.fromRGBO(233, 233, 234, 1),
                fontSize: 18.0,
                fontFamily: 'Averta Standard',
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _crearActores(Pelicula pelicula) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actores',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontFamily: 'Averta Standard',
            fontWeight: FontWeight.normal,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        _crearCast(pelicula)
      ],
    );
  }

  Widget _crearCast(Pelicula pelicula) {
    
    final PeliculasProvider provider = new PeliculasProvider();
    return FutureBuilder(
        future: provider.getActores(pelicula.id.toString()),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListaActores(actores: snapshot.data);
          } else {
            return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: SpinKitChasingDots(
                    color: Colors.white,
                  ),
                ));
          }
        });
  }
}
