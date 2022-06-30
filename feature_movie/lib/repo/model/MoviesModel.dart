import 'dart:convert';

MoviesModel moviesModelFromJson(String str) =>
    MoviesModel.fromJson(json.decode(str));

String moviesModelToJson(MoviesModel data) => json.encode(data.toJson());

class MoviesModel {
  MoviesModel({
    required this.results,
  });

  List<Movie> results;

  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Movie {
  Movie({
    required this.backdropPath,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
  });

  String backdropPath;
  int id;
  String overview;
  String posterPath;
  String title;
  double voteAverage;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "id": id,
        "overview": overview,
        "poster_path": posterPath,
        "title": title,
        "vote_average": voteAverage,
      };
}
