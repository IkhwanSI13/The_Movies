import 'dart:convert';

TvsModel tvsModelFromJson(String str) => TvsModel.fromJson(json.decode(str));

String tvsModelToJson(TvsModel data) => json.encode(data.toJson());

class TvsModel {
  TvsModel({
    required this.results,
  });

  List<Tv> results;

  factory TvsModel.fromJson(Map<String, dynamic> json) => TvsModel(
        results: List<Tv>.from(json["results"].map((x) => Tv.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Tv {
  Tv(
      {this.backdropPath,
      required this.id,
      required this.name,
      required this.overview,
      required this.posterPath,
      required this.voteAverage});

  String? backdropPath;
  int id;
  String name;
  String overview;
  String posterPath;
  double voteAverage;

  factory Tv.fromJson(Map<String, dynamic> json) => Tv(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "vote_average": voteAverage,
      };
}
