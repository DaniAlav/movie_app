import 'package:flutter/material.dart';
import 'package:movie_app/src/models/pelicula_model.dart';
import 'package:movie_app/src/pages/detalle_pelicula.dart';

class ListaHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;

  ListaHorizontal({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: _size.height * 0.34,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) => _tarjeta(context, peliculas[i], _size),

        itemCount: peliculas.length,
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula, Size size) {
    pelicula.uniqueId = '${pelicula.id}--horizontal';

    final tarjetaPelicula = Container(
        width: size.width * 0.3,
        margin: EdgeInsets.only(right: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/poster-placeholder.png'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                width: size.width * 0.4,
                height: size.height * 0.25,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                pelicula.title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontFamily: 'Averta Standard',
                  fontWeight: FontWeight.normal,
                  letterSpacing: -0.5,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            )
          ],
        ));

    return Hero(
      tag: pelicula.uniqueId,
      child: GestureDetector(
        child: tarjetaPelicula,
        onTap: () {
          // Navigator.pushNamed(context, 'detalle', arguments: pelicula);
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
      ),
    );
  }
}
