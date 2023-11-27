import 'package:travel_app_clean_architecture/features/trip/domain/entities/trip_entity.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/repositories/trip_repository.dart';

class GetTrips {
  final TripRepository repository;

  GetTrips({required this.repository});

  Future<List<TripEntity>> call() {
    return repository.getTrips();
  }
}
