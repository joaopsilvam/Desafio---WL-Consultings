import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _repository = TaskRepository();
  List<TaskModel> _tasks = [];
  final int _page = 0;
  final int _limit = 10;

  List<TaskModel> get incompleteTasks => tasks.where((task) => !task.isCompleted).toList();
  List<TaskModel> get completedTasks => tasks.where((task) => task.isCompleted).toList();

  List<TaskModel> get tasks => _tasks;

  void loadTasks() {
    _tasks = _repository.getTasks().take(_limit).toList();
    notifyListeners();
  }

  void deleteAllCompletedTasks() {
    tasks.removeWhere((task) => task.isCompleted);
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
    final task = _tasks[index];
    task.isCompleted = !task.isCompleted;
    _repository.updateTask(
        index, TaskModel(title: task.title, isCompleted: !task.isCompleted));
    loadTasks();
    notifyListeners();
  }

  void deleteTask(int index) {
    _repository.deleteTask(index);
    loadTasks();
  }
}
