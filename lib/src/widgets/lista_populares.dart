import 'package:flutter/material.dart';
import 'package:movie_app/src/models/pelicula_model.dart';
import 'package:movie_app/src/pages/detalle_pelicula.dart';

class ListaPopulares extends StatelessWidget {
  final List<Pelicula> peliculas;

  ListaPopulares({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: peliculas.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, i) =>
                _itemPelicula(context, peliculas[i], _size)));
  }

  Widget _itemPelicula(BuildContext context, Pelicula pelicula, Size size) {
    final item = Container(
      margin: EdgeInsets.only(bottom: 18.0),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/poster-placeholder.png'),
              width: size.width * 0.42,
              image: NetworkImage(pelicula.getPosterImg()),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, top: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pelicula.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontFamily: 'Averta Standard',
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.6,
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
                        fontSize: 15.0,
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
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.star,
                          color: Color.fromRGBO(249, 88, 98, 1),
                          size: 26.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Text(
                            pelicula.voteAverage.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontFamily: 'Averta Standard',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0,
                                height: 1.3),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Text(
                            ' / 10',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                                fontFamily: 'Averta Standard',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0,
                                height: 1.3),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text(
                      '${pelicula.voteCount.toString()} votos',
                      style: TextStyle(
                          color: Color.fromRGBO(155, 161, 178, 1),
                          fontSize: 12.0,
                          fontFamily: 'Averta Standard',
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0,
                          height: 1.3),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      child: item,
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
    );
  }
}
