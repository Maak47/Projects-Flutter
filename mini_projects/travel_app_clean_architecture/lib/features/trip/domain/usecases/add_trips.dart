import 'package:travel_app_clean_architecture/features/trip/domain/entities/trip_entity.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/repositories/trip_repository.dart';

class AddTrips {
  final TripRepository repository;

  AddTrips({required this.repository});

  Future<void> call(TripEntity tripEntity) {
    return repository.addTrips(tripEntity);
  }
}
