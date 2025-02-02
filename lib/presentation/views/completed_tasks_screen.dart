import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/task_viewmodel.dart';
import '../../data/models/task_model.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context);
    final completedTasks = viewModel.tasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Tarefas Concluídas')),
      body: completedTasks.isEmpty
          ? const Center(child: Text('Nenhuma tarefa concluída'))
          : ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                final task = completedTasks[index];
                return ListTile(
                  title: Text(task.title, style: const TextStyle(decoration: TextDecoration.lineThrough)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => viewModel.deleteTask(index),
                  ),
                );
              },
            ),
    );
  }
}
