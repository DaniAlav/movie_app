import 'package:flutter/material.dart';
import 'package:movie_app/src/models/pelicula_model.dart';
import 'package:movie_app/src/pages/detalle_pelicula.dart';

class ListaRecientesMas extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguiente;
  ListaRecientesMas({@required this.peliculas, @required this.siguiente});

  final _pageController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 500) {
        siguiente();
      }
    });

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      controller: _pageController,
      itemCount: peliculas.length,
      itemBuilder: (context, i) => _tarjeta(context, peliculas[i], _size),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula, Size size) {
    return GestureDetector(
      onTap: () {
         Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 300),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secAnimation,
                      Widget child) {
                    animation = CurvedAnimation(parent: animation, curve: Curves.ease);
                    return ScaleTransition(
                      alignment: Alignment.bottomRight,
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secAnimation) {
                    return DetallePelicula(
                      pelicula: pelicula,
                    );
                  }));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            margin: EdgeInsets.only(bottom: 18.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/poster-placeholder.png'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                width: size.width * 0.35,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pelicula.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontFamily: 'Averta Standard',
                      fontWeight: FontWeight.normal,
                      letterSpacing: -0.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      pelicula.getDate(pelicula.releaseDate),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                        fontFamily: 'Averta Standard',
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 14.0),
                    child: Text(
                      pelicula.overview,
                      style: TextStyle(
                          color: Color.fromRGBO(155, 161, 178, 1),
                          fontSize: 14.0,
                          fontFamily: 'Averta Standard',
                          fontWeight: FontWeight.normal,
                          letterSpacing: -0.5,
                          height: 1.3),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
