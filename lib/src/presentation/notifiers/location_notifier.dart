import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/domain/repositories/location_repository.dart';
import 'package:rick_and_morty_app/src/presentation/states/location_state.dart';

class LocationNotifier extends StateNotifier<LocationState> {
  final LocationRepository locationRepository;

  LocationNotifier(this.locationRepository) : super(LocationState.initial()) {
    fetchLocations();
  }

  fetchLocations({int page = 1}) async {
    if (page == 1) {
      state = LocationState.loading();
    } else {
      state = LocationState.loaded(state.locations!, page: state.currentPage, isLoadingMore: true);
    }

    final result = await locationRepository.getAllLocations(page: page);

    result.fold(
      (exception) {
        if (exception.toString() == 'No more pages') {
          final currentLocations = state.locations ?? [];
          state = LocationState.loaded(currentLocations,
              page: state.currentPage, isLoadingMore: false, hasMorePages: false);
        } else {
          state = LocationState.error(exception.toString());
        }
      },
      (locations) {
        final currentLocations = state.locations ?? [];
        final updatedLocations = currentLocations + locations;
        state = LocationState.loaded(updatedLocations,
            page: state.currentPage + 1, isLoadingMore: false, hasMorePages: true);
      },
    );
  }
}
