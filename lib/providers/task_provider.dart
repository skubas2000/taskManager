import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/models/task_model.dart';  // Zaimportuj model
import 'package:taskmanager/services/local_db_service.dart'; // Zaimportuj usługę DB

// Provider dla listy zadań
class TaskNotifier extends StateNotifier<List<Task>> {
  final LocalDBService localDBService;

  TaskNotifier(this.localDBService) : super([]);

  // Metoda dodawania zadania do bazy danych i stanu Riverpod
  Future<void> addTask(Task task) async {
    await localDBService.insertTask(task.title, task.description);  // Dodaj zadanie do bazy
    state = [...state, task];  // Dodaj nowe zadanie do listy w stanie
  }

  // Metoda ładowania zadań z bazy danych
  Future<void> loadTasks() async {
    final dbTasks = await localDBService.getTasks();  // Pobierz zadania z bazy danych
    state = dbTasks.map((taskMap) {
      return Task(
        title: taskMap['title'],
        description: taskMap['description'],
      );
    }).toList();  // Przekształć mapy w obiekty Task i ustaw stan
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>(
  (ref) => TaskNotifier(LocalDBService()),  // Tworzymy instancję LocalDBService
);
