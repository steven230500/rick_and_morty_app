import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/data/repositories/location_repository_impl.dart';
import 'package:rick_and_morty_app/src/data/services/api.dart';
import 'package:rick_and_morty_app/src/domain/repositories/location_repository.dart';
import 'package:rick_and_morty_app/src/presentation/notifiers/location_notifier.dart';
import 'package:rick_and_morty_app/src/presentation/states/location_state.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return LocationRepositoryImpl(apiService);
});

final locationProvider = StateNotifierProvider<LocationNotifier, LocationState>((ref) {
  final locationRepository = ref.watch(locationRepositoryProvider);
  return LocationNotifier(locationRepository);
});
