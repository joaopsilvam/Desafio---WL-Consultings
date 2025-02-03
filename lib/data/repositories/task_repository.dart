import 'package:hive/hive.dart';
import '../models/task_model.dart';

class TaskRepository {
  static late Box<TaskModel> _taskBox;
  static bool _initialized = false; // 🔹 Evita registrar o adapter mais de uma vez

  /// 🔹 Inicializa o Hive apenas uma vez
  static Future<void> init() async {
    if (!_initialized) {
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(TaskModelAdapter()); // 🔹 Registra o adapter apenas uma vez
      }
      _taskBox = await Hive.openBox<TaskModel>('tasksBox');
      _initialized = true;
    }
  }

  /// 🔹 Retorna todas as tarefas salvas localmente
  List<TaskModel> getTasks() {
    return _taskBox.values.toList();
  }

  /// 🔹 Adiciona uma nova tarefa
  Future<void> addTask(TaskModel task) async {
    await _taskBox.add(task);
  }

  /// 🔹 Atualiza uma tarefa existente
  Future<void> updateTask(int index, TaskModel task) async {
    await _taskBox.putAt(index, task);
  }

  /// 🔹 Remove uma tarefa
  Future<void> deleteTask(int index) async {
    await _taskBox.deleteAt(index);
  }
}
