import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../presentation/viewmodels/task_viewmodel.dart';
import '../data/models/task_model.dart';

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
      viewModel.addTask(TaskModel(title: taskTitle, description: taskNote));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context)
          .viewInsets,
      child: Container(
        height:
            MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  CupertinoIcons.app,
                  color: Color(0xFFB4BED0),
                  size: 24,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: "What’s in your mind?",
                      hintStyle: TextStyle(
                        color: Color(0xFFB4BED0),
                      ),
                      border: InputBorder.none,
                      focusColor: Color(0xFFB4BED0),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(CupertinoIcons.pencil, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      hintText: "Add a note...",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFB4BED0),
                      ),
                      border: InputBorder.none,
                      focusColor: Color(0xFFB4BED0),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: _createTask,
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF007FFF),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text(
                  "Create",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(
                        0xFF007FFF),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
