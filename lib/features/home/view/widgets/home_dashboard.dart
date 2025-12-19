import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/core/app_colors.dart';
import 'package:to_do/features/tasks/viewmodel/cubit/task_cubit.dart';
import 'package:to_do/features/tasks/viewmodel/cubit/task_state.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('EEEE, MMMM d').format(now);

    return Container(
      decoration: BoxDecoration(gradient: AppColors.primaryGradient),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is! TaskLoaded) {
                return _loadingDashboard(formattedDate);
              }

              final tasks = state.tasks;

              final todayTasks = tasks.where(
                (t) => _isToday(t.dueDate) && !t.isCompleted,
              );

              final upcomingTasks = tasks.where(
                (t) => t.dueDate.isAfter(
                  DateTime(now.year, now.month, now.day, 23, 59),
                ),
              );

              final completedCount = tasks.where((t) => t.isCompleted).length;

              final completionPercent = tasks.isEmpty
                  ? 0
                  : ((completedCount / tasks.length) * 100).round();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedDate,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    'Good Evening!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    'You have ${todayTasks.length} tasks for today',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 32),

                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          todayTasks.length.toString(),
                          'Today',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          upcomingTasks.length.toString(),
                          'Upcoming',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          '$completionPercent%',
                          'Complete',
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _loadingDashboard(String formattedDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formattedDate,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 16),
        const CircularProgressIndicator(color: Colors.white),
      ],
    );
  }
}
