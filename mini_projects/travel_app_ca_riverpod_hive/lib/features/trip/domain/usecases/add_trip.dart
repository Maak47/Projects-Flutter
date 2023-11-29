import 'package:travel_app_ca_riverpod_hive/features/trip/domain/entities/trip_entity.dart';

import '../repositories/trip_repository.dart';

class AddTrip {
  final TripRepository repository;

  AddTrip(this.repository);

  Future<void> call(TripEntity tripEntity) {
    return repository.addTrip(tripEntity);
  }
}
