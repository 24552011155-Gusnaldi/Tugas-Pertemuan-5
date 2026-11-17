import 'package:flutter/material.dart';

import 'screens/todo_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const TasklyApp());
}

class TasklyApp extends StatelessWidget {
  const TasklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskly',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const TodoScreen(),
    );
  }
}
