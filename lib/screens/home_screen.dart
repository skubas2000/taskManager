import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/screens/task_detail_screen.dart';
import 'package:taskmanager/screens/add_task_screen.dart';
import 'package:taskmanager/providers/task_provider.dart';
import 'package:taskmanager/screens/info_screen.dart';
import 'package:http/http.dart' as http;  // Dodajemy pakiet http

// Funkcja do pobierania daty z API
Future<String> fetchAmsterdamDate() async {
  final response = await http.get(Uri.parse('https://timeapi.io/api/time/current/zone?timeZone=Europe%2FAmsterdam'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['date'];  // Zwraca datę w formacie "01/14/2025"
  } else {
    throw Exception('Failed to load date');
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(taskProvider.notifier).loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);  // Odczytujemy zadania z provider

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfoScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: tasks.isEmpty
          ? Center(child: CircularProgressIndicator())  // Pokazuje loader, jeśli zadania są ładowane
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];

                return ListTile(
                  title: Text(task.title),  // Wyświetlamy tylko tytuł zadania
                  onTap: () {
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: FutureBuilder<String>(
        future: fetchAmsterdamDate(),  // Wywołanie funkcji pobierającej datę
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: Text('Error loading date')),
            );
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Current date in Amsterdam: ${snapshot.data}'),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
