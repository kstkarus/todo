class Task {
  int? id;
  String? name;
  bool isActive;

  Task({required this.id, required this.name, this.isActive = false});

  static List<Task> getTasks() {
    return [
      Task(id: 1, name: "Buy milk and smth"),
      Task(id: 2, name: "Локализация?", isActive: true),
      Task(id: 3, name: "ну чет еще"),
    ];
  }
}