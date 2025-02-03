import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _repository = TaskRepository();
  List<TaskModel> _tasks = [];
  final int _limit = 10;

  List<TaskModel> get tasks => _tasks;
  List<TaskModel> get incompleteTasks =>
      _tasks.where((task) => !task.isCompleted).toList();
  List<TaskModel> get completedTasks =>
      _tasks.where((task) => task.isCompleted).toList();

  void loadTasks() {
    _tasks = _repository.getTasks().take(_limit).toList();
    notifyListeners();
  }

  void loadMoreTasks() {
    int startIndex = _tasks.length;
    List<TaskModel> moreTasks =
        _repository.getTasks().skip(startIndex).take(_limit).toList();

    if (moreTasks.isNotEmpty) {
      _tasks.addAll(moreTasks);
      notifyListeners();
    }
  }

  void addTask(TaskModel task) {
    _repository.addTask(task);
    loadTasks();
  }

  void toggleTaskCompletion(int index) {
    if (index < 0 || index >= _tasks.length) return;

    final task = _tasks[index];
    final updatedTask = TaskModel(
      title: task.title,
      isCompleted: !task.isCompleted,
      description: task.description,
    );

    _repository.updateTask(index, updatedTask);
    _tasks[index] = updatedTask;
    notifyListeners();
  }

  void deleteTask(int index) {
    _repository.deleteTask(index);
    loadTasks();
  }

  void deleteAllCompletedTasks() {
    _tasks.removeWhere((task) => task.isCompleted);
    notifyListeners();
  }
}
