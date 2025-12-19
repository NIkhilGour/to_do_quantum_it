import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/features/profile/view/widgets/profile_dashboard.dart';
import 'package:to_do/features/tasks/viewmodel/cubit/task_cubit.dart';
import 'package:to_do/features/tasks/viewmodel/cubit/task_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is! TaskLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final tasks = state.tasks;

          final totalTasks = tasks.length;
          final completedTasks = tasks.where((t) => t.isCompleted).length;
          final activeTasks = totalTasks - completedTasks;

          final completionRate = totalTasks == 0
              ? 0
              : ((completedTasks / totalTasks) * 100).round();

          final now = DateTime.now();
          final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

          final weeklyCreated = tasks
              .where((t) => t.createdAt.isAfter(startOfWeek))
              .length;

          final weeklyCompleted = tasks
              .where((t) => t.isCompleted && t.createdAt.isAfter(startOfWeek))
              .length;

          final highPriority = tasks
              .where((t) => !t.isCompleted && t.priority == 3)
              .length;

          final mediumPriority = tasks
              .where((t) => !t.isCompleted && t.priority == 2)
              .length;

          final lowPriority = tasks
              .where((t) => !t.isCompleted && t.priority == 1)
              .length;

          return SingleChildScrollView(
            child: Column(
              children: [
                const ProfileDashboard(),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              Icons.calendar_today_outlined,
                              '$totalTasks',
                              'Total Tasks',
                              const Color(0xFFDCEAF9),
                              const Color(0xFF3B82F6),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildStatCard(
                              Icons.check_circle_outline,
                              '$completedTasks',
                              'Completed',
                              const Color(0xFFD1FAE5),
                              const Color(0xFF10B981),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              Icons.access_time,
                              '$activeTasks',
                              'Active Tasks',
                              const Color(0xFFF3E8FF),
                              const Color(0xFF9333EA),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildStatCard(
                              Icons.trending_up,
                              '$completionRate%',
                              'Completion Rate',
                              const Color(0xFFDCEAF9),
                              const Color(0xFF6366F1),
                            ),
                          ),
                        ],
                      ),

                      // This Week
                      const SizedBox(height: 16),
                      _buildSection(
                        title: 'This Week',
                        child: Column(
                          children: [
                            _buildWeekRow(
                              'Tasks Created',
                              '$weeklyCreated',
                              Colors.black,
                            ),
                            const SizedBox(height: 12),
                            _buildWeekRow(
                              'Tasks Completed',
                              '$weeklyCompleted',
                              const Color(0xFF10B981),
                            ),
                          ],
                        ),
                      ),

                      // Priority Breakdown
                      const SizedBox(height: 16),
                      _buildSection(
                        title: 'Active Tasks by Priority',
                        child: Column(
                          children: [
                            _buildPriorityRow(
                              'High Priority',
                              '$highPriority',
                              const Color(0xFFEF4444),
                            ),
                            const SizedBox(height: 12),
                            _buildPriorityRow(
                              'Medium Priority',
                              '$mediumPriority',
                              const Color(0xFFF59E0B),
                            ),
                            const SizedBox(height: 12),
                            _buildPriorityRow(
                              'Low Priority',
                              '$lowPriority',
                              const Color(0xFF10B981),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ---------- UI HELPERS (unchanged) ----------

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String value,
    String label,
    Color bgColor,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 15, color: Color(0xFF6B7280)),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPriorityRow(String label, String value, Color dotColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 15, color: Color(0xFF6B7280)),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
        ),
      ],
    );
  }
}
