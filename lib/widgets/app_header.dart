import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('images/Logo.png', height: 25),
          const Row(
            children: [
              Text('John', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              CircleAvatar(
                backgroundImage: AssetImage('images/avatar.png'),
                radius: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
