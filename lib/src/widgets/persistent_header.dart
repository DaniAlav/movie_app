import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:movie_app/src/models/pelicula_model.dart';
import 'package:movie_app/src/provider/peliculas_provider.dart';
import 'package:movie_app/src/utils/cargar_pagina.dart' as utils;
import 'package:movie_app/src/widgets/chip_generos.dart';

class HeaderDetalle extends SliverPersistentHeaderDelegate {
  Pelicula pelicula;
  double maxExtent;
  double minExtent;

  HeaderDetalle(
      {@required this.maxExtent,
      @required this.minExtent,
      @required this.pelicula});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image(
          image: NetworkImage(pelicula.getPosterImg()),
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                Colors.transparent,
                Color.fromRGBO(29, 29, 39, 0.5),
                Color.fromRGBO(29, 29, 39, 1)
              ],
                  stops: [
                0.1,
                0.25,
                1.0
              ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.mirror)),
        ),
        Positioned(
            left: 0.0,
            top: 8.0,
            child: SafeArea(
                child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ))),
        Positioned(
            right: 0.0,
            top: 8.0,
            child: SafeArea(
                child: Row(
              children: [
                IconButton(
                    padding: EdgeInsets.all(0.0),
                    icon: Icon(
                      Icons.save_alt,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    onPressed: () {}),
                IconButton(
                    padding: EdgeInsets.all(0.0),
                    icon: Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    onPressed: () {
                      utils.abrirUrl(context, pelicula);
                    })
              ],
            ))),
        Positioned(
          bottom: 5.0,
          left: 15.0,
          right: 15.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      pelicula.title,
                      style: TextStyle(
                          // backgroundColor: Colors.red,
                          color: Colors.white,
                          fontSize: 32.0,
                          fontFamily: 'Averta Standard',
                          fontWeight: FontWeight.normal,
                          letterSpacing: -0.5,
                          height: 1.25),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    '(${pelicula.getDate(pelicula.releaseDate)})',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontFamily: 'Averta Standard',
                        fontWeight: FontWeight.normal,
                        letterSpacing: -0.5,
                        height: 2.8),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(
                height: 12.0,
              ),
              _crearCategorias()
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Widget _crearCategorias() {
    final peliculasProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliculasProvider.getPeliculaDetalle(pelicula.id),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        final generosList = snapshot.data;
        if (snapshot.hasData) {
          return ChipGenero(listaGeneros: generosList);
        } else {
          return Text(
            'Cargando...',
            style: TextStyle(
            color: Color.fromRGBO(160, 166, 183, 1),
            fontSize: 11.0,
            fontFamily: 'Averta Standard',
            fontWeight: FontWeight.normal,
            letterSpacing: -0.5,
          ),
          );
        }
      },
    );
  }

  
}
