import 'package:rick_and_morty_app/src/data/services/api.dart';
import 'package:rick_and_morty_app/src/domain/repositories/character_repository.dart';
import 'package:rick_and_morty_app/src/data/models/character.dart';
import 'package:dartz/dartz.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final ApiService apiService;

  CharacterRepositoryImpl({required this.apiService});

  @override
  Future<Either<Exception, List<Character>>> getAllCharacters({int page = 1}) async {
    return await apiService.getCharacters(page: page);
  }
}
