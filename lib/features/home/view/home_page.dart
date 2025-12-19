import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/core/widgets/no_task_found.dart';
import 'package:to_do/core/widgets/task_card.dart';

import 'package:to_do/features/home/view/widgets/home_dashboard.dart';
import 'package:to_do/features/tasks/view/task_detail_page.dart';
import 'package:to_do/features/tasks/viewmodel/cubit/task_cubit.dart';
import 'package:to_do/features/tasks/viewmodel/cubit/task_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is TaskLoaded) {
          final todayTasks = state.tasks.where(_isToday).toList();
          final upcomingTasks = state.tasks.where((t) => !_isToday(t)).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                const HomeDashboard(),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle('Today', Colors.purpleAccent),
                      const SizedBox(height: 10),

                      if (todayTasks.isEmpty) NoTaskFound(),

                      ...todayTasks.map(
                        (task) => TaskCard(
                          title: task.title,
                          description: task.description,
                          dueDate: _formatDate(task.dueDate),
                          priority: _priorityText(task.priority),
                          isCompleted: task.isCompleted,
                          onComplete: () {
                            context.read<TaskCubit>().toggleCompletion(task);
                          },

                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return TaskDetailPage(task: task);
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 24),

                      _sectionTitle('Upcoming', Colors.blueAccent),
                      const SizedBox(height: 10),

                      if (upcomingTasks.isEmpty) NoTaskFound(),

                      ...upcomingTasks.map(
                        (task) => TaskCard(
                          title: task.title,
                          description: task.description,
                          dueDate: _formatDate(task.dueDate),
                          priority: _priorityText(task.priority),
                          isCompleted: task.isCompleted,
                          onComplete: () {
                            context.read<TaskCubit>().toggleCompletion(task);
                          },
                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return TaskDetailPage(task: task);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  static bool _isToday(task) {
    final now = DateTime.now();
    return task.dueDate.year == now.year &&
        task.dueDate.month == now.month &&
        task.dueDate.day == now.day;
  }

  static String _priorityText(int priority) {
    switch (priority) {
      case 3:
        return 'High';
      case 2:
        return 'Medium';
      default:
        return 'Low';
    }
  }

  static String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _sectionTitle(String title, Color color) {
    return Row(
      children: [
        Icon(Icons.calendar_today, color: color),
        const SizedBox(width: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
