import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/data/models/character.dart';
import 'package:rick_and_morty_app/src/presentation/providers/favorite_provider.dart';

class CharacterCard extends ConsumerWidget {
  final Character character;

  const CharacterCard({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.all(4.0),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(character.image),
                    fit: BoxFit.cover,
                  ),
                ),
                width: 150,
                height: 150,
              ),
            ),
            Text(character.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getStatusIcon(character.status),
                  size: 12,
                ),
                const SizedBox(width: 4),
                Text(character.status),
              ],
            ),
            IconButton(
              icon: Icon(character.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                if (character.isFavorite) {
                  ref.read(favoriteProvider.notifier).removeFavorite(character);
                } else {
                  ref.read(favoriteProvider.notifier).addFavorite(character);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Alive':
        return Icons.check_circle;
      case 'Dead':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }
}
