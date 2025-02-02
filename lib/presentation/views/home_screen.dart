import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/task_viewmodel.dart';
import '../../data/models/task_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context);
    
    return Scaffold(
      appBar: AppBar(title: Text('Tarefas')),
      body: ListView.builder(
        itemCount: viewModel.tasks.length,
        itemBuilder: (context, index) {
          final task = viewModel.tasks[index];
          return ListTile(
            title: Text(task.title, style: TextStyle(decoration: task.isCompleted ? TextDecoration.lineThrough : null)),
            trailing: Checkbox(
              value: task.isCompleted,
              onChanged: (_) => viewModel.toggleTaskCompletion(index),
            ),
            onLongPress: () => viewModel.deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context, viewModel),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, TaskViewModel viewModel) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Nova Tarefa'),
          content: TextField(controller: controller),
          actions: [
            TextButton(
              onPressed: () {
                viewModel.addTask(controller.text);
                Navigator.pop(context);
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
