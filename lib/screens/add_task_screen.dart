import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController taskController = TextEditingController();

  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodaj zadanie'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: taskController,
              decoration: InputDecoration(labelText: 'Nazwa zadania'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Jeśli użytkownik podał zadanie, wróć do poprzedniego ekranu
                if (taskController.text.isNotEmpty) {
                  Navigator.pop(context, taskController.text);
                }
              },
              child: Text('Dodaj zadanie'),
            ),
          ],
        ),
      ),
    );
  }
}
