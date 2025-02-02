import 'package:desafio_mobile/presentation/views/create_task_screen.dart';
import 'package:desafio_mobile/presentation/views/main_screen.dart';
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
  Map<int, bool> expandedTasks = {}; // 🔹 Controla as tasks expandidas
  int? taskToDelete; // 🔹 Controla a task que está em modo de exclusão

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context);
    final int taskCount = viewModel.tasks.length;
    
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
            child: viewModel.tasks.isEmpty
                ? _buildEmptyState(context)
                : _buildTaskList(viewModel),
          )),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'images/tasks.png',
          height: 80,
        ),
        const SizedBox(height: 20),
        const Text(
          'You have no task listed.',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton.icon(
          onPressed: () {
            final mainScreenState =
                context.findAncestorStateOfType<MainScreenState>();
            if (mainScreenState != null) {
              mainScreenState
                  .changeTab(1); // 1 = Index da aba "CreateTaskScreen"
            }
          },
          icon: const Icon(
            CupertinoIcons.add,
            color: Color(0xFF007FFF),
          ),
          label: const Text(
            'Create task',
            style: TextStyle(
              color: Color(0xFF007FFF),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(26, 0, 128, 255),
            foregroundColor: const Color(0xFF007FFF),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
        ),
      ],
    );
  }

  Widget _buildTaskList(TaskViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.tasks.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        final task = viewModel.tasks[index];
        final isExpanded = expandedTasks[index] ?? false;
        final isDeleting = taskToDelete == index;

        return GestureDetector(
          onLongPress: () {
            setState(() {
              taskToDelete = index; // 🔹 Mostra os botões ao segurar a tarefa
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
                    const Icon(
                      CupertinoIcons.app,
                      color: Color(0xFFB4BED0),
                      size: 24,
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
                              taskToDelete =
                                  null; // 🔹 Oculta os botões após deletar
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
