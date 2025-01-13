import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDBService {
  Future<Database> initializeDB() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'tasks.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT)');
    }, version: 1);
  }

  Future<int> insertTask(String title) async {
    final db = await initializeDB();
    return await db.insert('tasks', {'title': title});
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await initializeDB();
    return await db.query('tasks');
  }
}
