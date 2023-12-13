import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final String name;
  final int id;
  final double latitude;
  final double longitude;

  Location(
      {required this.name,
      required this.id,
      required this.latitude,
      required this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
