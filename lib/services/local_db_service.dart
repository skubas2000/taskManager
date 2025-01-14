import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer';

class LocalDBService {
  // Metoda inicjalizacji bazy danych
  Future<Database> initializeDB() async {
    final dbPath = await getDatabasesPath();
    final db = await openDatabase(
      join(dbPath, 'tasks.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(title TEXT, description TEXT)',
        );
      },
      version: 1,
    );
    return db;
  }

  // Metoda pobierania zadań
  Future<List<Map<String, dynamic>>> getTasks() async {
    try {
      final db = await initializeDB();
      return await db.query('tasks');
    } catch (e) {
      log('Error getting tasks: $e');
      rethrow;
    }
  }

  // Metoda dodawania zadania do bazy danych
  Future<void> insertTask(String title, String description) async {
    try {
      final db = await initializeDB();
      await db.insert('tasks', {
        'title': title,
        'description': description,
      });
    } catch (e) {
      log('Error inserting task: $e');
      rethrow;
    }
  }

  // Metoda usuwania zadania z bazy danych
  Future<void> deleteTask(String title, String description) async {
    final db = await initializeDB();
    await db.delete(
      'tasks',
      where: 'title = ? AND description = ?',
      whereArgs: [title, description],
    );
  }
}
