import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/models/task_model.dart';  // Zaimportuj model
import 'package:taskmanager/services/local_db_service.dart'; // Zaimportuj usługę DB

// Provider dla listy zadań
class TaskNotifier extends StateNotifier<List<Task>> {
  final LocalDBService localDBService;

  TaskNotifier(this.localDBService) : super([]);

  // Metoda dodawania zadania do bazy danych i stanu Riverpod
  Future<void> addTask(Task task) async {
    await localDBService.insertTask(task.title, task.description);  // Zapisz zadanie
    state = [...state, task];  // Dodaj zadanie do listy w stanie
  }

  // Metoda ładowania zadań z bazy danych
  Future<void> loadTasks() async {
    final dbTasks = await localDBService.getTasks();  // Pobierz zadania
    state = dbTasks.map((taskMap) {
      return Task.fromMap(taskMap);  // Przekształć mapy w obiekty Task
    }).toList();  // Ustaw stan
  }

  // Metoda usuwania zadania (usuwamy na podstawie tytułu i opisu)
  Future<void> deleteTask(Task task) async {
    await localDBService.deleteTask(task.title, task.description);  // Usuń zadanie
    state = state.where((t) => t.title != task.title || t.description != task.description).toList();  // Usuń zadanie z listy
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>(
  (ref) => TaskNotifier(LocalDBService()),  // Tworzymy instancję LocalDBService
);
