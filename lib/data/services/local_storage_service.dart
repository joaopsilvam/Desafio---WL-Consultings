import 'package:hive/hive.dart';
import '../models/task_model.dart';

class LocalStorageService {
  static late Box<TaskModel> _taskBox;

  static Future<void> init() async {
    Hive.registerAdapter(TaskModelAdapter());
    _taskBox = await Hive.openBox<TaskModel>('tasksBox');
  }

  static List<TaskModel> getAllTasks() {
    return _taskBox.values.toList();
  }

  static Future<void> addTask(TaskModel task) async {
    await _taskBox.add(task);
  }

  static Future<void> updateTask(int index, TaskModel task) async {
    await _taskBox.putAt(index, task);
  }

  static Future<void> deleteTask(int index) async {
    await _taskBox.deleteAt(index);
  }
}
