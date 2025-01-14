import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer';

class LocalDBService {
  // Metoda inicjalizacji bazy danych
  Future<Database> initializeDB() async {
    final dbPath = await getDatabasesPath();
    log('DB Path: $dbPath'); // Logowanie ścieżki bazy danych
    final db = await openDatabase(
      join(dbPath, 'tasks.db'),
      onCreate: (db, version) {
        log('Database created'); // Zaloguj, gdy baza jest tworzona
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
        );
      },
      version: 1,
    );
    log('Database initialized successfully'); // Zaloguj, po inicjalizacji
    return db;
  }

  // Metoda pobierania zadań
  Future<List<Map<String, dynamic>>> getTasks() async {
    try {
      final db = await initializeDB();
      log('Fetching tasks from DB');
      return await db.query('tasks');
    } catch (e) {
      log('Error getting tasks: $e');
      rethrow;
    }
  }

  // Metoda dodawania zadania do bazy danych
  Future<int> insertTask(String title, String description) async {
    try {
      final db = await initializeDB();
      log('Inserting task: $title');
      return await db.insert('tasks', {
        'title': title,
        'description': description,
      });
    } catch (e) {
      log('Error inserting task: $e');
      rethrow;
    }
  }
}
