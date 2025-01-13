import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/screens/add_task_screen.dart';  // Import ekranu dodawania zadania
import 'package:taskmanager/screens/task_detail_screen.dart';  // Import ekranu szczegółów zadania
import 'package:taskmanager/providers/task_provider.dart';  // Import provider'a

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);  // Obserwuj listę zadań

    return Scaffold(
      appBar: AppBar(title: Text("Task Manager")),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            onTap: () {
              // Przejdź do ekranu szczegółów zadania
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailScreen(task: task),
                ),
              );
            },
          );
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
}
