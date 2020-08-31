import 'package:flutter/material.dart';
import 'package:movie_app/src/models/pelicula_completa.dart';

class ChipGenero extends StatelessWidget {
  final List<Genre> listaGeneros;

  ChipGenero({@required this.listaGeneros});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listaGeneros.length,
        itemBuilder: (context, index) => _tarjeta(listaGeneros[index]),
        ),
    );
  }

  Widget _tarjeta(Genre genero) {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        child: Text(
          genero.name.toUpperCase(),
          style: TextStyle(
            color: Color.fromRGBO(160, 166, 183, 1),
            fontSize: 11.0,
            fontFamily: 'Averta Standard',
            fontWeight: FontWeight.normal,
            letterSpacing: -0.5,
          ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border:
              Border.all(color: Color.fromRGBO(160, 166, 183, 1), width: 1.0)),
    );
  }
}
