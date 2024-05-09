class Task {
  int id = DateTime.now().microsecondsSinceEpoch;
  String name;
  bool isActive;

  Task({required this.name, this.isActive = false});

  static List<Task> getTasks() {
    //parser

    return [
      Task(name: "Buy milk and smth"),
      Task(name: "Локализация?", isActive: true),
      Task(name: "ну чет еще"),
    ];
  }
}