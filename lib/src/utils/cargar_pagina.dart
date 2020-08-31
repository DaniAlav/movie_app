import 'package:flutter/material.dart';
import 'package:movie_app/src/models/pelicula_model.dart';
import 'package:url_launcher/url_launcher.dart';

abrirUrl(BuildContext context, Pelicula pelicula) async {
  if (await canLaunch(pelicula.getUrl())) {
    await launch(pelicula.getUrl());
  } else {
    throw 'No se puede abrir ${pelicula.getUrl()}';
  }
}
