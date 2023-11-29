import 'package:hive/hive.dart';
import 'package:travel_app_ca_riverpod_hive/features/trip/domain/entities/trip_entity.dart';

part 'trip_model.g.dart';

@HiveType(typeId: 0)
class TripModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String location;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final List<String> photos;

  TripModel(
      {required this.title,
      required this.description,
      required this.location,
      required this.date,
      required this.photos});

  factory TripModel.fromEntity(TripEntity tripEntity) => TripModel(
      title: tripEntity.title,
      description: tripEntity.description,
      location: tripEntity.location,
      date: tripEntity.date,
      photos: tripEntity.photos);

  TripEntity toEntity() => TripEntity(
      title: title,
      description: description,
      location: location,
      date: date,
      photos: photos);
}
