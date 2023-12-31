import 'package:travel_app_ca_riverpod_hive/features/trip/domain/entities/trip_entity.dart';
import 'package:travel_app_ca_riverpod_hive/features/trip/domain/repositories/trip_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class GetTrips {
  final TripRepository repository;

  GetTrips(this.repository);

  Future<Either<Failure, List<TripEntity>>> call() {
    return repository.getTrips();
  }
}
