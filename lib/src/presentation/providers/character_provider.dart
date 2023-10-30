import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/data/repositories/character_repository_impl.dart';
import 'package:rick_and_morty_app/src/data/services/api.dart';
import 'package:rick_and_morty_app/src/domain/repositories/character_repository.dart';
import 'package:rick_and_morty_app/src/presentation/notifiers/character_notifier.dart';
import 'package:rick_and_morty_app/src/presentation/providers/user_provider.dart';
import 'package:rick_and_morty_app/src/presentation/states/character_state.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final characterRepositoryProvider = Provider<CharacterRepository>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return CharacterRepositoryImpl(apiService: apiService);
});
final characterProvider = StateNotifierProvider<CharacterNotifier, CharacterState>((ref) {
  final repo = ref.watch(characterRepositoryProvider);
  final userName = ref.watch(userProvider).user?.name ?? '';

  return CharacterNotifier(repo, userName);
});
