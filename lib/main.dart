import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';

import 'task_render.dart';
import 'const_values.dart';
import 'task_class.dart';

/*
1. isar (бд) //solved
2. внешний вид в стиле material you
3. адаптивная тема
 */

void main() {
  runApp(
      EasyDynamicThemeWidget(
          child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO app',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: const MyHomePage(title: "Todo's"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Task> _tasks = Task.getTasks();
  Iterable<Task> _filteredTasks = [];
  final TextEditingController _newTaskName = TextEditingController();
  final TextEditingController _findValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: _tasks.isNotEmpty ? buildBody() : const Center(
        child: Text("Add a new task by pressing +"),
      ),
      floatingActionButton: buildDialog(),
    );
  }

  FloatingActionButton buildDialog() {
    return FloatingActionButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Add new task"),
          content: TextField(
            controller: _newTaskName,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "Type here",
              //prefixIcon: const Icon(Icons.add_box_outlined)
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    Task newTask = Task(
                      id: DateTime.now().microsecondsSinceEpoch,
                      name: _newTaskName.text
                    );

                    _tasks.add(newTask);
                    _newTaskName.text = '';
                  });

                  Navigator.pop(context);
                },
                child: const Text("Add")
            )
          ],
        )
      ),
      tooltip: 'Add new task',
      child: const Icon(Icons.add),
    );
  }

  void _onCheckbox(Task clickedOn) {
    setState(() {
      clickedOn.isActive = !clickedOn.isActive;
    });
  }

  void _onDelete(Task clickedOn) {
    setState(() {
      _tasks.removeWhere((element) => element.id == clickedOn.id);
    });
  }

  ListView buildBody() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (Task v in _filteredTasks)
                TaskBuild(
                  task: v,
                  onCheckbox: _onCheckbox,
                  onDelete: _onDelete,
                ),
            ],
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Text(widget.title),
          buildSearchBar(),
          IconButton(
              onPressed: () {
                EasyDynamicTheme.of(context).changeTheme();
              },
              icon: themeIcons[Theme.of(context).brightness.index],
              tooltip: "Change theme (WIP)",
          ),
        ],
      ),
    );
  }

  Expanded buildSearchBar() {
    return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Card(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextField(
                    controller: _findValue,
                    onChanged: (String? val) {
                      setState(() {
                        _filteredTasks = _tasks.where((element) => element.name!.contains(_findValue.text));
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search here",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
