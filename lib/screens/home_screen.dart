import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/screens/add_task_screen.dart';  // Import ekranu dodawania zadania
import 'package:taskmanager/providers/task_provider.dart';  // Import provider'a
import 'package:taskmanager/services/local_db_service.dart'; // Zaimportuj usługę DB
import 'package:taskmanager/models/task_model.dart';  // Zaimportuj model

class HomeScreen extends ConsumerWidget {
  final LocalDBService localDBService = LocalDBService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);  // Obserwuj listę zadań

    return Scaffold(
      appBar: AppBar(title: Text("Task Manager")),
      body: FutureBuilder<List<Task>>(
        future: _fetchTasksFromDB(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tasks available.'));
          } else {
            final tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.title),
                  onTap: () {
                    // Przejdź do ekranu szczegółów zadania
                    // Możesz dodać ekran szczegółów zadania
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Przejdź do ekranu dodawania zadania
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Zmieniona metoda konwertująca Map na Task
  Future<List<Task>> _fetchTasksFromDB() async {
    final dbTasks = await localDBService.getTasks();
    // Konwertowanie Map na Task
    return dbTasks.map((taskMap) {
      return Task(
        title: taskMap['title'],  // Zwróć 'title' z mapy
        description: taskMap['description'],  // Zwróć 'description' z mapy
      );
    }).toList();
  }
}
