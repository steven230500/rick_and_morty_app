import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/presentation/providers/location_provider.dart';
import 'package:rick_and_morty_app/src/presentation/states/location_state.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/location_card.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(locationProvider);
    ref.listen<LocationState>(locationProvider, (previousState, currentState) {
      currentState.status == LocationStateStatus.error
          ? ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(currentState.errorMessage ?? 'An unknown error occurred'),
                duration: const Duration(seconds: 2),
              ),
            )
          : null;
    });
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _buildBody(context, ref, state),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, LocationState state) {
    switch (state.status) {
      case LocationStateStatus.initial:
        return Container();

      case LocationStateStatus.loading:
        return const Center(child: CircularProgressIndicator());

      case LocationStateStatus.loaded:
        if (state.locations == null || (state.locations!.isEmpty && state.currentPage == 1)) {
          return const Center(child: Text('No locations found'));
        } else {
          return Stack(
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                      !state.isLoadingMore &&
                      state.hasMorePages) {
                    ref.read(locationProvider.notifier).fetchLocations(page: state.currentPage + 1);
                    return true;
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: state.locations!.length,
                  itemBuilder: (context, index) {
                    final location = state.locations![index];
                    return LocationCard(location: location);
                  },
                ),
              ),
              if (state.isLoadingMore) const Center(child: CircularProgressIndicator())
            ],
          );
        }

      case LocationStateStatus.error:
        return Center(child: Text(state.errorMessage ?? 'An unknown error occurred'));

      default:
        return Container();
    }
  }
}
