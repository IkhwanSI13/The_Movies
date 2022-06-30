import 'dart:convert';

TvDetail tvDetailModelFromJson(String str) =>
    TvDetail.fromJson(json.decode(str));

String tvDetailModelToJson(TvDetail data) => json.encode(data.toJson());

class TvDetail {
  TvDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.tagline,
    required this.voteAverage,
  });

  String backdropPath;
  List<Genre> genres;
  int id;
  String name;
  String overview;
  String posterPath;
  String tagline;
  double voteAverage;

  factory TvDetail.fromJson(Map<String, dynamic> json) => TvDetail(
        backdropPath: json["backdrop_path"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        tagline: json["tagline"],
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "tagline": tagline,
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
