import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/core/utils/sort_type.dart';
import 'package:to_do/features/tasks/viewmodel/cubit/task_cubit.dart';
import 'package:to_do/features/tasks/viewmodel/cubit/task_state.dart';

class AllTaskHeader extends StatelessWidget {
  const AllTaskHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 56, 24, 32),
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          int active = 0;
          int completed = 0;

          if (state is TaskLoaded) {
            completed = state.tasks.where((t) => t.isCompleted).length;
            active = state.tasks.length - completed;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'All Tasks',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // 🔽 SORT MENU
                  PopupMenuButton<SortType>(
                    icon: const Icon(Icons.sort, color: Colors.white),
                    onSelected: (sortType) {
                      context.read<TaskCubit>().sortTasks(sortType);
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: SortType.priority,
                        child: Text('Sort by Priority'),
                      ),
                      PopupMenuItem(
                        value: SortType.dueDate,
                        child: Text('Sort by Due Date'),
                      ),
                      PopupMenuItem(
                        value: SortType.createdAt,
                        child: Text('Sort by Created Date'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '$active active · $completed completed',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
