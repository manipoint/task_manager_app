// ignore_for_file: public_member_api_docs, sort_constructors_first


part of 'task_manager_bloc.dart';

enum TaskManagerStatus {
  initial,loading,loaded,error
}
/// Represents the state of a task manager in the application.
///
/// This class holds the current status of task operations (such as loading, loaded, etc.),
/// a list of tasks, and an exception message if an error occurs. It extends `Equatable` to
/// facilitate value comparison, which is particularly useful for state management in Flutter.
///
/// Attributes:
///   [status] - The current operation status represented by `TaskManagerStatus`.
///   [tasks] - A list of `TaskModel` objects representing the tasks currently managed.
///   [exception] - A string containing error message information if an error occurs.
class TaskManagerState extends Equatable {
  final TaskManagerStatus status;
  final List<TaskModel> tasks;
  final String exception;

  const TaskManagerState({
    this.status = TaskManagerStatus.initial,
    this.tasks = const [],
    this.exception = '',
  });

  @override
  List<Object> get props => [status, tasks, exception];
    /// Creates a copy of this [TaskManagerState] with the given fields replaced
  /// with the new values. Returns a new instance of [TaskManagerState].
  /// If any of the parameters are not provided, the corresponding fields of
  /// this instance will be used.
  ///
  /// This method is particularly useful for updating the state in a manner
  /// that adheres to the principles of immutability, which is a common practice
  /// in state management for ensuring the predictability and traceability of state changes.
  ///
  /// Parameters:
  /// - [status] (TaskManagerStatus): The new status to update, if different from the current one.
  /// - [tasks] (List<TaskModel>): The new list of tasks to update, if different from the current list.
  /// - [exception] (String): The new error message to update, if different from the current message.
  ///
  /// Returns:
  /// A new instance of [TaskManagerState] with the updated fields, providing an immutable
  /// way to update the state.
  TaskManagerState copyWith({
    TaskManagerStatus? status,
    List<TaskModel>? tasks,
    String? exception,
  }) {
    return TaskManagerState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      exception: exception ?? this.exception,
    );
  }

}
