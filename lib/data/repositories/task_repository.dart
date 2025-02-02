import 'package:hive/hive.dart';
import '../models/task_model.dart';

class TaskRepository {
  final Box<TaskModel> _taskBox = Hive.box<TaskModel>('tasks');

  List<TaskModel> getTasks() => _taskBox.values.toList();

  void addTask(TaskModel task) => _taskBox.add(task);

  void updateTask(int index, TaskModel task) => _taskBox.putAt(index, task);

  void deleteTask(int index) => _taskBox.deleteAt(index);
}
