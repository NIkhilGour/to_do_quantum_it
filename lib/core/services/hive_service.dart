import 'package:hive_flutter/hive_flutter.dart';
import '../../features/tasks/model/task_model.dart';

class HiveService {
  static const String taskBoxName = 'tasks';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    await Hive.openBox<Task>(taskBoxName);
  }

  static Box<Task> get taskBox => Hive.box<Task>(taskBoxName);
}
