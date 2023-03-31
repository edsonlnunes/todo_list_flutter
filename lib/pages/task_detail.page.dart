import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task.model.dart';

class TaskDetail extends StatefulWidget {
  final Task task;

  const TaskDetail({super.key, required this.task});

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late bool important;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    important = widget.task.important;
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.description ?? "";
  }

  saveTask() {
    if (formKey.currentState!.validate()) {
      final taskUpdate = widget.task;
      taskUpdate.title = titleController.text;
      taskUpdate.description = descriptionController.text.isEmpty
          ? null
          : descriptionController.text;
      taskUpdate.important = important;
      Navigator.of(context).pop(taskUpdate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        // elevation: 0,
        actions: [
          IconButton(
            icon: Icon(important ? Icons.star : Icons.star_border),
            onPressed: () {
              setState(() => important = !important);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Título",
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Preencher campo.";
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Descrição",
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: saveTask,
                child: const Text("Salvar tarefa"),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(
                      "Criada ${DateFormat.MMMEd("pt_BR").format(widget.task.createdAt)}",
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    icon: const Icon(Icons.delete_outline),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
