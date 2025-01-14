class Task {
  final String title;
  final String description;

  Task({
    required this.title,
    required this.description,
  });

  // Metoda konwersji obiektu Task do mapy (przydatne do zapisu w bazie)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  // Metoda konwersji mapy do obiektu Task
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      description: map['description'],
    );
  }
}
