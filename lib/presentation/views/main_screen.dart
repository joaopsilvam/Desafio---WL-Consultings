import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'todo_screen.dart';
import '../../widgets/create_task_modal.dart';
import 'search_screen.dart';
import 'completed_tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ToDoScreen(),
    Container(),
    const SearchScreen(),
    const CompletedTasksScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      _showCreateTaskModal();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showCreateTaskModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const CreateTaskModal(),
    );
  }

  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF007FFF),
        unselectedItemColor: const Color(0xFFC6CFDC),
        selectedLabelStyle: const TextStyle(fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        selectedIconTheme: const IconThemeData(size: 24),
        unselectedIconTheme: const IconThemeData(size: 24),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.list_bullet), label: 'Todo'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.plus_app), label: 'Create'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.checkmark_square), label: 'Done'),
        ],
      ),
    );
  }
}
