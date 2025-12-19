import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/core/services/notification_service.dart';
import 'package:to_do/core/utils/sort_type.dart';
import 'package:to_do/features/tasks/viewmodel/cubit/task_state.dart';
import 'package:to_do/features/tasks/model/task_model.dart';
import 'package:to_do/features/tasks/repository/task_repository.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository repository;

  TaskCubit(this.repository) : super(TaskLoading());

  List<Task> _allTasks = [];

  Future<void> loadTasks() async {
    emit(TaskLoading());
    try {
      _allTasks = repository.getTasks();
      emit(TaskLoaded(_allTasks));
    } catch (e) {
      emit(const TaskError('Failed to load tasks'));
    }
  }

  Future<void> addTask(Task task) async {
    repository.addTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await NotificationService.cancel(task.id.hashCode);
    await NotificationService.cancel(task.id.hashCode + 1);
    repository.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(String id) async {
    await NotificationService.cancel(id.hashCode);
    await NotificationService.cancel(id.hashCode + 1);
    repository.deleteTask(id);
    await loadTasks();
  }

  void sortTasks(SortType type) {
    if (state is TaskLoaded) {
      final tasks = List<Task>.from((state as TaskLoaded).tasks);

      switch (type) {
        case SortType.priority:
          tasks.sort((a, b) => b.priority.compareTo(a.priority));
          break;
        case SortType.dueDate:
          tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
          break;
        case SortType.createdAt:
          tasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          break;
      }

      emit(TaskLoaded(tasks));
    }
  }

  Future<void> toggleCompletion(Task task) async {
    await repository.toggleTaskStatus(task);
    await loadTasks();
  }
}
