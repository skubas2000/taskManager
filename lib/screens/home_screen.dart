import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';  // Zaimportuj Riverpod
import 'package:taskmanager/models/task_model.dart'; // Zaimportuj model
import 'package:taskmanager/screens/task_detail_screen.dart'; // Zaimportuj ekran szczegółów zadania
import 'package:taskmanager/screens/add_task_screen.dart'; // Zaimportuj ekran dodawania zadania
import 'package:taskmanager/providers/task_provider.dart'; // Zaimportuj provider

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Ładujemy zadania zaraz po otwarciu ekranu
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(taskProvider.notifier).loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);  // Odczytaj listę zadań z provider

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: tasks.isEmpty
          ? Center(child: CircularProgressIndicator())  // Pokazuj loader, jeśli zadania są ładowane
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];

                return ListTile(
                  title: Text(task.title),  // Wyświetlamy tylko tytuł zadania
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
