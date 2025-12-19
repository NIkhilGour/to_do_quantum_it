import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/core/widgets/no_task_found.dart';
import 'package:to_do/core/widgets/task_card.dart';
import 'package:to_do/features/tasks/view/task_detail_page.dart';
import 'package:to_do/features/tasks/view/widgets/all_task_header.dart';
import 'package:to_do/features/tasks/viewmodel/cubit/task_cubit.dart';
import 'package:to_do/features/tasks/viewmodel/cubit/task_state.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AllTaskHeader(),

        Expanded(
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is TaskLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is TaskLoaded) {
                if (state.tasks.isEmpty) {
                  return NoTaskFound();
                }

                return ListView.builder(
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) {
                    final task = state.tasks[index];

                    return TaskCard(
                      title: task.title,
                      description: task.description,
                      dueDate:
                          '${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}',
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
                    );
                  },
                );
              }

              if (state is TaskError) {
                return Center(child: Text(state.message));
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  String _priorityText(int priority) {
    switch (priority) {
      case 3:
        return 'High';
      case 2:
        return 'Medium';
      case 1:
      default:
        return 'Low';
    }
  }
}
