import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider do przechowywania listy zadań
final taskProvider = StateNotifierProvider<TaskNotifier, List<String>>((ref) {
  return TaskNotifier();
});

class TaskNotifier extends StateNotifier<List<String>> {
  TaskNotifier() : super([]);

  // Funkcja dodająca zadanie
  void addTask(String task) {
    state = [...state, task];  // Dodaje nowe zadanie do listy
  }
}
