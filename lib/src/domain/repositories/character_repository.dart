import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/src/data/models/character.dart';

abstract class CharacterRepository {
  Future<Either<Exception, List<Character>>> getAllCharacters({int page = 1});
}
