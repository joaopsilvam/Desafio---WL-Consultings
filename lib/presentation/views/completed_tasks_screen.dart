import 'package:desafio_mobile/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../widgets/app_header.dart';
import '../viewmodels/task_viewmodel.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context);
    final int taskCount = viewModel.completedTasks.length;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppHeader(),

          /// 🔹 Header com título e botão "Delete all"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Completed Tasks',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (taskCount >
                    0) // 🔹 Só mostra o botão se houver tarefas concluídas
                  TextButton(
                    onPressed: () {
                      viewModel.deleteAllCompletedTasks();
                    },
                    child: const Text(
                      'Delete all',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Expanded(
            child: taskCount == 0
                ? const EmptyStateWidget(message: 'No completed tasks yet.')
                : _buildTaskList(viewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(TaskViewModel viewModel) {
    final completedTasks = viewModel.completedTasks;

    return ListView.builder(
      itemCount: completedTasks.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        final task = completedTasks[index];

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F7F9),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  final viewModel =
                      Provider.of<TaskViewModel>(context, listen: false);
                  final taskIndex =
                      viewModel.tasks.indexWhere((t) => t.title == task.title);

                  if (taskIndex != -1) {
                    viewModel.toggleTaskCompletion(taskIndex);
                  }
                },
                child: Icon(
                  task.isCompleted
                      ? CupertinoIcons.checkmark_square_fill
                      : CupertinoIcons.square,
                  color: task.isCompleted
                      ? const Color(0xFF007FFF)
                      : const Color(0xFFB4BED0),
                  size: 24,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(143, 141, 156, 184),
                  ),
                ),
              ),
              IconButton(
                iconSize: 22,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  viewModel.deleteTask(viewModel.tasks.indexOf(task));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
