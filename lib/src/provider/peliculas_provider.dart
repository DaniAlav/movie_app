import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/src/models/actores_model.dart';
import 'package:movie_app/src/models/pelicula_completa.dart';
import 'package:movie_app/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = '442870a800080abc43498c8addc77465';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _recientesPage = 0;
  int _popularesPage = 0;

  bool _cargando = false;
  bool _cargandoPopulares = false;

  List<Pelicula> _recientes = new List();
  List<Pelicula> _popular = new List();


  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  final _populares2StreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  Function(List<Pelicula>) get populares2Sink =>
      _populares2StreamController.sink.add;

  Stream<List<Pelicula>> get populares2Stream =>
      _populares2StreamController.stream;

  void disposeStreams() {
    _popularesStreamController.close();
    _populares2StreamController.close();
  }

  Future<List<Pelicula>> _getRespuesta(Uri url) async {
    final respuesta = await http.get(url);
    final decodeData = json.decode(respuesta.body);
    final peliculas = new Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getRecientes() async {
    if (_cargando) return [];
    _cargando = true;

    _recientesPage++;

    print('cargando');
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': _recientesPage.toString()
    });

    final resp = await _getRespuesta(url);

    _recientes.addAll(resp);
    popularesSink(_recientes);

    _cargando = false;

    return resp;
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargandoPopulares) return [];
    _cargandoPopulares = true;

    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final resp = await _getRespuesta(url);
    _popular.addAll(resp);
    populares2Sink(_popular);
    _cargandoPopulares = false;
    return resp;
  }

  Future<List<Genre>> getPeliculaDetalle(int idMovie) async {
    final url = Uri.https(_url, '3/movie/$idMovie', {
      'api_key': _apiKey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final genero = new Genres.fromJsonList(decodedData['genres']);

    return genero.listGenres;
  }

  Future<List<Cast>> getActores(String movideId) async {
    final url = Uri.https(_url, '3/movie/$movideId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = new Casts.fromJsonList(decodedData['cast']);
    return cast.casts;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    return await _getRespuesta(url);
  }
}
