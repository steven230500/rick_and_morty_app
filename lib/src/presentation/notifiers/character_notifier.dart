import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/data/models/character.dart';
import 'package:rick_and_morty_app/src/presentation/states/character_state.dart';
import 'package:rick_and_morty_app/src/domain/repositories/character_repository.dart';
import 'package:rick_and_morty_app/src/utils/db_helper.dart';

class CharacterNotifier extends StateNotifier<CharacterState> {
  final CharacterRepository characterRepository;

  final DBHelper dbHelper = DBHelper.db;
  final String userName;

  CharacterNotifier(this.characterRepository, this.userName) : super(CharacterState.initial()) {
    fetchCharacters();
  }

  Future<void> fetchCharacters([int? page]) async {
    final currentPage = page ?? state.currentPage;
    if (currentPage == 1) {
      state = CharacterState.loading(currentPage);
    } else {
      state =
          CharacterState.loaded(state.characters!, currentPage: currentPage, isLoadingMore: true);
    }

    final response = await characterRepository.getAllCharacters(page: currentPage);

    response.fold(
      (l) =>
          state = CharacterState.error('Failed to fetch characters: ${l.toString()}', currentPage),
      (r) async {
        if (r.isEmpty) {
          state = CharacterState.error('No more characters to load.', currentPage);
        } else {
          final currentCharacters = state.characters ?? [];

          final favorites = await dbHelper.getFavoritesForUser(userName);
          final favoriteIds = favorites.map((fav) => fav.id).toList();

          for (var character in r) {
            character.isFavorite = favoriteIds.contains(character.id);
          }

          final updatedCharacters = [...currentCharacters, ...r];
          state = CharacterState.loaded(updatedCharacters,
              currentPage: currentPage + 1, isLoadingMore: false);
        }
      },
    );
  }

  void updateCharacter(Character character) {
    final index = state.characters?.indexWhere((c) => c.id == character.id);

    if (index != null && index != -1) {
      state.characters![index] = character;
      state = CharacterState.loaded([...state.characters!], currentPage: state.currentPage);
    }
  }
}
