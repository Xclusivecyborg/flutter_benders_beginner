import 'package:flutter/material.dart';
import 'package:flutter_benders_beginner/data_modelling_class/network_request_mock_class.dart';
import 'package:flutter_benders_beginner/data_modelling_class/todo_model.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  List<TodoModel> _todoModels = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      _todoModels = NetworkRequestMock().processData();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _todoModels.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemCount: _todoModels.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final todo = _todoModels[index];
                return ListTile(
                  title: Text(todo.title),
                  trailing: Icon(
                    todo.completed ? Icons.check : Icons.close,
                    color: todo.completed ? Colors.green : Colors.red,
                  ),
                );
              },
            ),
    );
  }
}
