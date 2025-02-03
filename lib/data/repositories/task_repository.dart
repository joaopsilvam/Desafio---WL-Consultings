import 'package:hive/hive.dart';
import '../models/task_model.dart';

class TaskRepository {
  static late Box<TaskModel> _taskBox;
  static bool _initialized = false;

  static Future<void> init() async {
    if (!_initialized) {
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(TaskModelAdapter());
      }
      _taskBox = await Hive.openBox<TaskModel>('tasksBox');
      _initialized = true;
    }
  }

  List<TaskModel> getTasks() {
    return _taskBox.values.toList();
  }

  Future<void> addTask(TaskModel task) async {
    await _taskBox.add(task);
  }

  Future<void> updateTask(int index, TaskModel task) async {
    await _taskBox.putAt(index, task);
  }

  Future<void> deleteTask(int index) async {
    await _taskBox.deleteAt(index);
  }
}
