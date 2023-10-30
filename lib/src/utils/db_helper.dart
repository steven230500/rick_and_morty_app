import 'dart:convert';
import 'dart:developer';

import 'package:rick_and_morty_app/src/data/models/user.dart';
import 'package:rick_and_morty_app/src/data/models/character.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper db = DBHelper._();

  Database? _database;

  DBHelper._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), "favorites_db.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE favorites(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_name TEXT,
            character_id INTEGER,
            character_data TEXT
          )
        ''');
      },
    );
  }

  Future<User?> getUserByName(String name) async {
    final db = await database;
    var res = await db!.query("users", where: "name = ?", whereArgs: [name]);
    return res.isNotEmpty ? User.fromMap(res.first) : null;
  }

  insertUser(String name) async {
    final db = await database;
    var raw =
        await db!.insert("users", User(name).toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return raw;
  }

  Future<List<Character>> getFavoritesForUser(String userName) async {
    final db = await database;
    var res = await db!.query("favorites", where: "user_name = ?", whereArgs: [userName]);
    if (res.isEmpty) return [];

    List<Character> list = [];
    for (var map in res) {
      String jsonData = map['character_data'] as String;
      try {
        Map<String, dynamic> characterMap = json.decode(jsonData);
        log('dsfsdfs $characterMap');
        list.add(Character.fromJson(characterMap));
      } catch (e) {
        log("Error decoding JSON for character:Error: $e");
      }
    }
    return list;
  }

  addFavoriteForUser(String userName, Character character) async {
    final db = await database;

    character.isFavorite = true;

    final jsonCharacterString = jsonEncode(character.toJson());
    log('Insertando: $jsonCharacterString');

    var raw = await db!.insert(
        "favorites",
        {
          'user_name': userName,
          'character_id': character.id,
          'character_data': jsonCharacterString
        },
        conflictAlgorithm: ConflictAlgorithm.replace);

    return raw;
  }

  removeFavoriteForUser(String userName, int characterId) async {
    final db = await database;
    int deleteCount = await db!.delete("favorites",
        where: "user_name = ? AND character_id = ?", whereArgs: [userName, characterId]);
    return deleteCount;
  }
}
