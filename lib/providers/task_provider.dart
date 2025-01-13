import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/models/task_model.dart';  // Zaimportuj model

// Provider dla listy zadań
class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  void addTask(Task task) {
    state = [...state, task];  // Dodaj nowe zadanie do listy
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>(
  (ref) => TaskNotifier(),
);
