import 'package:task_manager_app/data/models/task_model.dart';
import 'package:dartz/dartz.dart';


/// A data source abstraction for task management operations.
///
/// This interface defines the contract for a concrete implementation
/// of a data source that provides the necessary functionality for
/// managing tasks. The data source is responsible for creating,
/// deleting, and fetching tasks.
///
/// The interface defines the following methods:
///
/// - [createTask] creates a new task and returns a [Future] that
///   resolves to an [Either] containing either an [Exception] in
///   the case of an error or [Unit] in case of success.
///
/// - [deleteTask] deletes a task with a specific [id] and returns a
///   [Future] that resolves to an [Either] containing either an
///   [Exception] in the case of an error or [Unit] in case of success.
///
/// - [fetchTasks] fetches all tasks and returns a [Future] that
///   resolves to an [Either] containing either an [Exception] in
///   the case of an error or a [List] of [TaskModel] in case of success.
///
abstract class TaskManagerDataSource {
  /// Creates a new task.
  ///
  /// The [task] parameter is the [TaskModel] object representing the
  /// task to be created. The method returns a [Future] that resolves to an
  /// [Either] containing either an [Exception] in the case of an error or
  /// [Unit] in case of success.
  Future<Either<Exception, Unit>> createTask(TaskModel task);

  /// Deletes a task with a specific [id].
  ///
  /// The [id] parameter is the id of the task to be deleted. The method
  /// returns a [Future] that resolves to an [Either] containing either an
  /// [Exception] in the case of an error or [Unit] in case of success.
  Future<Either<Exception, Unit>> deleteTask(String id);

  /// Fetches all tasks.
  ///
  /// The method returns a [Future] that resolves to an [Either] containing
  /// either an [Exception] in the case of an error or a [List] of
  /// [TaskModel] in case of success.
  Future<Either<Exception, List<TaskModel>>> fetchTasks();
}


