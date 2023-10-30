import 'package:rick_and_morty_app/src/data/models/character.dart';

enum CharacterStateStatus { initial, loading, loaded, error }

class CharacterState {
  final CharacterStateStatus status;
  final List<Character>? characters;
  final String? errorMessage;
  final int currentPage;
  final bool isLoadingMore;

  CharacterState({
    required this.status,
    this.characters,
    this.errorMessage,
    required this.currentPage,
    this.isLoadingMore = false,
  });

  factory CharacterState.initial() =>
      CharacterState(status: CharacterStateStatus.initial, currentPage: 1);

  factory CharacterState.loading(int currentPage) =>
      CharacterState(status: CharacterStateStatus.loading, currentPage: currentPage);

  factory CharacterState.loaded(List<Character> characters,
          {required int currentPage, bool isLoadingMore = false}) =>
      CharacterState(
          status: CharacterStateStatus.loaded,
          characters: characters,
          currentPage: currentPage,
          isLoadingMore: isLoadingMore);

  factory CharacterState.error(String error, int currentPage) => CharacterState(
      status: CharacterStateStatus.error, errorMessage: error, currentPage: currentPage);
}
