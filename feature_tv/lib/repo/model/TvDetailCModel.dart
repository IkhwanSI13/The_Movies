/// Full version of TvDetailModel.dart

// import 'dart:convert';
//
// TvDetail tvDetailModelFromJson(String str) =>
//     TvDetail.fromJson(json.decode(str));
//
// String tvDetailModelToJson(TvDetail data) => json.encode(data.toJson());
//
// class TvDetail {
//   TvDetail({
//     required this.adult,
//     required this.backdropPath,
//     required this.createdBy,
//     required this.episodeRunTime,
//     required this.firstAirDate,
//     required this.genres,
//     required this.homepage,
//     required this.id,
//     required this.inProduction,
//     required this.languages,
//     required this.lastAirDate,
//     required this.lastEpisodeToAir,
//     required this.name,
//     required this.nextEpisodeToAir,
//     required this.networks,
//     required this.numberOfEpisodes,
//     required this.numberOfSeasons,
//     required this.originCountry,
//     required this.originalLanguage,
//     required this.originalName,
//     required this.overview,
//     required this.popularity,
//     required this.posterPath,
//     required this.productionCompanies,
//     required this.productionCountries,
//     required this.seasons,
//     required this.spokenLanguages,
//     required this.status,
//     required this.tagline,
//     required this.type,
//     required this.voteAverage,
//     required this.voteCount,
//   });
//
//   bool adult;
//   String backdropPath;
//   List<CreatedBy> createdBy;
//   List<int> episodeRunTime;
//   DateTime firstAirDate;
//   List<Genre> genres;
//   String homepage;
//   int id;
//   bool inProduction;
//   List<String> languages;
//   DateTime lastAirDate;
//   TEpisodeToAir lastEpisodeToAir;
//   String name;
//   TEpisodeToAir nextEpisodeToAir;
//   List<Network> networks;
//   int numberOfEpisodes;
//   int numberOfSeasons;
//   List<String> originCountry;
//   String originalLanguage;
//   String originalName;
//   String overview;
//   double popularity;
//   String posterPath;
//   List<Network> productionCompanies;
//   List<ProductionCountry> productionCountries;
//   List<Season> seasons;
//   List<SpokenLanguage> spokenLanguages;
//   String status;
//   String tagline;
//   String type;
//   double voteAverage;
//   int voteCount;
//
//   factory TvDetail.fromJson(Map<String, dynamic> json) => TvDetail(
//     adult: json["adult"],
//     backdropPath: json["backdrop_path"],
//     createdBy: List<CreatedBy>.from(
//         json["created_by"].map((x) => CreatedBy.fromJson(x))),
//     episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
//     firstAirDate: DateTime.parse(json["first_air_date"]),
//     genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
//     homepage: json["homepage"],
//     id: json["id"],
//     inProduction: json["in_production"],
//     languages: List<String>.from(json["languages"].map((x) => x)),
//     lastAirDate: DateTime.parse(json["last_air_date"]),
//     lastEpisodeToAir: TEpisodeToAir.fromJson(json["last_episode_to_air"]),
//     name: json["name"],
//     nextEpisodeToAir: TEpisodeToAir.fromJson(json["next_episode_to_air"]),
//     networks: List<Network>.from(
//         json["networks"].map((x) => Network.fromJson(x))),
//     numberOfEpisodes: json["number_of_episodes"],
//     numberOfSeasons: json["number_of_seasons"],
//     originCountry: List<String>.from(json["origin_country"].map((x) => x)),
//     originalLanguage: json["original_language"],
//     originalName: json["original_name"],
//     overview: json["overview"],
//     popularity: json["popularity"].toDouble(),
//     posterPath: json["poster_path"],
//     productionCompanies: List<Network>.from(
//         json["production_companies"].map((x) => Network.fromJson(x))),
//     productionCountries: List<ProductionCountry>.from(
//         json["production_countries"]
//             .map((x) => ProductionCountry.fromJson(x))),
//     seasons:
//     List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
//     spokenLanguages: List<SpokenLanguage>.from(
//         json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
//     status: json["status"],
//     tagline: json["tagline"],
//     type: json["type"],
//     voteAverage: json["vote_average"].toDouble(),
//     voteCount: json["vote_count"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "adult": adult,
//     "backdrop_path": backdropPath,
//     "created_by": List<dynamic>.from(createdBy.map((x) => x.toJson())),
//     "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
//     "first_air_date":
//     "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
//     "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
//     "homepage": homepage,
//     "id": id,
//     "in_production": inProduction,
//     "languages": List<dynamic>.from(languages.map((x) => x)),
//     "last_air_date":
//     "${lastAirDate.year.toString().padLeft(4, '0')}-${lastAirDate.month.toString().padLeft(2, '0')}-${lastAirDate.day.toString().padLeft(2, '0')}",
//     "last_episode_to_air": lastEpisodeToAir.toJson(),
//     "name": name,
//     "next_episode_to_air": nextEpisodeToAir.toJson(),
//     "networks": List<dynamic>.from(networks.map((x) => x.toJson())),
//     "number_of_episodes": numberOfEpisodes,
//     "number_of_seasons": numberOfSeasons,
//     "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
//     "original_language": originalLanguage,
//     "original_name": originalName,
//     "overview": overview,
//     "popularity": popularity,
//     "poster_path": posterPath,
//     "production_companies":
//     List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
//     "production_countries":
//     List<dynamic>.from(productionCountries.map((x) => x.toJson())),
//     "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
//     "spoken_languages":
//     List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
//     "status": status,
//     "tagline": tagline,
//     "type": type,
//     "vote_average": voteAverage,
//     "vote_count": voteCount,
//   };
// }
//
// class CreatedBy {
//   CreatedBy({
//     required this.id,
//     required this.creditId,
//     required this.name,
//     required this.gender,
//     required this.profilePath,
//   });
//
//   int id;
//   String creditId;
//   String name;
//   int gender;
//   String profilePath;
//
//   factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
//     id: json["id"],
//     creditId: json["credit_id"],
//     name: json["name"],
//     gender: json["gender"],
//     profilePath: json["profile_path"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "credit_id": creditId,
//     "name": name,
//     "gender": gender,
//     "profile_path": profilePath,
//   };
// }
//
// class Genre {
//   Genre({
//     required this.id,
//     required this.name,
//   });
//
//   int id;
//   String name;
//
//   factory Genre.fromJson(Map<String, dynamic> json) => Genre(
//     id: json["id"],
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//   };
// }
//
// class TEpisodeToAir {
//   TEpisodeToAir({
//     required this.airDate,
//     required this.episodeNumber,
//     required this.id,
//     required this.name,
//     required this.overview,
//     required this.productionCode,
//     required this.runtime,
//     required this.seasonNumber,
//     this.stillPath,
//     required this.voteAverage,
//     required this.voteCount,
//   });
//
//   DateTime airDate;
//   int episodeNumber;
//   int id;
//   String name;
//   String overview;
//   String productionCode;
//   int runtime;
//   int seasonNumber;
//   String? stillPath;
//   double voteAverage;
//   int voteCount;
//
//   factory TEpisodeToAir.fromJson(Map<String, dynamic> json) => TEpisodeToAir(
//     airDate: DateTime.parse(json["air_date"]),
//     episodeNumber: json["episode_number"],
//     id: json["id"],
//     name: json["name"],
//     overview: json["overview"],
//     productionCode: json["production_code"],
//     runtime: json["runtime"],
//     seasonNumber: json["season_number"],
//     stillPath: json["still_path"],
//     voteAverage: json["vote_average"].toDouble(),
//     voteCount: json["vote_count"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "air_date":
//     "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
//     "episode_number": episodeNumber,
//     "id": id,
//     "name": name,
//     "overview": overview,
//     "production_code": productionCode,
//     "runtime": runtime,
//     "season_number": seasonNumber,
//     "still_path": stillPath,
//     "vote_average": voteAverage,
//     "vote_count": voteCount,
//   };
// }
//
// class Network {
//   Network({
//     required this.id,
//     required this.name,
//     this.logoPath,
//     required this.originCountry,
//   });
//
//   int id;
//   String name;
//   String? logoPath;
//   String originCountry;
//
//   factory Network.fromJson(Map<String, dynamic> json) => Network(
//     id: json["id"],
//     name: json["name"],
//     logoPath: json["logo_path"],
//     originCountry: json["origin_country"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "logo_path": logoPath,
//     "origin_country": originCountry,
//   };
// }
//
// class ProductionCountry {
//   ProductionCountry({
//     required this.iso31661,
//     required this.name,
//   });
//
//   String iso31661;
//   String name;
//
//   factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
//       ProductionCountry(
//         iso31661: json["iso_3166_1"],
//         name: json["name"],
//       );
//
//   Map<String, dynamic> toJson() => {
//     "iso_3166_1": iso31661,
//     "name": name,
//   };
// }
//
// class Season {
//   Season({
//     required this.airDate,
//     required this.episodeCount,
//     required this.id,
//     required this.name,
//     required this.overview,
//     required this.posterPath,
//     required this.seasonNumber,
//     this.networks,
//   });
//
//   DateTime airDate;
//   int episodeCount;
//   int id;
//   String name;
//   String overview;
//   String posterPath;
//   int seasonNumber;
//   List<Network>? networks;
//
//   factory Season.fromJson(Map<String, dynamic> json) => Season(
//     airDate: DateTime.parse(json["air_date"]),
//     episodeCount: json["episode_count"],
//     id: json["id"],
//     name: json["name"],
//     overview: json["overview"],
//     posterPath: json["poster_path"],
//     seasonNumber: json["season_number"],
//     networks: json["networks"] == null
//         ? null
//         : List<Network>.from(
//         json["networks"].map((x) => Network.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "air_date":
//     "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
//     "episode_count": episodeCount,
//     "id": id,
//     "name": name,
//     "overview": overview,
//     "poster_path": posterPath,
//     "season_number": seasonNumber,
//     "networks": networks == null
//         ? null
//         : List<dynamic>.from(networks!.map((x) => x.toJson())),
//   };
// }
//
// class SpokenLanguage {
//   SpokenLanguage({
//     required this.englishName,
//     required this.iso6391,
//     required this.name,
//   });
//
//   String englishName;
//   String iso6391;
//   String name;
//
//   factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
//     englishName: json["english_name"],
//     iso6391: json["iso_639_1"],
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "english_name": englishName,
//     "iso_639_1": iso6391,
//     "name": name,
//   };
// }
