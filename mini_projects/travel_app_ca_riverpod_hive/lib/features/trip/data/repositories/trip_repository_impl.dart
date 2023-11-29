import 'package:dartz/dartz.dart';
import 'package:travel_app_ca_riverpod_hive/core/error/failures.dart';
import 'package:travel_app_ca_riverpod_hive/features/trip/data/datasources/trip_local_data_source.dart';
import 'package:travel_app_ca_riverpod_hive/features/trip/domain/entities/trip_entity.dart';
import 'package:travel_app_ca_riverpod_hive/features/trip/domain/repositories/trip_repository.dart';

import '../models/trip_model.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDataSource localDataSource;

  TripRepositoryImpl(this.localDataSource);

  @override
  Future<void> addTrip(TripEntity tripEntity) async {
    final tripModel = TripModel.fromEntity(tripEntity);
    localDataSource.addTrip(tripModel);
  }

  @override
  Future<void> deleteTrip(int index) async {
    localDataSource.deleteTrip(index);
  }

  @override
  Future<Either<Failure, List<TripEntity>>> getTrips() async {
    try {
      final tripModels = localDataSource.getTrips();
      List<TripEntity> res = tripModels.map((e) => e.toEntity()).toList();
      return Right(res);
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }
}
