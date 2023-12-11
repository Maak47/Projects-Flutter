import 'package:equatable/equatable.dart';

final class Post extends Equatable {
  final String title;
  final int id;
  final String body;

  Post({required this.title, required this.id, required this.body});

  @override
  List<Object?> get props => [id, title, body];
}
