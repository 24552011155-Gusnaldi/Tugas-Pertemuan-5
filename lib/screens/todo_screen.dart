import 'package:flutter/material.dart';

import '../models/todo_item.dart';
import '../theme/app_theme.dart';
import '../widgets/task_tile.dart';

enum TaskFilter { all, active, completed }

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<TodoItem> _tasks = [
    const TodoItem(id: 1, title: 'Review materi kuliah'),
    const TodoItem(
      id: 2,
      title: 'Selesaikan desain aplikasi',
      isCompleted: true,
    ),
    const TodoItem(id: 3, title: 'Baca 10 halaman buku'),
    const TodoItem(id: 4, title: 'Kirim tugas ke dosen'),
  ];

  TaskFilter _filter = TaskFilter.all;
  int _nextId = 5;

  int get _completedCount => _tasks.where((task) => task.isCompleted).length;

  List<TodoItem> get _visibleTasks {
    return _tasks.where((task) {
      return switch (_filter) {
        TaskFilter.all => true,
        TaskFilter.active => !task.isCompleted,
        TaskFilter.completed => task.isCompleted,
      };
    }).toList();
  }

  void _toggleTask(TodoItem task, bool? isCompleted) {
    setState(() {
      final index = _tasks.indexWhere((item) => item.id == task.id);
      if (index != -1) {
        _tasks[index] = task.copyWith(isCompleted: isCompleted ?? false);
      }
    });
  }

  void _deleteTask(TodoItem task) {
    setState(() => _tasks.removeWhere((item) => item.id == task.id));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('"${task.title}" dihapus'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  Future<void> _showAddTaskDialog() async {
    var taskTitle = '';
    final title = await showDialog<String>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Tugas baru'),
          content: TextField(
            autofocus: true,
            maxLength: 80,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              hintText: 'Contoh: Belajar Flutter',
              labelText: 'Nama tugas',
            ),
            onChanged: (value) => setDialogState(() => taskTitle = value),
            onSubmitted: (value) => Navigator.of(context).pop(value),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(taskTitle),
              child: const Text('Tambah'),
            ),
          ],
        ),
      ),
    );

    final trimmedTitle = title?.trim();
    if (trimmedTitle == null || trimmedTitle.isEmpty || !mounted) return;

    setState(() {
      _tasks.insert(0, TodoItem(id: _nextId++, title: trimmedTitle));
      _filter = TaskFilter.all;
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeCount = _tasks.length - _completedCount;
    final progress = _tasks.isEmpty ? 0.0 : _completedCount / _tasks.length;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTaskDialog,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Tugas baru'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildHeader(context),
                      const SizedBox(height: 26),
                      _buildProgressCard(progress, activeCount),
                      const SizedBox(height: 30),
                      _buildTaskHeading(),
                      const SizedBox(height: 14),
                      _buildFilters(),
                      const SizedBox(height: 16),
                      if (_visibleTasks.isEmpty)
                        _buildEmptyState()
                      else
                        ..._visibleTasks.map(
                          (task) => TaskTile(
                            key: ValueKey(task.id),
                            task: task,
                            onChanged: (value) => _toggleTask(task, value),
                            onDelete: () => _deleteTask(task),
                          ),
                        ),
                      const SizedBox(height: 88),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final now = DateTime.now();
    const weekdays = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${weekdays[now.weekday - 1]}, ${now.day} ${months[now.month - 1]}',
                style: const TextStyle(
                  color: AppTheme.muted,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Rencanakan harimu.',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.ink,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFE6F0E8),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.checklist_rounded, color: AppTheme.green),
        ),
      ],
    );
  }

  Widget _buildProgressCard(double progress, int activeCount) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.green,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Progress hari ini',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            activeCount == 0
                ? 'Semua tugas selesai. Kerja bagus!'
                : '$activeCount tugas lagi — kamu pasti bisa!',
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskHeading() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Daftar tugas',
            style: TextStyle(
              color: AppTheme.ink,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Text(
          '$_completedCount/${_tasks.length} selesai',
          style: const TextStyle(
            color: AppTheme.muted,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    const labels = {
      TaskFilter.all: 'Semua',
      TaskFilter.active: 'Belum selesai',
      TaskFilter.completed: 'Selesai',
    };

    return Wrap(
      spacing: 8,
      children: TaskFilter.values.map((filter) {
        final selected = filter == _filter;
        return ChoiceChip(
          label: Text(labels[filter]!),
          selected: selected,
          onSelected: (_) => setState(() => _filter = filter),
          showCheckmark: false,
          labelStyle: TextStyle(
            color: selected ? Colors.white : AppTheme.muted,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          selectedColor: AppTheme.ink,
          backgroundColor: Colors.white,
          side: BorderSide(
            color: selected ? AppTheme.ink : const Color(0xFFEDEFEB),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 38),
      child: Column(
        children: [
          const Icon(Icons.task_alt_rounded, size: 42, color: AppTheme.green),
          const SizedBox(height: 12),
          Text(
            _filter == TaskFilter.completed
                ? 'Belum ada tugas yang selesai'
                : 'Semua tugas sudah beres!',
            style: const TextStyle(
              color: AppTheme.ink,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Tambahkan tugas baru untuk mulai.',
            style: TextStyle(color: AppTheme.muted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
