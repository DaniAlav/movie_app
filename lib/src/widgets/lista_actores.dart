import 'package:flutter/material.dart';
import 'package:movie_app/src/models/actores_model.dart';

class ListaActores extends StatelessWidget {
  final List<Cast> actores;

  ListaActores({@required this.actores});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      height: _size.height * 0.35,
      
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: actores.length,
          itemBuilder: (context, i) {
            return _crearTarjetaActor(actores[i], _size);
          }),
    );
  }
}

Widget _crearTarjetaActor(Cast actor, Size size) {
  final tarjetaActor = Container(
      width: size.width * 0.3,
      margin: EdgeInsets.only(right: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/poster-placeholder.png'),
              image: NetworkImage(actor.getFoto()),
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
              actor.name,
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

  return tarjetaActor;
}
