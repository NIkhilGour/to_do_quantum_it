import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/core/widgets/task_card.dart';
import 'package:to_do/features/add/view/add_task_page.dart';
import 'package:to_do/features/search/view/widgets/emty_state.dart';
import 'package:to_do/features/tasks/viewmodel/cubit/task_cubit.dart';
import 'package:to_do/features/tasks/viewmodel/cubit/task_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),

        Expanded(
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is TaskLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is TaskLoaded) {
                if (_query.isEmpty) {
                  return const EmtyState();
                }

                final results = state.tasks.where((task) {
                  final q = _query.toLowerCase();
                  return task.title.toLowerCase().contains(q) ||
                      task.description.toLowerCase().contains(q);
                }).toList();

                if (results.isEmpty) {
                  return const EmtyState();
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final task = results[index];

                    return TaskCard(
                      title: task.title,
                      description: task.description,
                      dueDate:
                          '${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}',
                      priority: _priorityText(task.priority),
                      isCompleted: task.isCompleted,

                      onComplete: () {},
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AddTaskPage(task: task);
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Search',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            style: const TextStyle(color: Colors.white),
            onChanged: (value) {
              setState(() {
                _query = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search tasks...',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white.withOpacity(0.6),
              ),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  String _priorityText(int priority) {
    switch (priority) {
      case 3:
        return 'High';
      case 2:
        return 'Medium';
      default:
        return 'Low';
    }
  }
}
