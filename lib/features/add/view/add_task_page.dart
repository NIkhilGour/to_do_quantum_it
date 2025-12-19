import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/core/app_colors.dart';
import 'package:to_do/core/services/notification_service.dart';
import 'package:to_do/features/tasks/model/task_model.dart';
import 'package:to_do/features/tasks/viewmodel/cubit/task_cubit.dart';

class AddTaskPage extends StatefulWidget {
  final Task? task; // 👈 null = create, not null = edit

  const AddTaskPage({super.key, this.task});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedPriority = 'Medium';
  DateTime _selectedDate = DateTime.now();
  bool _reminderEnabled = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();

    // 🔹 PREFILL DATA FOR EDIT
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _selectedDate = widget.task!.dueDate;

      _selectedPriority = switch (widget.task!.priority) {
        1 => 'Low',
        3 => 'High',
        _ => 'Medium',
      };
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // ---------------- HELPERS ----------------

  int _priorityToInt(String priority) {
    switch (priority) {
      case 'Low':
        return 1;
      case 'High':
        return 3;
      default:
        return 2;
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.task != null;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // 🔹 HEADER
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 50,
              bottom: 20,
            ),
            decoration: BoxDecoration(gradient: AppColors.primaryGradient),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEdit ? 'Edit Task' : 'Create Task',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
          ),

          // 🔹 FORM
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Task Title'),
                  _input(_titleController, 'Enter task title'),

                  const SizedBox(height: 20),
                  _label('Description'),
                  _input(
                    _descriptionController,
                    'Task description',
                    maxLines: 4,
                  ),

                  const SizedBox(height: 20),
                  _label('Priority'),
                  Row(
                    children: [
                      _priorityButton('Low', Colors.green),
                      const SizedBox(width: 12),
                      _priorityButton('Medium', Colors.orange),
                      const SizedBox(width: 12),
                      _priorityButton('High', Colors.red),
                    ],
                  ),

                  const SizedBox(height: 20),
                  _label('Due Date & Time'),
                  InkWell(
                    onTap: () => _selectDateTime(context),
                    child: _dateBox(),
                  ),

                  const SizedBox(height: 20),
                  _reminderSwitch(),
                ],
              ),
            ),
          ),

          // 🔹 FOOTER BUTTON
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isSubmitting
                    ? null
                    : () async {
                        if (_titleController.text.trim().isEmpty) return;

                        setState(() => _isSubmitting = true);

                        final task = Task(
                          id:
                              widget.task?.id ??
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          title: _titleController.text.trim(),
                          description: _descriptionController.text.trim(),
                          priority: _priorityToInt(_selectedPriority),
                          dueDate: _selectedDate,
                          createdAt: widget.task?.createdAt ?? DateTime.now(),
                          isCompleted: widget.task?.isCompleted ?? false,
                        );

                        if (isEdit) {
                          await context.read<TaskCubit>().updateTask(task);
                        } else {
                          await context.read<TaskCubit>().addTask(task);
                        }

                        if (_reminderEnabled) {
                          final reminderTime = DateTime.now().add(
                            const Duration(minutes: 1),
                          );

                          if (reminderTime.isAfter(DateTime.now())) {
                            await NotificationService.scheduleReminder(
                              id: task.id.hashCode,
                              title: 'Task Reminder',
                              body: task.title,
                              scheduledDate: reminderTime,
                            );
                          }

                          // 🔔 Expiry notification
                          await NotificationService.scheduleReminder(
                            id: task.id.hashCode + 1,
                            title: 'Task Due',
                            body: '${task.title} is due now',
                            scheduledDate: task.dueDate,
                          );
                        }

                        if (mounted) {
                          setState(() => _isSubmitting = false);
                          Navigator.pop(context);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      )
                    : Text(
                        isEdit ? 'Update Task' : 'Create Task',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- SMALL WIDGETS ----------------

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    ),
  );

  Widget _input(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _priorityButton(String label, Color color) {
    final isSelected = _selectedPriority == label;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedPriority = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? color : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? color : Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dateBox() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year} '
            '${_selectedDate.hour}:${_selectedDate.minute.toString().padLeft(2, '0')}',
          ),
          const Icon(Icons.calendar_today),
        ],
      ),
    );
  }

  Widget _reminderSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Set Reminder'),
        Switch(
          value: _reminderEnabled,
          onChanged: (v) => setState(() => _reminderEnabled = v),
        ),
      ],
    );
  }
}
