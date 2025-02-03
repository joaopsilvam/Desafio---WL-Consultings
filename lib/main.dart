import 'package:desafio_mobile/data/repositories/task_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'data/models/task_model.dart';
import 'presentation/viewmodels/task_viewmodel.dart';
import 'presentation/views/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await TaskRepository.init();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskViewModel()..loadTasks(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Urbanist',
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
