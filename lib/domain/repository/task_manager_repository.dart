import 'package:dartz/dartz.dart';
import 'package:task_manager_app/data/models/task_model.dart';


/// [TaskManagerRepository] is an abstraction for task management operations.
///
/// This class defines the contract for a concrete implementation of a task
/// manager repository. The repository is responsible for creating,
/// deleting, and fetching tasks.
///
/// The interface defines the following methods:
///
/// - [createTask] creates a new task and returns a [Future] that
///   resolves to an [Either] containing either an [Exception] in
///   the case of an error or [Unit] in case of success.
///
/// - [fetchTasks] fetches all tasks and returns a [Future] that
///   resolves to an [Either] containing either an [Exception] in
///   the case of an error or a [List] of [TaskModel] in case of success.
///
/// - [deleteTask] deletes a task with a specific [id] and returns a
///   [Future] that resolves to an [Either] containing either an
///   [Exception] in the case of an error or [Unit] in case of success.
abstract class TaskManagerRepository {
  /// Creates a new task.
  ///
  /// Returns a [Future] that resolves to an [Either] containing either an
  /// [Exception] in the case of an error or [Unit] in case of success.
  Future<Either<Exception, Unit>> createTask(TaskModel task);

  /// Fetches all tasks.
  ///
  /// Returns a [Future] that resolves to an [Either] containing either an
  /// [Exception] in the case of an error or a [List] of [TaskModel] in case of
  /// success.
  Future<Either<Exception, List<TaskModel>>> fetchTasks();

  /// Deletes a task with a specific [id].
  ///
  /// Returns a [Future] that resolves to an [Either] containing either an
  /// [Exception] in the case of an error or [Unit] in case of success.
  Future<Either<Exception, Unit>> deleteTask(String id);
}
