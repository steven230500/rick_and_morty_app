import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/src/data/models/character.dart';
import 'package:rick_and_morty_app/src/data/models/location.dart';

class ApiService {
  final String _baseUrl = 'https://rickandmortyapi.com/api';

  Future<Either<Exception, List<Character>>> getCharacters({int page = 1}) async {
    final endpoint = Uri.parse('$_baseUrl/character?page=$page');

    try {
      final response = await http.get(endpoint);

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as Map<String, dynamic>;

        var charactersList = data['results'] as List;

        List<Character> characters =
            charactersList.map((item) => Character.fromJson(item)).toList();
        log('charactersList: $characters');

        return right(characters);
      } else {
        return left(Exception('Failed to load characters - Status code: ${response.statusCode}'));
      }
    } catch (e) {
      return left(Exception('Failed to load characters - Error: $e'));
    }
  }

  Future<Either<Exception, List<Location>>> getLocations({int page = 1}) async {
    var endpoint = Uri.parse('$_baseUrl/location?page=$page');

    try {
      var response = await http.get(endpoint);

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as Map<String, dynamic>;
        var locationsList = data['results'] as List;
        List<Location> locations = locationsList.map((item) => Location.fromJson(item)).toList();

        return right(locations);
      } else if (response.statusCode == 404) {
        if (page == 1) {
          return left(Exception('No locations found'));
        } else {
          return right([]);
        }
      } else {
        return left(Exception('Failed to load locations - Status code: ${response.statusCode}'));
      }
    } catch (e) {
      return left(Exception('Failed to load locations - Error: $e'));
    }
  }
}
