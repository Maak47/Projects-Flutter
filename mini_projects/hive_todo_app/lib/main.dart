import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todo_app/todo_item.dart';
import 'package:hive_todo_app/todo_service.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoItemAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TodoService _todoService = TodoService();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _todoService.getAllTodos(),
        builder:
            (BuildContext context, AsyncSnapshot<List<TodoItem>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return HomePage();
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final TodoService _todoService = TodoService();
  final TextEditingController _titleController = TextEditingController();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive TODO List'),
        backgroundColor: Colors.black,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<TodoItem>('todoBox').listenable(),
        builder: (context, Box<TodoItem> box, _) {
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              var todo = box.getAt(index);
              return ListTile(
                title: Text(todo!.title),
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (val) {
                    _todoService.updateIsCompleted(index, todo);
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_rounded,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _todoService.deleteTodo(index);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Add Todo'),
                content: TextField(
                  controller: _titleController,
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      var todo = TodoItem(_titleController.text, false);
                      await _todoService.addItem(todo);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            );
          },
          child: const Icon(Icons.add)),
    );
  }
}
