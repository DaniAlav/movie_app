
// class PeliculaDetalle {
//   bool adult;
//   String backdropPath;
//   BelongsToCollection belongsToCollection;
//   int budget;
//   List<Genre> genres;
//   String homepage;
//   int id;
//   String imdbId;
//   String originalLanguage;
//   String originalTitle;
//   String overview;
//   double popularity;
//   String posterPath;
//   List<dynamic> productionCompanies;
//   String releaseDate;
//   int revenue;
//   int runtime;
//   String status;
//   String tagline;
//   String title;
//   bool video;
//   double voteAverage;
//   int voteCount;

//   PeliculaDetalle({
//     this.adult,
//     this.backdropPath,
//     this.belongsToCollection,
//     this.budget,
//     this.genres,
//     this.homepage,
//     this.id,
//     this.imdbId,
//     this.originalLanguage,
//     this.originalTitle,
//     this.overview,
//     this.popularity,
//     this.posterPath,
//     this.productionCompanies,
//     this.releaseDate,
//     this.revenue,
//     this.runtime,
//     this.status,
//     this.tagline,
//     this.title,
//     this.video,
//     this.voteAverage,
//     this.voteCount,
//   });

//   PeliculaDetalle.fromJsonMap(Map<String, dynamic> json) {
//     adult = json['adult'];
//     backdropPath = json['backdropPath'];
//     belongsToCollection = json['belongsToCollection'];
//     budget = json['budget'];
//     genres = json['genres'];
//     homepage = json['homepage'];
//     id = json['id'];
//     imdbId = json['imdbId'];
//     originalLanguage = json['originalLanguage'];
//     originalTitle = json['originalTitle'];
//     overview = json['overview'];
//     popularity = json['popularity'];
//     posterPath = json['posterPath'];
//     productionCompanies = json['productionCompanies'];
//     productionCountries = json['productionCountries'];
//     releaseDate = json['releaseDate'];
//     revenue = json['revenue'];
//     runtime = json['runtime'];
//     spokenLanguages = json['spokenLanguages'];
//     status = json['status'];
//     tagline = json['tagline'];
//     title = json['title'];
//     video = json['video'];
//     voteAverage = json['voteAverage'];
//     voteCount = json['voteCount'];
//   }
// }

// class BelongsToCollection {
//   int id;
//   String name;
//   String posterPath;
//   dynamic backdropPath;

//   BelongsToCollection({
//     this.id,
//     this.name,
//     this.posterPath,
//     this.backdropPath,
//   });
// }

class Genres {
  List<Genre> listGenres = new List();

  Genres.fromJsonList(List<dynamic> jsonList){
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final genre = Genre.fromJsonMap(item);
      listGenres.add(genre);
    });
  }
}

class Genre {
  int id;
  String name;

  Genre({
    this.id,
    this.name,
  });

  Genre.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

