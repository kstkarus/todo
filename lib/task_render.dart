import 'package:flutter/material.dart';
import 'task_class.dart';

class TaskBuild extends StatelessWidget {
  const TaskBuild({super.key, required this.task, required this.onCheckbox, required this.onDelete});

  final Task task;
  final onCheckbox;
  final onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: IconButton(
          icon: task.isActive ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
          tooltip: "Check/Uncheck task",
          onPressed: () {
            onCheckbox(task);
          }
        ),
        title: Text(
            task.name!,
            style: TextStyle(decoration: task.isActive ? TextDecoration.lineThrough : TextDecoration.none)
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_forever_outlined),
          tooltip: "Delete task",
          onPressed: () {
            onDelete(task);
            //print("task -> ${task.id} msg -> ${task.name}");
          },
        ),
      ),
    );
  }
}
