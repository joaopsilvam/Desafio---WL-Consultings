import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _repository = TaskRepository();
  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  void loadTasks() {
    _tasks = _repository.getTasks();
    notifyListeners();
  }

  void addTask(String title) {
    _repository.addTask(TaskModel(title: title));
    loadTasks();
  }

  void toggleTaskCompletion(int index) {
    final task = _tasks[index];
    _repository.updateTask(index, TaskModel(title: task.title, isCompleted: !task.isCompleted));
    loadTasks();
  }

  void deleteTask(int index) {
    _repository.deleteTask(index);
    loadTasks();
  }
}
