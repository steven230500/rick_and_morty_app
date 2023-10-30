import 'package:rick_and_morty_app/src/data/models/location.dart';
import 'package:rick_and_morty_app/src/data/models/origin.dart';

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Origin origin;
  final Location location;
  final String image;
  final String url;
  final DateTime created;
  bool isFavorite;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.url,
    required this.created,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin.toJson(),
      'location': location.toJson(),
      'image': image,
      'url': url,
      'created': created.toIso8601String(),
      'isFavorite': isFavorite,
    };
  }

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      species: json['species'] ?? '',
      type: json['type'] ?? '',
      gender: json['gender'] ?? '',
      origin: Origin.fromJson(json['origin'] ?? {}),
      location: Location.fromJson(json['location'] ?? {}),
      image: json['image'] ?? '',
      url: json['url'] ?? '',
      created: (json['created'] != null) ? DateTime.parse(json['created']) : DateTime.now(),
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
