import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:desafio_mobile/data/models/task_model.dart';
import 'package:desafio_mobile/data/repositories/task_repository.dart';
import 'package:desafio_mobile/presentation/viewmodels/task_viewmodel.dart';

import 'task_viewmodel_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late TaskViewModel viewModel;
  late MockTaskRepository mockRepository;

  setUp(() {
    mockRepository = MockTaskRepository();
    viewModel = TaskViewModel();
  });

  test('Inicializa com uma lista vazia', () {
    expect(viewModel.tasks, []);
  });

  test('Adiciona uma nova tarefa', () {
    final newTask = TaskModel(title: 'Nova Tarefa');
    viewModel.addTask(newTask);
    expect(viewModel.tasks.length, 1);
    expect(viewModel.tasks.first.title, 'Nova Tarefa');
  });

  test('Alterna o status de uma tarefa', () {
    final task = TaskModel(title: 'Tarefa Teste', isCompleted: false);
    viewModel.addTask(task);

    viewModel.toggleTaskCompletion(0);
    expect(viewModel.tasks[0].isCompleted, true);
    
    viewModel.toggleTaskCompletion(0);
    expect(viewModel.tasks[0].isCompleted, false);
  });

  test('Remove uma tarefa', () {
    final task = TaskModel(title: 'Tarefa Teste');
    viewModel.addTask(task);
    
    viewModel.deleteTask(0);
    expect(viewModel.tasks.isEmpty, true);
  });
}
