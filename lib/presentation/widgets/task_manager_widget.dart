import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/task_model.dart';
import '../bloc/task_manager_bloc.dart';

/// Displays a list of tasks using a `ListView`.
///
/// This widget is responsible for rendering a list of [TaskModel] objects within a scrollable
/// list. Each task is presented in a `Card` widget, which includes the task's title and a
/// delete button that allows users to remove the task.
///
/// Each task card allows for interaction, specifically enabling users to delete tasks from
/// the list. The deletion is handled through the [TaskManagerBloc], demonstrating integration
/// with the app's state management system.
///
/// Attributes:
///   [tasks] - A list of [TaskModel] instances to display.
///
/// Example Usage:
/// ```dart
/// TaskManagerWidget(tasks: taskList)
/// ```
class TaskManagerWidget extends StatelessWidget {
  /// A list of tasks to be displayed.
  final List<TaskModel> tasks;

  /// Initializes a [TaskManagerWidget] with the required [tasks] list.
  ///
  /// The [key] argument is optional and used to control how one widget replaces
  /// another widget in the tree.
  const TaskManagerWidget({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.w600)),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteTask(context, task.id),
            ),
          ),
        );
      },
    );
  }

  /// Triggers the deletion of a task identified by [taskId].
  ///
  /// This method calls the [TaskManagerBloc] to dispatch a [DeleteTaskEvent],
  /// initiating the process to remove the task from the state and, subsequently, the list.
  ///
  /// Parameters:
  /// - [context] - The build context from which the Bloc will be accessed.
  /// - [taskId] - The unique identifier of the task to be deleted.
  void _deleteTask(BuildContext context, String taskId) {
    context.read<TaskManagerBloc>().add(DeleteTaskEvent(id: taskId));
  }
}
