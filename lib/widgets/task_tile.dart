import 'package:flutter/material.dart';

import '../models/todo_item.dart';
import '../theme/app_theme.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    required this.task,
    required this.onChanged,
    required this.onDelete,
    super.key,
  });

  final TodoItem task;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEDEFEB)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(12, 4, 8, 4),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: onChanged,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          activeColor: AppTheme.green,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            color: task.isCompleted ? AppTheme.muted : AppTheme.ink,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          tooltip: 'Hapus tugas ${task.title}',
          onPressed: onDelete,
          icon: const Icon(Icons.delete_outline_rounded, size: 20),
          color: AppTheme.muted,
        ),
      ),
    );
  }
}
