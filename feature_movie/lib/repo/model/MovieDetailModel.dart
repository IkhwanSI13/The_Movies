import 'dart:convert';

MovieDetail movieDetailModelFromJson(String str) =>
    MovieDetail.fromJson(json.decode(str));

String movieDetailModelToJson(MovieDetail data) => json.encode(data.toJson());

class MovieDetail {
  MovieDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.tagline,
    required this.title,
    required this.voteAverage,
  });

  String backdropPath;
  List<Genre> genres;
  int id;
  String overview;
  String posterPath;
  String tagline;
  String title;
  double voteAverage;

  factory MovieDetail.fromJson(Map<String, dynamic> json) => MovieDetail(
        backdropPath: json["backdrop_path"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        id: json["id"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        tagline: json["tagline"],
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "overview": overview,
        "poster_path": posterPath,
        "tagline": tagline,
        "title": title,
        "vote_average": voteAverage,
      };
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
