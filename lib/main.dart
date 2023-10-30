import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/presentation/screen/character_screen.dart';
import 'package:rick_and_morty_app/src/presentation/screen/favorite_screen.dart';
import 'package:rick_and_morty_app/src/presentation/screen/home_screen.dart';
import 'package:rick_and_morty_app/src/presentation/screen/login_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty App',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/character': (context) => const CharacterScreen(),
        '/favorite': (context) => const FavoriteScreen(),
      },
    );
  }
}
