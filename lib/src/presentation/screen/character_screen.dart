import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/presentation/providers/character_provider.dart';
import 'package:rick_and_morty_app/src/presentation/states/character_state.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/character_card.dart';

class CharacterScreen extends ConsumerWidget {
  const CharacterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(characterProvider);
    final provider = ref.read(characterProvider.notifier);
    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          provider.fetchCharacters(state.currentPage + 1);
        }
      }
    });

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _buildBody(context, state, scrollController),
    );
  }

  Widget _buildBody(BuildContext context, CharacterState state, ScrollController scrollController) {
    switch (state.status) {
      case CharacterStateStatus.initial:
        return Container();

      case CharacterStateStatus.loading:
        return const Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
        );

      case CharacterStateStatus.loaded:
        if (state.characters != null) {
          return Stack(
            children: [
              GridView.builder(
                controller: scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: state.characters!.length,
                itemBuilder: (context, index) {
                  final character = state.characters![index];
                  return CharacterCard(character: character);
                },
              ),
              if (state.isLoadingMore)
                const Positioned.fill(
                  child: Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          );
        } else {
          return const Center(child: Text('No characters found'));
        }

      case CharacterStateStatus.error:
        return Center(child: Text(state.errorMessage ?? 'An unknown error occurred'));

      default:
        return Container();
    }
  }
}
