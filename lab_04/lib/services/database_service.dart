import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/event.dart';

class DatabaseService {
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'events.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE events(id INTEGER PRIMARY KEY, title TEXT, date TEXT, location TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertEvent(Event event) async {
    final db = await _openDB();
    await db.insert('events', event.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Event>> getEvents() async {
    final db = await _openDB();
    final List<Map<String, dynamic>> maps = await db.query('events');
    return List.generate(maps.length, (i) => Event.fromMap(maps[i]));
  }
}
