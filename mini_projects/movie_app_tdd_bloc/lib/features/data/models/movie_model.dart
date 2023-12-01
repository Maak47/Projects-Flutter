import 'package:movie_app_tdd_bloc/features/domain/entities/movie_entity.dart';

class MovieModel {
  final String title;
  final int id;
  final String overview;
  final String posterPath;

  MovieModel(
      {required this.title,
      required this.id,
      required this.overview,
      required this.posterPath});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        title: json['title'],
        id: json['id'],
        overview: json['overview'],
        posterPath: json['poster_path']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'overview': overview,
      'poster_path': posterPath,
    };
  }

  //Convert MovieModel toEntity

  MovieEntity toEntity() {
    return MovieEntity(
      title: title,
      id: id,
      overview: overview,
      posterPath: posterPath,
    );
  }
}
