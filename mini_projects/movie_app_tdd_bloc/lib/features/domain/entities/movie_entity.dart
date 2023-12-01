import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String title;
  final int id;

  final String overview;
  final String posterPath;

  MovieEntity(
      {required this.title,
      required this.id,
      required this.overview,
      required this.posterPath});

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        overview,
        posterPath,
      ];
}
