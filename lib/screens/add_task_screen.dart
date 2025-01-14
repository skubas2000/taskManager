import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/providers/task_provider.dart';  // Zaimportuj provider'a
import 'package:taskmanager/models/task_model.dart';  // Zaimportuj model 'Task'
import 'dart:developer';


class AddTaskScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    void addTask() {
      final task = Task(
        title: titleController.text,
        description: descriptionController.text,
      );
      ref.read(taskProvider.notifier).addTask(task); // Dodaj zadanie do listy zadań
      log('xdDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'); // Logowanie tworzenia bazy danych
      Navigator.pop(context); // Zamknij ekran po dodaniu zadania
    }

    return Scaffold(
      appBar: AppBar(title: Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addTask,
              child: Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
