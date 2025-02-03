import 'package:desafio_mobile/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../widgets/app_header.dart';
import '../viewmodels/task_viewmodel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Map<int, bool> expandedTasks = {};
  int? taskToDelete;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context);
    final filteredTasks = viewModel.tasks
        .where((task) =>
            task.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      body: Column(
        children: [
          const AppHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF5F7F9),
                hintText: "Search tasks...",
                hintStyle: const TextStyle(color: Color(0xFFB4BED0)),
                prefixIcon: Icon(
                  CupertinoIcons.search,
                  color: _searchQuery.isEmpty
                      ? const Color(0xFFB4BED0)
                      : const Color(0xFF007FFF),
                  size: 20,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = "";
                          });
                        },
                        child: const Icon(
                          CupertinoIcons.xmark_circle_fill,
                          color: Colors.grey,
                          size: 20,
                        ),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF007FFF)),
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredTasks.isEmpty
                ? const EmptyStateWidget(message: 'No tasks found.')
                : ListView.builder(
                    itemCount: filteredTasks.length,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      final isExpanded = expandedTasks[index] ?? false;
                      final isDeleting = taskToDelete == index;

                      return GestureDetector(
                        onLongPress: () {
                          setState(() {
                            taskToDelete = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
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
                                          Provider.of<TaskViewModel>(context,
                                              listen: false);
                                      final taskIndex = viewModel.tasks
                                          .indexWhere(
                                              (t) => t.title == task.title);

                                      if (taskIndex != -1) {
                                        viewModel
                                            .toggleTaskCompletion(taskIndex);
                                      }
                                    },
                                    child: Icon(
                                      task.isCompleted
                                          ? CupertinoIcons.checkmark_square_fill
                                          : CupertinoIcons.square,
                                      color: task.isCompleted
                                          ? const Color(
                                              0xFF007FFF)
                                          : const Color(
                                              0xFFB4BED0),
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
                                      const EdgeInsets.only(left: 36, top: 5),
                                  child: Text(
                                    task.description ??
                                        'No description available.',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
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
                                          viewModel.deleteTask(
                                              viewModel.tasks.indexOf(task));
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
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text('Confirm delete'),
                                      ),
                                      const SizedBox(width: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            taskToDelete = null;
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey[400],
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                  ),
          ),
        ],
      ),
    );
  }
}
