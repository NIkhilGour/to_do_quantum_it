import '../../../core/services/hive_service.dart';
import '../model/task_model.dart';

class TaskRepository {
  final _box = HiveService.taskBox;

  List<Task> getTasks() {
    return _box.values.toList();
  }

  void addTask(Task task) {
    _box.put(task.id, task);
  }

  void updateTask(Task task) {
    _box.put(task.id, task);
  }

  void deleteTask(String id) {
    _box.delete(id);
  }

  List<Task> search(String query) {
    return _box.values
        .where(
          (task) =>
              task.title.toLowerCase().contains(query.toLowerCase()) ||
              task.description.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  Future<void> toggleTaskStatus(Task task) async {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    _box.put(task.id, updatedTask);
  }
}
