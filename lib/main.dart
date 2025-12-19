import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/core/services/notification_service.dart';
import 'package:to_do/features/tasks/viewmodel/cubit/task_cubit.dart';

import 'core/services/hive_service.dart';

import 'features/tasks/repository/task_repository.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await HiveService.init();
  // Initialize Local Notification
  await NotificationService.init();
  // Create repository
  final taskRepository = TaskRepository();

  runApp(
    BlocProvider(
      create: (_) => TaskCubit(taskRepository)..loadTasks(),
      child: const MaterialApp(home: MyApp()),
    ),
  );
}
