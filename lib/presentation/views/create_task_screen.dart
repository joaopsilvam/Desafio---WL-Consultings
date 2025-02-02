import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../viewmodels/task_viewmodel.dart';
import '../../data/models/task_model.dart';

class CreateTaskModal extends StatefulWidget {
  const CreateTaskModal({super.key});

  @override
  _CreateTaskModalState createState() => _CreateTaskModalState();
}

class _CreateTaskModalState extends State<CreateTaskModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  void _createTask() {
    final taskTitle = _titleController.text.trim();
    final taskNote = _noteController.text.trim();

    if (taskTitle.isNotEmpty) {
      final viewModel = Provider.of<TaskViewModel>(context, listen: false);
      viewModel.addTask(TaskModel(title: taskTitle, description: taskNote) as String);
      Navigator.pop(context); // 🔹 Fecha o modal após adicionar a task
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets, // 🔹 Evita que o teclado cubra o modal
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5, // 🔹 Ocupa metade da tela
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Campo de Texto com Ícone
            Row(
              children: [
                const Icon(CupertinoIcons.pencil_outline, color: Color(0xFF007FFF)),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: "What’s in your mind?",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),

            // 🔹 Nota com Ícone de Lápis
            Row(
              children: [
                const Icon(CupertinoIcons.create, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      hintText: "Add a note...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(), // 🔹 Empurra o botão para baixo

            // 🔹 Botão "Create"
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: _createTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007FFF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Create"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
