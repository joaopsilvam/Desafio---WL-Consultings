import 'package:desafio_mobile/widgets/create_task_modal.dart';
import 'package:desafio_mobile/presentation/views/main_screen.dart';
import 'package:desafio_mobile/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import '../../widgets/app_header.dart';
import '../viewmodels/task_viewmodel.dart';
import '../../data/models/task_model.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  Map<int, bool> expandedTasks = {};
  int? taskToDelete;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context);
    final int taskCount = viewModel.incompleteTasks.length;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      'Welcome, ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'John',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF007FFF),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  taskCount == 0
                      ? 'Create tasks to achieve more.'
                      : 'You’ve got $taskCount tasks to do.',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Center(
            child: viewModel.incompleteTasks.isEmpty
                ? const EmptyStateWidget(message: 'You have no task listed.')
                : _buildTaskList(viewModel),
          )),
        ],
      ),
    );
  }

  Widget _buildTaskList(TaskViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.incompleteTasks.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        final task = viewModel.incompleteTasks[index];
        final isExpanded = expandedTasks[index] ?? false;
        final isDeleting = taskToDelete == index;

        return GestureDetector(
          onLongPress: () {
            setState(() {
              taskToDelete = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        final viewModel =
                            Provider.of<TaskViewModel>(context, listen: false);
                        final taskIndex = viewModel.tasks
                            .indexWhere((t) => t.title == task.title);

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
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 20,
                      icon: const Icon(
                        CupertinoIcons.ellipsis,
                        color: Color(0xFFB4BED0),
                      ),
                      onPressed: () {
                        setState(() {
                          expandedTasks[index] =
                              !(expandedTasks[index] ?? false);
                        });
                      },
                    ),
                  ],
                ),
                if (isExpanded)
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 36, bottom: 8, right: 8),
                    child: Text(
                      task.description ?? 'No description available.',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                if (isDeleting)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            viewModel.deleteTask(index);
                            setState(() {
                              taskToDelete = null;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Confirm delete'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              taskToDelete = null; // 🔹 Apenas oculta os botões
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[400],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
