import 'package:travel_app_ca_riverpod_hive/features/trip/domain/entities/trip_entity.dart';

import '../repositories/trip_repository.dart';

class AddTrip {
  final TripRepository tripRepository;

  AddTrip(this.tripRepository);

  Future<void> call(TripEntity tripEntity) {
    return tripRepository.addTrip(tripEntity);
  }
}
