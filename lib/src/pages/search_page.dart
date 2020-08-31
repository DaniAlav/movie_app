import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/src/models/pelicula_model.dart';
import 'package:movie_app/src/provider/peliculas_provider.dart';

import 'detalle_pelicula.dart';

class ShowSearch extends StatefulWidget {
  @override
  _ShowSearchState createState() => _ShowSearchState();
}

class _ShowSearchState extends State<ShowSearch> {
  final PeliculasProvider peliculasProvider = new PeliculasProvider();
  
  TextEditingController _editingController = new TextEditingController();
  String query = '';

  @override
  void initState() {
    super.initState();
    
    _editingController.addListener(() {
      setState(() {
        query = _editingController.text;
  
      });
    });
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _fondo(context),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 16.0,
                  ),
                  _textField(context),
                  SizedBox(
                    height: 12.0,
                  ),
                  Expanded(child: listaBusqueda()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listaBusqueda() {
    if (query.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: 0.4,
            child: Image(
              image: AssetImage('assets/img/empty.png'),
              width: 100.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            'Escribe algo para empezar a buscar',
            style: TextStyle(
              color: Colors.white38,
              fontSize: 14.0,
              fontFamily: 'Averta Standard',
              fontWeight: FontWeight.normal,
              letterSpacing: -0.5,
            ),
          )
        ],
      );
    } else {
      return FutureBuilder(
          future: peliculasProvider.buscarPelicula(query),
          builder:
              (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
            final peliculas = snapshot.data;
            if (snapshot.hasData) {
              return Container(
                width: double.infinity,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: peliculas.map((pelicula) {
                    return GestureDetector(
                      onTap: (){
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
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: FadeInImage(
                          placeholder:
                              AssetImage('assets/img/poster-placeholder.png'),
                          image: NetworkImage(pelicula.getPosterImg()),
                          width: 50.0,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          pelicula.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Averta Standard',
                            fontWeight: FontWeight.normal,
                            letterSpacing: -0.5,
                          ),
                        ),
                        subtitle: Text(
                          pelicula.overview,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontFamily: 'Averta Standard',
                            fontWeight: FontWeight.normal,
                            letterSpacing: -0.5,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            } else {
              return Center(
                child: SpinKitChasingDots(
                  color: Colors.white,
                ),
              );
            }
          });
    }
  }

  Widget _fondo(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromRGBO(28, 28, 38, 1));
  }

  Widget _textField(BuildContext context) {
    return Hero(
      tag: 'searchField',
      child: Material(
        color: Colors.transparent,
        child: TextField(
          controller: _editingController,
          style: TextStyle(
              color: Colors.white, fontSize: 21.0, letterSpacing: -0.5),
          cursorColor: Color.fromRGBO(93, 93, 108, 1),
          focusNode: FocusNode(canRequestFocus: false),
          decoration: new InputDecoration(
            suffix: Icon(
              Icons.search,
              size: 16.0,
              color: Color.fromRGBO(93, 93, 108, 1),
            ),
            contentPadding: EdgeInsets.only(bottom: -10.0),
            hintText: 'Peliculas, Actores, Directores...',
            hintStyle: TextStyle(
                color: Color.fromRGBO(93, 93, 108, 1),
                fontSize: 21.0,
                letterSpacing: -0.5),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(93, 93, 108, 1))),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(93, 93, 108, 1))),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(93, 93, 108, 1))),
          ),
        ),
      ),
    );
  }
}
