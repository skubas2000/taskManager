import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add_task_screen.dart'; // Import ekranu dodawania zadania
import '../providers/task_provider.dart'; // Import provider'a zadań

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Pobieramy listę zadań ze stanu
    final tasks = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: tasks.isEmpty
          ? Center(child: Text('Brak zadań'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index]), // Wyświetlanie zadania
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Otwórz ekran dodawania zadania
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );

          // Jeśli użytkownik podał zadanie, dodaj je do listy
          if (result != null && result.isNotEmpty) {
            ref.read(taskProvider.notifier).addTask(result);
          }
        },
        tooltip: 'Dodaj zadanie',
        child: Icon(Icons.add),
      ),
    );
  }
}
