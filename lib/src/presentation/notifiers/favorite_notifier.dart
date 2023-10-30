import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/data/models/character.dart';
import 'package:rick_and_morty_app/src/utils/db_helper.dart';

class FavoriteNotifier extends StateNotifier<List<Character>> {
  final String userName;
  final DBHelper dbHelper = DBHelper.db;

  FavoriteNotifier(this.userName) : super([]) {
    _loadFavorites();
  }

  void _loadFavorites() async {
    final favorites = await dbHelper.getFavoritesForUser(userName);
    state = favorites;
  }

  Future<void> addFavorite(Character character) async {
    if (!state.any((existingCharacter) => existingCharacter.id == character.id)) {
      await dbHelper.addFavoriteForUser(userName, character);
      character.isFavorite = true;
      state = [...state, character];
    }
  }

  Future<void> removeFavorite(Character character) async {
    await dbHelper.removeFavoriteForUser(userName, character.id);
    character.isFavorite = false;
    state = state.where((item) => item.id != character.id).toList();
  }

  void clearFavorites() async {
    for (var character in state) {
      character.isFavorite = false;
    }
    state = [];
  }
}
