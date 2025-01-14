import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/models/task_model.dart'; // Zaimportuj model
import 'package:taskmanager/providers/task_provider.dart'; // Zaimportuj provider

class TaskDetailScreen extends ConsumerWidget {
  final Task task;

  TaskDetailScreen({required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Funkcja usuwania zadania
    void deleteTask() {
      ref.read(taskProvider.notifier).deleteTask(task);  // Usuwanie zadania
      Navigator.pop(context);  // Zamknięcie ekranu
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: deleteTask,
              child: Text("Delete Task"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Czerwony przycisk
              ),
            ),
          ],
        ),
      ),
    );
  }
}
