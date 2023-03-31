import 'package:flutter/material.dart';

import '../models/task.model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var showDescription = false;
  var important = false;

  final title = TextEditingController();
  final description = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Adicionar tarefa",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              const Divider(
                thickness: 1,
                height: 0,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: title,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "O que você gostaria de fazer?",
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Preencha o campo";
                },
              ),
              if (showDescription)
                TextField(
                  controller: description,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Adicionar informações",
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showDescription = true;
                      });
                    },
                    child: const Icon(Icons.sort),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        important = !important;
                      });
                    },
                    child: Icon(important ? Icons.star : Icons.star_border),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final task = Task(
                          title: title.text,
                          description: description.text.isEmpty
                              ? null
                              : description.text,
                          important: important,
                        );

                        Navigator.pop(context, task);
                      }
                    },
                    child: const Text("Adicionar"),
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
