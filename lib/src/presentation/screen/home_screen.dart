import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/presentation/providers/favorite_provider.dart';
import 'package:rick_and_morty_app/src/presentation/screen/character_screen.dart';
import 'package:rick_and_morty_app/src/presentation/screen/favorite_screen.dart';
import 'package:rick_and_morty_app/src/presentation/screen/location_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Rick and Morty"),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Characters'),
                  Tab(text: 'Locations'),
                  Tab(text: 'Favorites'),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () {
                    ref.read(favoriteProvider.notifier).clearFavorites();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/',
                      (route) => false,
                    );
                  },
                  tooltip: "Log out",
                ),
              ],
            ),
            body: PageTransitionSwitcher(
              transitionBuilder: (child, animation, secondaryAnimation) => FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              ),
              child: TabBarView(
                key: ValueKey<int>(DefaultTabController.of(context).index),
                children: const [
                  CharacterScreen(),
                  LocationScreen(),
                  FavoriteScreen(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
