class TodoItem {
  const TodoItem({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  final int id;
  final String title;
  final bool isCompleted;

  TodoItem copyWith({bool? isCompleted}) {
    return TodoItem(
      id: id,
      title: title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
