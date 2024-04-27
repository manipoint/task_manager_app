import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/task_model.dart';
import '../bloc/task_manager_bloc.dart';

/// TaskCreationPage provides a user interface for creating a new task.
/// 
/// This widget displays a form where users can enter the title of a new task
/// and submit it to be added to the task list. It utilizes the `TaskManagerBloc`
/// to handle the state and data flow for creating tasks.
/// 
/// The page consists of a `Form` with a single `TextFormField` for entering the
/// task title, and an 'ElevatedButton' to submit the form. Upon successful validation
/// and submission of the form, a new task with a unique ID is created and added via
/// the bloc event.
///
/// The layout uses padding, column alignment, and custom button styling for a 
/// user-friendly interface.
///
/// See also:
/// * [TaskManagerBloc], which manages the business logic and state of task operations.
/// * [TaskModel], the data model for a task.
class TaskCreationPage extends StatefulWidget {
  const TaskCreationPage({super.key});

  @override
  State<TaskCreationPage> createState() => _TaskCreationPageState();
}/// The state class for [TaskCreationPage].
///
/// This class handles the user interactions and form validation within the
/// [TaskCreationPage]. It maintains a form key for form validation, a text
/// controller for the task title input field, and uses a UUID generator to
/// generate unique identifiers for new tasks.
///
/// Methods:
/// * [_submitForm]: Validates the form and submits the task.
class _TaskCreationPageState extends State<TaskCreationPage> {
  final _formKey = GlobalKey<FormState>(); // Key used for validating the form.
  final TextEditingController _titleController = TextEditingController(); // Controls the text input for the task title.
  final Uuid uuid = const Uuid(); // Generates unique identifiers for tasks.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Task', style: TextStyle(fontWeight: FontWeight.w400)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title'; 
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  height: 48,
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () => _submitForm(context),
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(width: .8),
                      foregroundColor: const Color(0xFF000000),
                      backgroundColor: Colors.green.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Validates the form and submits the task to the bloc if valid.
  ///
  /// Creates a new [TaskModel] with a unique ID and the provided title, then
  /// dispatches a [CreateTaskEvent] to the [TaskManagerBloc]. On successful submission,
  /// navigates back to the previous page.
  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final String newId = uuid.v4();
      final TaskModel newTask = TaskModel(id: newId, title: _titleController.text);
      context.read<TaskManagerBloc>().add(CreateTaskEvent(task: newTask));
      Navigator.pop(context);
    }
  }

  @override
    /// Disposes of the [_titleController] and calls the parent class's `dispose()` method.
    ///
    /// This method is typically called when the widget is no longer needed and will not be rebuilt.
    /// It is responsible for releasing any resources used by the widget, such as disposing of the
    /// [_titleController] to prevent memory leaks. After disposing of the [_titleController], it
    /// calls the parent class's `dispose()` method to ensure that any other resources used by the
    /// parent class are also properly disposed of.
    @override
    void dispose() {
      _titleController.dispose();
      super.dispose();
    }
}

