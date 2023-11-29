import 'package:hive_flutter/hive_flutter.dart';

part 'todo_item.g.dart';

@HiveType(typeId: 1)
class TodoItem {
  @HiveField(0)
  final String title;

  bool isCompleted;

  @HiveField(1, defaultValue: false)
  TodoItem(this.title, this.isCompleted);
}
