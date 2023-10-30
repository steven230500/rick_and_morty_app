import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/data/models/character.dart';
import 'package:rick_and_morty_app/src/presentation/notifiers/favorite_notifier.dart';
import 'package:rick_and_morty_app/src/presentation/providers/user_provider.dart';

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, List<Character>>((ref) {
  final userName = ref.watch(userProvider).user?.name ?? '';
  return FavoriteNotifier(userName);
});
