import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isCompleted;

  TaskModel({required this.title, this.isCompleted = false});
}
