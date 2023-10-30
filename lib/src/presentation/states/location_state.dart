import 'package:rick_and_morty_app/src/data/models/location.dart';

enum LocationStateStatus { initial, loading, loaded, error }

class LocationState {
  final List<Location>? locations;
  final LocationStateStatus status;
  final String? errorMessage;
  final int currentPage;
  final bool isLoadingMore;
  final bool hasMorePages;

  LocationState({
    this.locations,
    required this.status,
    this.errorMessage,
    this.currentPage = 1,
    this.isLoadingMore = false,
    this.hasMorePages = false,
  });

  factory LocationState.initial() => LocationState(status: LocationStateStatus.initial);

  factory LocationState.loading() => LocationState(status: LocationStateStatus.loading);

  factory LocationState.loaded(List<Location> locations,
          {int page = 1, bool isLoadingMore = false, bool hasMorePages = false}) =>
      LocationState(
          status: LocationStateStatus.loaded,
          locations: locations,
          currentPage: page,
          isLoadingMore: isLoadingMore,
          hasMorePages: hasMorePages);

  factory LocationState.error(String errorMessage) =>
      LocationState(status: LocationStateStatus.error, errorMessage: errorMessage);
}
