import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app_ca_riverpod_hive/features/trip/data/datasources/trip_local_data_source.dart';
import 'package:travel_app_ca_riverpod_hive/features/trip/data/repositories/trip_repository_impl.dart';
import 'package:travel_app_ca_riverpod_hive/features/trip/domain/entities/trip_entity.dart';
import 'package:travel_app_ca_riverpod_hive/features/trip/domain/repositories/trip_repository.dart';
import 'package:travel_app_ca_riverpod_hive/features/trip/domain/usecases/delete_trip.dart';
import 'package:travel_app_ca_riverpod_hive/features/trip/domain/usecases/get_trips.dart';
import '../../data/models/trip_model.dart';
import '../../domain/usecases/add_trip.dart';

final tripLocalDataSourceProvider = Provider<TripLocalDataSource>((ref) {
  final Box<TripModel> tripBox = Hive.box('trips');
  return TripLocalDataSource(tripBox);
});

final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final localDataSource = ref.read(tripLocalDataSourceProvider);
  return TripRepositoryImpl(localDataSource);
});

final getTripsProvider = Provider<GetTrips>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return GetTrips(repository);
});

final addTripProvider = Provider<AddTrip>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return AddTrip(repository);
});

final deleteTripProvider = Provider<DeleteTrip>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return DeleteTrip(repository);
});

// This provider will manage fetching trips from the repository.
final tripListNotifierProvider =
    StateNotifierProvider<TripListNotifier, List<TripEntity>>((ref) {
  final getTrips = ref.read(getTripsProvider);
  final addTrip = ref.read(addTripProvider);
  final deleteTrip = ref.read(deleteTripProvider);

  return TripListNotifier(getTrips, addTrip, deleteTrip);
});

class TripListNotifier extends StateNotifier<List<TripEntity>> {
  final GetTrips _getTrips;
  final AddTrip _addTrip;
  final DeleteTrip _deleteTrip;

  TripListNotifier(this._getTrips, this._addTrip, this._deleteTrip) : super([]);

  // Load trips from the repository and update the state.
  Future<void> loadTrips() async {
    final tripsOrFailure = await _getTrips();
    tripsOrFailure.fold((error) => state = [], (trips) => state = trips);
  }

  Future<void> addNewTrip(TripEntity tripEntity) async {
    await _addTrip(tripEntity);
    //state = [...state, trip];
  }

  Future<void> removeTrip(int tripId) async {
    await _deleteTrip(tripId);
  }
}
