import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task_manager_bloc.dart';
import '../widgets/task_manager_widget.dart';
import 'task_creation_page.dart';

/// Represents the home page of the task manager application.
///
/// This stateless widget serves as the main screen where users can view and interact with their tasks.
/// It features an AppBar with a title and an add button, which navigates to the [TaskCreationPage]
/// for adding new tasks. The body of the page uses [BlocBuilder] to reactively update the UI based
/// on the state changes in [TaskManagerBloc].
///
/// The UI displays different widgets based on the state of the task data:
/// - Shows a welcome message when in the initial state.
/// - Displays a loading indicator when tasks are being loaded.
/// - Shows a list of tasks if tasks are successfully loaded.
/// - Displays an error message if there is an issue loading the tasks.
class TaskManagerHomePage extends StatelessWidget {
  const TaskManagerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager', style: TextStyle(fontWeight: FontWeight.w400)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _navigateAndAddNewTask(context),
          ),
        ],
      ),
      body: BlocBuilder<TaskManagerBloc, TaskManagerState>(
        builder: (context, state) {
          switch (state.status) {
            case TaskManagerStatus.initial:
              return const Center(child: Text('Welcome to Task Manager'));
            case TaskManagerStatus.loading:
              return const Center(child: CircularProgressIndicator.adaptive());
            case TaskManagerStatus.loaded:
              return TaskManagerWidget(tasks: state.tasks);
            case TaskManagerStatus.error:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(state.exception),
                ),
              );
            default:
              return const Center(child: Text('Unexpected state encountered'));
          }
        },
      ),
    );
  }

  /// Navigates to the [TaskCreationPage] to allow the user to add new tasks.
  ///
  /// This method is triggered when the user taps the add button in the AppBar.
  /// It pushes the [TaskCreationPage] onto the navigation stack using a MaterialPageRoute.
  void _navigateAndAddNewTask(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const TaskCreationPage(),
      ),
    );
  }
}
