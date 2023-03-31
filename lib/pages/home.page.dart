import 'package:flutter/material.dart';
import 'package:todo_list/widgets/add_task.widget.dart';
import 'package:todo_list/pages/task_detail.page.dart';

import '../models/task.model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tasks = <Task>[];

  void _navigateToDetail(Task task, int index) async {
    final updatedTask = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TaskDetail(
          task: task,
        ),
      ),
    );

    if (updatedTask != null) {
      setState(() {
        if (updatedTask is Task) {
          tasks[index] = updatedTask;
        } else {
          tasks.removeAt(index);
        }
      });
    }
  }

  void _addNewTask() async {
    final newTask = await showModalBottomSheet<Task>(
      isScrollControlled: true,
      context: context,
      builder: (context) => const AddTask(),
    );

    if (newTask != null) {
      setState(() {
        tasks.add(newTask);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarefas"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        itemCount: tasks.length,
        itemBuilder: (ctx, index) {
          final task = tasks[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
            color: Colors.indigo[50],
            child: ListTile(
              leading: Checkbox(
                onChanged: (value) {
                  setState(() => task.changeStatus(value!));
                },
                value: task.completed,
              ),
              trailing: IconButton(
                icon: Icon(task.important ? Icons.star : Icons.star_border),
                color: Colors.indigo,
                onPressed: () {
                  setState(() => task.changeImportance());
                },
              ),
              title: Text(task.title),
              subtitle: task.description != null
                  ? Text(
                      task.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  : null,
              onTap: () => _navigateToDetail(task, index),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addNewTask(),
        icon: const Icon(Icons.add),
        label: const Text("Nova tarefa"),
      ),
    );
  }
}
